# 01 — Architecture map

**Confidence:** observed (type inventory + selected decomp)

## Слои

```
Mods / Verse / RimWorld (Assembly-CSharp)
        │
        ▼
UnityStubs.dll          ← API «как Unity» (Texture2D, Resources, …)
        │
        ▼
Waylith.UnityCompat     ← UnityWorld / component dispatch / OnGUI
        │
        ▼
Waylith.dll             ← EngineApplication, Rendering, Assets, Jobs, Logging
        │
        ├─ Brutal.Vulkan / Vma / Abstractions (StagingPool, ImageEx, …)
        ├─ Brutal.Texture / Ktx / Gli
        └─ RimWorld.dll (RimWorldWaylith.Rendering.*)  ← MapMainPass, CameraTextureBaker
```

Waylith сидит на **BRUTAL** native bindings (Vulkan), не на полном «движке RocketWerkz».

## Важные namespaces (Waylith.dll)

| Area | Types (примеры) |
|------|-----------------|
| Boot | `EngineApplication`, `EngineWindow`, `WaylithRuntime` |
| Render loop | `FrameRenderer`, `RenderFrame`, `RenderThread`, `IRenderFeature` |
| Textures | `Texture` / `Texture2D`, `GpuTextureService`, `TextureResidency`, `TextureResourceManager`, `TextureCacheStore` |
| GPU mem | `GpuMemoryTracker`, `GpuMemoryReport`, `GraphicsDevice`, `VmaAllocation*` |
| Bake / encode | `TextureBakeSettings`, `TextureCompressionSettings`, BC7/RDO, `Waylith.AssetBake.*` |
| Prefetch | `AssetPrefetcher` (I/O workers) |
| Jobs | `WaylithJobRuntime`, `LoadingScope` |
| Log | `FileLog`, `WaylithLogFormatter`, `RenderLog` |

## RimWorldWaylith render features

**observed** в `RimWorld.dll`:

- `MapRenderFeature` + nested `MapMainPass`
- `WorldRenderFeature` + `WorldMainPass`
- `CameraTextureBaker`, `CameraCaptureFeature`
- `PostFxFeature`, `ImGuiRenderFeature`, offscreen bake

`MapMainPass.Record` в начале вызывает `GpuTextureService.FlushPendingTextureCommands()` — upload и отрисовка карты связаны в одном submit-пути (**inferred:** пик VRAM/upload здесь опасен для TDR).

## Unity stubs vs native

Ludeon в Primer: массово с stubs не уходить.  
Для пака: диагностика/residency — читать `Waylith.*`; игровой код модов — обычно stubs.
