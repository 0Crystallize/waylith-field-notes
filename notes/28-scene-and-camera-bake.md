# 28 — SceneColorTargets & CameraTextureBaker

**Confidence:** observed

## SceneColorTargets

Per-frame-in-flight scene color/depth for Map/World:

- `EnsureSized(framesInFlight, w, h)`
- `Current(frame)` → `RenderTexture`
- `Attachment` / `LoadAttachment` / `BackdropAttachment` — MapMainPass slices / grabs
- `RecordSampleBarrier`, `RecordResolveFrom`

Pinned **RenderTarget** memory — scales with resolution × framesInFlight × (color+depth).  
Large UI scale / 4K + multi-sample paths amplify (**inferred**).

## CameraTextureBaker

Offscreen bake used by portraits / `CameraTextureRenderer.Current`:

- `Render(RT, MeshDrawCommands, CameraView, …)`
- `RenderItems(RT, FinalDrawItems, Camera, …)`
- `TryReadPixels` → CPU RGBA
- `RecordIntoTarget` / `ReleaseTarget`
- event `BeforeReadPixels`

Also feeds ScreenCapture / ImGui material paths.

## Modding

- Custom “render pawn to texture” should go through existing Camera bake APIs when possible.
- Extra offscreen RTs are **not** residency-offloadable — leak/hold carefully.
- Readbacks (`TryReadPixels`) sync GPU — avoid per-frame in hot paths.
