# 110 — EngineApplication lifecycle extras

**Confidence:** observed (`Waylith.EngineApplication`) — expands 07 / 12

## Wiring

- Mesh: `GraphicsDevice.MeshUploads.Enqueue` / `Release` hooked as handlers; `FrameRenderer.RenderThreadFrameStarting` → `MeshUploads.BeginRenderFrame` + `GpuTextureService.BeginRenderFrame`.
- Single `Instance`; `OnUpdate` / `OnShutdown` callbacks from game bootstrap.
- Events: `PrePollEvents`, `BeforeGraphicsShutdown`, `FrameEnqueued`.

## Focus / audio

Unfocused + not `RunInBackground` → `AudioBackend.SetOutputPaused(true)`, idle via `Glfw.WaitEventsTimeout(0.1)` — **skips** residency/update/capture for that iteration.

## Shutdown

`RequestShutdown(reason)` / `Quit(exitCode)`; detach mesh wiring; dispose render thread. `WaitForRenderThreadIdle` for bake/CLI paths that need GPU quiet.

## Modding

- Don’t spawn parallel “main loops”; hook `OnUpdate` only via game Root.
- Background tools using `-NoWindow` still run Capture when framebuffer allows; focus-idle still applies unless RunInBackground.
- Hardcoded upstream source paths appear in log sites (Ludeon build tree) — ignore for pack paths.
