# 12 — Bootstrap (RimWorldWaylith)

**Confidence:** observed (`RimWorldWaylith.Bootstrap`, `ModAssetPackBake`)

## Вход

`Program.Main` → `EngineApplication.Run(..., Bootstrap.Initialize)`.

## Initialize (порядок)

1. `UnityRuntime` поверх `app.Runtime`
2. Official roots для import (`Resources` + OfficialMods)
3. Global mip filter = **Kaiser**
4. `OnUpdate` hook: bake-mode OR normal frame (`EndOfFrame`/`FrameStart`/`UnityRuntime.Update`/audio/composite sat)
5. `Injection.ApplyPendingAtFrameBoundary` на OnUpdate
6. `PrepatcherCompat.Install` + `ModLoadingHooks.AfterAssembliesLoaded`
7. `ShaderWarmup.PrewarmEnabled = !Headless`
8. Register shader sources: `{BaseDirectory}/Rendering/Shaders`
9. Non-headless: window icon, **ConfigureTextureRuntime**, input, window placement, **ConfigureFrameRenderer**
10. Execution orders + RegisterResources (mixer, WorldText prefab)
11. Если `-BakeModAssetPacks=...` → **не** грузим Entry; bake на первом OnUpdate и Quit
12. Иначе `SpawnEntryScene()`

## ConfigureTextureRuntime — критично

```text
TextureResidency.Policy =
  EagerTextureUpload ? OffloadUnderPressure : OnDemand
```

**По умолчанию в RimWorld boot = OnDemand**, даже если поле enum в Waylith инициализировано как `OffloadUnderPressure`.

Также:

- `ConfigureTextureCompression()` — см. ниже
- `GpuTextureService` / `TextureBlockEncoder` / `UnityMeshUploadService` / `VideoDecodeService`
- `HardwareProfile.BeginProbe`
- shutdown: dispose texture/mesh/compute services

## ConfigureTextureCompression

| | |
|--|--|
| Default target | **BC7** (если нет `-texFormat`) |
| `-texFormat` | `bc1`/`dxt1`, `bc4`, `bc5`, `bc7` |
| `-texQuality` | float |
| `AllowBc1` | **false** |
| `RawMaxSize` | **16** |
| `RawPaths` | `"/LUTs/"` only |
| `LoadTimeTarget` | `SelectTarget` |

Совпадает по духу с `ModAssetPacks.BakeSettings` (BC7, no BC1, raw 16).

## Frame features (порядок AddFeature)

1. `ComputeRenderFeature`
2. `WorldRenderFeature` (+ SceneColorTargets)
3. `MapRenderFeature`
4. `CameraCaptureFeature` (+ CameraTextureBaker)
5. `PostFxFeature` (CompositePass; active если map/world active)
6. `ImGuiRenderFeature`
7. `ScreenCaptureFeature`

Layer routing: World* → WorldMain; WaterDepth → WaterDepth; GravshipMask → CaptureOnly; **default → MapMain**.

## Boot complete

Когда `PlayDataLoader.Loaded` и нет LongEvent → `FireBootCompleted`.  
После: на кадре 120 — optional Screenshot/MemoryReport; 180 — QuitAfterBoot.

## Bake CLI

`-BakeModAssetPacks=path1;path2` → `ModAssetPackBake.Run` → для каждого load folder с Textures/Sounds: `ModAssetPacks.BakeForUpload` → `Assets.zip`.
