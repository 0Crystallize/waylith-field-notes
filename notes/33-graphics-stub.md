# 33 — UnityEngine.Graphics stub → MeshDrawSubmission

**Confidence:** observed

## What works (common)

`DrawMesh` / `DrawMeshInstanced` overloads (Unity Material **or** `Waylith.Rendering.Material`, `MaterialPropertyBlock` or `DrawPropertyBlock`).  
`Blit` / `DrawTexture` / `CopyTexture` — implemented on stubs (verify edge cases; StubWarner otherwise).

Layer argument feeds `LayerPassRouter` → MapMain / WorldMain / WaterDepth / CaptureOnly.

## Flow

```
Graphics.DrawMesh(...)
  → MeshDrawSubmission.Enqueue(MeshDrawCommand)
  → CaptureFrame builds MeshDrawFrame
  → MapMainPass / WorldMainPass records batches
```

Ensure textures resident before draw (`EnsureSampledReady` / EnsureResident) or first use promotes under OnDemand.

## Modding

- Instantiated draws without a camera still need correct **layer** or they land on default MapMain.
- Prefer Verse `Graphics`/`Graphic_*` unless you know the pass routing.
- Instancing uses `EnqueueInstanced` — large matrix lists cost CPU + upload.
