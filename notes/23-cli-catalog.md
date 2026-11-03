# 23 — CLI / env catalog (modding)

**Confidence:** observed in decompile of this pin (not guaranteed exhaustive for ACS).  
Args accepted as `Key`, `-Key`, often `Key=value`.

## RimWorldWaylith.Program / Bootstrap

| Switch | Effect |
|--------|--------|
| `Verbose` | verbose console + VerboseLog |
| `Headless` | headless options; shader prewarm off |
| `SuppressUnityStubs` | StubWarner suppressed |
| `DisableLogStackTraces` | WaylithLogFormatter stacks off |
| `WatchShaders` | shader hot reload watch content |
| `NoFileLog` | FileLog disabled |
| `NoFileLogCallstacks` | FileLog.CaptureStackTraces=false |
| `CrashHandler` | launch crash handler (+ `CrashDumpMini`/`CrashDumpHeap`, `CrashUI`, `CrashCaptureBreakpoints`) |
| `AllowFullscreenExclusive` | allow exclusive FS |
| `NoCrashDialog` | no crash dialog |
| `EagerTextureUpload` | residency `OffloadUnderPressure` (else **OnDemand**) |
| `texFormat=` | bc1/dxt1, bc4, bc5, bc7 (default bc7) |
| `texQuality=` | float |
| `BakeModAssetPacks=` | `;`-separated mod roots; bake Assets.zip & quit |
| `ScreenshotAfterBoot=` | path @ frame ~120 after boot |
| `MemoryReportAfterBoot` | ProcessMemoryReport @ ~120 |
| `QuitAfterBoot` | Root.Shutdown @ ~180 |
| `savedatafolder=` | override save/config root |
| `NoAssetPack` | allow boot without base Assets.zip (dev) |
| `noEvictAtlasSources` | keep atlas source GPU textures |
| `noCompressAtlases` | skip static atlas compress |

## Verse

| Switch | Effect |
|--------|--------|
| `legacy-xml-deserializer` | opt into legacy XML path (LoadedModManager) |

## Waylith EngineSwitches

| Switch / value | Effect |
|----------------|--------|
| `ColdBoot` | ColdBoot.Enabled |
| `TrackRehydration` | GpuTextureService.TrackRehydration |
| `KosmicKrisp` | audio-related option flag |
| `NoWindow` | hide window |
| `BundledVulkanLoader` / `SystemVulkanLoader` | Vulkan loader choice (else Newest) |
| `NoVulkanLayers` | disable implicit layers |
| `NoVulkanFallback` | FallbackDisabled |
| `ResetVulkanFallback` | ResetFallback |
| `texCacheCompression=` | none / zstd / lz4hc / lz4 (default) → GpuTextureService.CacheCodec |
| `TargetFrameRate=` | int override (0+ ) |
| `WindowSize=` | int2; locks size |
| `WindowPos=` | int2; locks position |

## Environment

| Env | Effect |
|-----|--------|
| `WAYLITH_VRAM_BUDGET_MB` | cap device-local heap for VMA/residency |
| `WAYLITH_VULKAN_DEVICE` | pick GPU by name/uuid |
| `WAYLITH_LOAD_ENCODE` | `gpu`/`verify` → GPU load-time encode |
| `WAYLITH_NO_ASSET_PREFETCH` | `1` disables AssetPrefetcher |
| `WAYLITH_SLANG_COMPILER` | slang compiler path/override (string present in engine) |

## Prefs (not CLI, but related)

`Prefs.TextureCompression` (default true) — ModContentLoader DXT/FastCompress path for loose textures.  
`Prefs.PlantWindSway` — plant materials.

## Notes for modders

- Prefer **Assets.zip bake** + engine BC7 over fighting Prefs DXT.
- `-EagerTextureUpload` changes residency policy globally — measure before recommending to users.
- `-NoFileLogCallstacks` is the supported way to cut stack capture cost.
- `savedatafolder` useful for parallel CI / pack test profiles.
