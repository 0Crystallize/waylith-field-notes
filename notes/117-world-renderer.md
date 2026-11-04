# 117 — WorldRenderer

**Confidence:** observed (`RimWorld.Planet.WorldRenderer`) — expands 49

Planet globe layers via `WorldDrawLayer` / `WorldDrawLayerBase`. Dirty regen can run **async coroutine** (`RegenerateDirtyLayersNow_Async`) yielding across frames — LongEvent-friendly.

Camera: `WorldCameraDriver` (separate from map `CameraDriver`). Layer draw still ends in mesh submit / Graphics stubs.

## Modding

- Custom world overlay: subclass WorldDrawLayer (see 49); mark dirty, don’t force sync regen every frame.
- Odyssey planet layers (100) interact with which world features exist per layer.
