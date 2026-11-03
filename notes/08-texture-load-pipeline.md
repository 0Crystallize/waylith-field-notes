# 08 — Texture load pipeline

**Confidence:** observed (`Texture2D` Waylith + Unity stubs, `GpuTextureService`, `TextureCacheStore`)

## Два «Texture2D»

1. `UnityEngine.Texture2D` (UnityStubs) — то, что видит Verse/моды  
2. `Waylith.Rendering.Texture2D` — реальный GPU/CPU объект  

`UnityEngine.Texture.CoreTexture` → `Waylith.Rendering.Texture` (у base stub virtual null; у `Texture2D` stub — реальная связка).  
Dispose stub’а зовёт `CoreTexture?.Dispose()`.

## Пути появления текстуры

| Путь | Суть |
|------|------|
| `LoadFromFile` | файл / pack → metadata + optional upload |
| `LoadFromTextureCache` | cache hit |
| `CreateSolid` / placeholder | tiny GPU textures |
| `CreateRenderTarget` | RT (pinned, не offloadable) |
| Decode failure placeholder | битый файл не валит всё |

## Deferred loading

```
BeginDeferredLoading()
… создаются Texture2D «metadata only»
EndDeferredLoading(stayEvicted)
```

При OnDemand: лог «metadata only… load on first use».  
Иначе: пытается `TryUploadFromCache` для пачки; если device-local high — часть остаётся on-demand.

`EnsureResident()` → cache → source → GPU alloc/upload.

## Eviction (CPU/GPU soft)

- `Evict()` / `TryEvictForResidency`
- `EvictWhenCached` → очередь; `DrainPendingEvictions` (cap 8192/drain, max 600 attempts)
- Условие: валидный texture cache той же WxH, иначе не выкидывает вслепую

Связка с `TextureResidency`: offload двигает **память image** (device↔host↔disk cache); `Evict` на Texture2D — уровень «сбросить резидентность объекта, если cache есть».

## Upload batching

`GpuTextureService`:

- staging buffer pool + fence pool  
- `BeginUploadDeferral` / `EndUploadDeferral` — копят команды  
- `FlushPendingTextureCommands` — no-op если ещё deferred; иначе submit + deferred disposals + pending CPU/GPU mipgen  
- `MapMainPass` и другие горячие места зовут Flush явно  

`WAYLITH_LOAD_ENCODE`:

- `gpu` / `verify` → encode on GPU at load  
- иначе CPU / rules из `TextureCompressionSettings`

## Texture cache store (disk)

`TextureCacheStore`:

- pack’и на диске (zip-like / asset pack pages), keyed packs per `InstallId`
- writer pool: `clamp(ProcessorCount/4, 1, 4)`
- `TryOpen` / `StoreLater` / `StoreKeyed` / `FlushAll` / stale sweep
- codecs через `AssetPackCodec`

Это и есть «disk cache», куда residency **evict’ит** offloaded host textures при переполнении system watermark.

## Prefetch

`AssetPrefetcher.EnqueueTextures` греет decode/cache **до** EnsureResident; hold ≤ 64 MiB; workers 1..8.  
Отключается `WAYLITH_NO_ASSET_PREFETCH=1`.

## Практическая схема для пака

```
Mod Textures/…png
    → (optional) ModAssetPacks.Bake → Assets.zip (BC7 etc.)
    → ContentPacks.MountLoadFolder
    → LoadFromFile / ContentPack read
    → TextureCacheStore (runtime cache)
    → GpuTextureService upload (possibly deferred)
    → TextureResidency manages device-local working set
```

Узкое место пака: слишком большой **simultaneous hot-set** (много уникальных sampled textures на экране/в UI) + flush на первом MapMain.
