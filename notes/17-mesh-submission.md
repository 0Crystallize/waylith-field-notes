# 17 — Mesh submission path

**Confidence:** observed (`MeshDrawSubmission`, `UnityMeshUploadService`, `MeshUploader`, Bootstrap PrePoll)

## Кадр (main)

Bootstrap `PrePollEvents`:

1. `GraphicsDevice.MeshUploads.BeginFrame(frameCount)`
2. `MeshDrawSubmission.BeginFrame(device, renderContext)` — clear commands / arenas
3. Input / IME

Игра/Verse рисует → stub `Graphics`/MeshRenderer → enqueue `MeshDrawCommand` в `MeshDrawSubmission`.

`LayerPassRouter.Resolve(layer)` → pass id (MapMain / WorldMain / WaterDepth / …).

## Upload mesh GPU

`UnityMeshUploadService.Upload(mesh)` → `GraphicsDevice.MeshUploads.Enqueue(mesh)`.

Wiring в `EngineApplication.ConfigureGpuServices`:

- `Mesh.UploadRequested` / `ReleaseRequested` → MeshUploads
- на `RenderThreadFrameStarting`: `MeshUploads.BeginRenderFrame` (+ GpuTextureService / Compute)

Отдельный uploader (`MeshUploader`) — staging/GPU buffers, не путать с texture `GpuTextureService`.

## Capture → render

Main: features/`CaptureFrame` собирают `MeshDrawFrame` из pending submissions.  
Render thread: `MeshBatchRenderer` / `VulkanMeshDrawEncoder` record в pass.

`ClearFrameSubmissions` — headless / focus path.

## Связь с TDR

Тяжёлый кадр = много unique materials/textures **и** mesh uploads **и** `FlushPendingTextureCommands` в MapMain.  
Mesh path сам по себе реже «съедает VRAM» как GameTexture set, но добавляет submit latency (**inferred**).
