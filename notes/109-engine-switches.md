# 109 — EngineSwitches (CLI → options)

**Confidence:** observed (`Waylith.CLI.EngineSwitches`) — expands 10 / 23

Applied early onto `EngineApplicationOptions`:

| Switch / value | Effect |
|----------------|--------|
| `ColdBoot` | `ColdBoot.Enabled` |
| `TrackRehydration` | `GpuTextureService.TrackRehydration` |
| `KosmicKrisp` | mac path option |
| `NoWindow` | `HideWindow` |
| `BundledVulkanLoader` / `SystemVulkanLoader` | `VulkanStartup.LoaderChoice` (else Newest) |
| `NoVulkanLayers` | disable implicit layers |
| `NoVulkanFallback` / `ResetVulkanFallback` | fallback policy |
| `texCacheCompression=` none\|zstd\|lz4hc\|lz4 | `GpuTextureService.CacheCodec` |
| `TargetFrameRate=` int | `EngineWindow.TargetFrameRateOverride` |
| `WindowSize=` / `WindowPos=` int2 | lock initial window |

Game-side switches (`-BakeModAssetPacks=`, texture residency, …) live elsewhere (GenCommandLine / EnvironmentCommandLine / note 23). This class is **engine-only**.
