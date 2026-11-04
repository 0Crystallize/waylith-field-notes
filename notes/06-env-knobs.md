# 06 — Env knobs

**Confidence:** observed в декомпиле этой ревизии (неполный список — только то, что попало в выбранные типы)

| Variable | Effect (observed) |
|----------|-------------------|
| `WAYLITH_VRAM_BUDGET_MB` | Caps `GraphicsDevice.VramLimitBytes`; residency считает меньший heap; report пишет «capped by WAYLITH_VRAM_BUDGET_MB» |
| `WAYLITH_LOAD_ENCODE` | Load-time encode mode (`GpuTextureService`); lowercased |
| `WAYLITH_NO_ASSET_PREFETCH` | `=1` disables `AssetPrefetcher` |
| `WAYLITH_VULKAN_DEVICE` | Match GPU by name/uuid; ignored if device cannot present; hybrid-GPU warning in log |

## Не env, но публичные рычаги

- `TextureResidency.Policy` = `OffloadUnderPressure` \| `OnDemand`
- `FileLog.CaptureStackTraces` / `FileLog.Disabled`
- `WaylithLogFormatter.EnableStackTraces`
- `TextureCompressionSettings.*` (Target, RawMaxSize, LoadTimeTarget, …)

## Как трогать в экспериментах

Только через **запуск с env** / временный [pack-fixes] на копиях идей — не патчить live DLL в Steam folder. Sandbox DLL — для чтения; runtime всегда live install.
