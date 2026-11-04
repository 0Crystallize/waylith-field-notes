# 10 — CLI switches & knobs (расширение)

**Confidence:** observed (`RimWorldWaylith.Program`, `GraphicsDevice`, …)

Раньше в `06-env-knobs.md` — env. Здесь — **официальные** стартовые свитчи из `Program.Main` (+ уточнения).

## CLI (args, `-Name` / `+Name`)

| Switch | Effect |
|--------|--------|
| `Verbose` | verbose console filter + `VerboseLog` |
| `Headless` | headless engine options |
| `SuppressUnityStubs` | `StubWarner.Suppressed` |
| `DisableLogStackTraces` | `WaylithLogFormatter.EnableStackTraces = false` (**default formatter flag is already false**; FileLog stacks — отдельно) |
| `WatchShaders` | `Bootstrap.WatchShaders` |
| `NoFileLog` | `FileLog.Disabled = true` |
| `NoFileLogCallstacks` | `FileLog.CaptureStackTraces = false` |
| `CrashHandler` | external crash handler (+ `CrashDumpMini` / `CrashDumpHeap`, `CrashUI`, `CrashCaptureBreakpoints`) |
| `AllowFullscreenExclusive` | разрешает exclusive FS (иначе `DisallowFullscreenExclusive=true`) |
| `NoCrashDialog` | без crash dialog |
| `EagerTextureUpload` | `TextureResidency.Policy = OffloadUnderPressure` (иначе **OnDemand**) |
| `texFormat=` | runtime block compress: bc1/dxt1, bc4, bc5, bc7 (default bc7) |
| `texQuality=` | float quality for compression |
| `BakeModAssetPacks=` | `path;path` — bake Assets.zip и выйти (без нормального boot) |
| `ScreenshotAfterBoot=` | path; кадр ~120 после boot complete |
| `MemoryReportAfterBoot` | `ProcessMemoryReport.Log` на кадре ~120 |
| `QuitAfterBoot` | shutdown на кадре ~180 |
| `noEvictAtlasSources` | не выселять source-текстуры после static atlas bake |
| `noCompressAtlases` | не жать static atlas pages |

**khatum note:** [pack-fixes] глушил `CaptureStackTraces` костылём; upstream уже даёт `-NoFileLogCallstacks`. Имеет смысл предпочитать CLI/официальный путь, когда проверяем без [pack-fixes].

Также (из wiki/primer, не из этого декомпила): `-mod=id1,id2` — проверить в Bootstrap/`GenCommandLine` отдельно при необходимости.

## Env (повтор + уточнения)

| Env | |
|-----|--|
| `WAYLITH_VRAM_BUDGET_MB` | positive MB → `VramLimitBytes`; VMA `PHeapSizeLimit`; residency caps heap |
| `WAYLITH_VULKAN_DEVICE` | match by name/uuid substring; hybrid-GPU warning если present невозможен |
| `WAYLITH_LOAD_ENCODE` | `gpu` / `verify` → GPU encode; иначе CPU path |
| `WAYLITH_NO_ASSET_PREFETCH` | `1` disables prefetch workers |

`GraphicsDevice.CreateAllocator`: large heap block 64 MiB; `ExtMemoryBudgetBit` если budget extension доступен.

## Runtime properties

- `TextureResidency.Policy`
- `GpuTextureService.TextureCacheWrites`, `TrackRehydration`, `WantsBorderMipMaps`
- `EngineApplicationOptions.VramWarnCapBytes` → `GpuMemoryReport.CheckUsageCap` каждый кадр
