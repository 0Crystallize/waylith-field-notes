# 104 — Layer passes, PostFx, water depth, camera bake

**Confidence:** observed (`LayerPassRouter`, `PostFxFeature`, `WaterDepthTargets`, `CameraTextureBaker`)

## LayerPassRouter

`RegisterLayerMask(layerMask, passId)` / `SetDefault` / `Resolve(layer)` → which render pass gets `Graphics.DrawMesh` layer (note 33). Max 8 registrations.

## PostFxFeature

Implements `IRenderFeature`: single `CompositePass` when scene active; resizes `SceneColorTargets` with frames-in-flight.

## WaterDepthTargets

R16_SFLOAT offscreen target + render pass; `EnsureSized`; exposes Texture for sampling; `MarkSampleable` sets shader-read layout. Feeds water shaders / depth effects.

## CameraTextureBaker

`ICameraTextureRenderer`: render MeshDrawCommands or FinalDrawItems into a Unity `RenderTexture` (Vulkan FB/RP per target).  
`TryReadPixels` → RGBA byte[] (portraits / icons / bake-to-texture).  
`BeforeReadPixels` event. One-time submit command buffers + fence.

Used for camera→RT paths (note 28). Heavy; don’t spam every frame for many RTs.

## Modding

- Wrong DrawMesh **layer** → wrong pass (MapMain vs World vs water). Prefer Verse graphics helpers.
- Portrait mods: go through existing camera bake APIs, not raw Vulkan.
