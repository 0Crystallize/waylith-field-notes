# 02 — Texture residency

**Confidence:** observed (декомпил `TextureResidency`, `TextureResourceManager`, `GpuTextureService`, `AssetPrefetcher`)

## Вердикт для прошлого разговора

**Свой Texture Pool Manager писать незачем как первую идею** — в Waylith уже есть полноценный residency manager:

- `Waylith.Rendering.TextureResidency`
- `Waylith.Rendering.TextureResourceManager` (deferred GPU dispose)
- `Waylith.Rendering.GpuTextureService` (upload, staging, rehydrate)
- `Waylith.Rendering.TextureCacheStore` / AssetBake cache
- `Waylith.Rendering.AssetPrefetcher` (отдельные I/O workers)

Это ближе к «движковый pool + offload», чем к megatexture.

## Политика

```csharp
enum TextureResidencyPolicy { OffloadUnderPressure, OnDemand }
// default: OffloadUnderPressure
```

| Policy | Смысл (observed) |
|--------|------------------|
| `OffloadUnderPressure` | Держать в device-local; при давлении — offload |
| `OnDemand` | Более агрессивная модель «по требованию» |

Публичное: `TextureResidency.Policy` (get/set).

**Важно (RimWorld boot):** `Bootstrap.ConfigureTextureRuntime` ставит  
`OnDemand` по умолчанию, и `OffloadUnderPressure` только при `-EagerTextureUpload`.  
Не путать с initializer поля в Waylith.dll (`= OffloadUnderPressure`) — после Bootstrap он перезаписывается.

## Что можно offload’ить

`IsOffloadable`: только `GpuMemoryCategory.GameTexture` или `Atlas`, и **не** если usage содержит Storage / ColorAttachment / DepthStencil / InputAttachment (pinned RT-like).

UI / Font / RenderTarget / Staging и т.п. — другая категория; residency их так не гоняет.

## Бюджет и watermark’и (device-local)

Константы:

- `MinFreeBytes` = 512 MiB
- `MinHysteresisBytes` = 256 MiB
- `MaxOffloadBytesPerUpdate` = 1 GiB
- max move batch = 256 MiB / 512 textures
- promote scan каждые 10 кадров, recent window ≈ 120 frames

Формулы:

- **High** ≈ `max(budget/2, min(budget*0.8, budget - 512MiB))`
- **Low** ≈ `High - max(budget/10, 256MiB)`

Host (system memory) для offloaded:

- High = `budget/4`, Low = `budget/5`
- cold eviction ≈ 600 frames; on-demand recent ≈ 60 frames

`DeviceLocalHeapBytes` берётся из VMA heap size, опционально capped через `GraphicsDevice.VramLimitBytes` (`WAYLITH_VRAM_BUDGET_MB`).

Бюджет usage читается через DXGI-подобный путь (`WindowsVideoMemory` / heap query) — **observed** типы `SegmentInfo` Budget/CurrentUsage.

## Где крутится

`TextureResidency.Update()` вызывается из **main** `RunLoop` (см. `07-frame-loop.md`).  
`CanRunResidencyWork` = producer(main) ∧ ¬retiring ∧ ¬держит `_sync` GpuTextureService.  
С render thread residency **не** работает — только с main/producer.

## Поведение под давлением

1. `Update()` каждый кадр: trim host → если usage > High → `Offload` до Low (cap 1 GiB/update) → retire deferred disposals  
2. Если usage спокойный и есть offloaded → периодический `Promote`  
3. `MakeRoom(bytes)` перед крупными аллокациями  
4. `VmaAllocationExtensions.OutOfDeviceMemoryHandler = ReclaimForOutOfMemory` — при OOM offload/evict и retry  
5. При переполнении device-local новые GameTextures могут сразу идти в **system memory** (лог один раз: «over budget… go to system memory»)  
6. Host overrun → evict offloaded textures **to disk cache**

Deferred dispose: `TextureResourceManager` держит retirement ≥ submittedFrame+4; `HoldRetirement()` блокирует retire.

## Prefetch (I/O separation — уже есть)

`AssetPrefetcher`:

- workers = `clamp(ProcessorCount/2 - 1, 1, 8)`
- CPU-side hold budget = **64 MiB**
- kinds: Texture / CachedTexture / Audio
- disable: `WAYLITH_NO_ASSET_PREFETCH=1`

Это **не** увеличивает VRAM; это разгрузка decode/I/O. Без residency prefetch только быстрее забивает GPU.

## Bake / compression (не «тупой DDS снаружи»)

Движок сам умеет:

- `TextureBakeSettings` — default target **BC7**, `RawMaxSize=512`, RDO rules, mip filters, `EncodeOnGpu`
- `TextureCompressionSettings` — runtime/load-time encode (`WAYLITH_LOAD_ENCODE`), cache tags
- AssetBake content packs / shader packs

То есть «пережать текстуры» для Waylith часто = попасть в **их** bake/cache pipeline, а не обязательно руками разложить DDS по модам (**inferred** для модпака: ручной DDS всё ещё уменьшает исходный footprint до bake).

## Sparse / Megatexture

В инвентаре типов **нет** PRT/sparse megatexture pager. Есть:

- atlas partitioners (`Brutal…Atlas2DPartitioner`, `TextureArrayPartitioner`)
- staging pool
- residency offload/promote

**observed:** megatexture как идея для модпака здесь не на что опереться.

## Практический вывод

| Идея | Статус на этом билде |
|------|----------------------|
| Свой Texture Pool | Дублирует `TextureResidency` / ResourceManager |
| I/O thread separation | Частично уже `AssetPrefetcher` + render thread |
| Sparse / VT | Нет поверхности в API |
| Уменьшить working set / bake | Всё ещё нужно: residency не спасает, если hot-set > VRAM |
| Крутить Policy / VRAM budget / encode | Имеет смысл исследовать **до** изобретения своего менеджера |
