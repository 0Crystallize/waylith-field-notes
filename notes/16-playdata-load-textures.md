# 16 — PlayData load ↔ textures

**Confidence:** observed (`PlayDataLoader`, `LoadedModManager`, `ModContentLoader`, `GlobalTextureAtlasManager`)

## Порядок (упрощённо)

```
PlayDataLoader.LoadAllPlayData
  Texture2D.BeginDeferredLoading()          // Waylith
  LoadedModManager.LoadAllActiveMods()
    LoadModContent:
      AssetPrefetcher.EnqueueTextures/Audio // per mod
      ModContentPack.ReloadContent
        ModContentHolder.ReloadAll
          ModContentLoader.LoadAllForMod
            LoadTexture → LoadFromFile / DDS / Compress path
  … defs / resolve …
  LongEvent: ShaderWarmup.KickPrewarmOnce
  … static ctors …
  Material.ResolveAllDeferred()
  GlobalTextureAtlasManager.BakeStaticAtlases()
    … bake pages …
    Texture2D.EndDeferredLoading(LeavesSourceEvicted)
    EvictAtlasSourceTextures()
  GC.Collect + Resources.UnloadUnusedAssets
  ContentPack.DropResidentPages()           // освободить mmap/pages паков
```

Смысл deferred: во время массового Reload моды создают Texture2D **без немедленного** GPU upload всех; EndDeferred — либо upload, либо оставить evicted если текстура ушла в static atlas.

## ModContentLoader

Acceptable texture ext: `.png .jpg .jpeg .psd .dds`

**DDS shadowing:** если есть `foo.dds`, парный `foo.png` (и т.п.) **не грузится**.

Load path:

- `.dds` → `ModDdsLoader.TryLoadDds`
- filesystem → `Texture2D.LoadFromFile` (Waylith stub path)
- иначе bytes → `LoadImage`

Дальше при `Prefs.TextureCompression`:

- non-POT / tiny → warning + clamp mips for DXT
- с compute shaders → `StaticTextureAtlas.FastCompressDXT` после Apply
- без compute → `texture.Compress(true)`

Это **параллельный** legacy compress-путь рядом с `TextureCompressionSettings` BC7 bake — оба могут участвовать (**inferred:** bake/Assets.zip + load-time BC7 важнее для новых пайплайнов; Prefs path всё ещё жив для loose files).

## Prefetch

Перед `ReloadContent` каждого мода:

`AssetPrefetcher.EnqueueTextures(ModContentLoader<Texture2D>.PrefetchPaths(mod))`

Сканирует те же файлы (с DDS shadowing) и греет I/O/decode workers.

## Static atlases

`GlobalTextureAtlasManager`:

- очередь `TryInsertStatic` из graphic init
- `BakeStaticAtlases` режет по `MaxPixelsPerAtlas`, `Bake()`, optional compress
- **source eviction** по умолчанию ON; выкл: `-noEvictAtlasSources`
- atlas compress ON по умолчанию (если не запрещено); выкл: `-noCompressAtlases`
- после bake: `EndDeferredLoading(LeavesSourceEvicted)` — источники, попавшие в atlas, могут остаться без GPU residency
- `GpuTextureService.RetireDeferredDisposalsAfterIdle()` между батчами

## ContentPack pages

`ContentPack.DropResidentPages()` после load — сброс резидентных страниц AssetPack (mmap/cache), чтобы не держать весь bake в RAM после того, как текстуры уже в Texture2D/cache.
