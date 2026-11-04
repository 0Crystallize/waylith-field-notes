# 98 — Mesh upload (Waylith)

**Confidence:** observed (`MeshUploader`, `UnityMeshUploadService`)

## Path

Stub `Mesh` finalize / section cook → `UnityMeshUploadService.Upload(mesh)` → `GraphicsDevice.MeshUploads.Enqueue(mesh)`.

`MeshUploader`:

- Per-frame `BeginFrame` / `BeginRenderFrame`
- `Enqueue` vs immediate `Upload`
- **Deferral**: `BeginUploadDeferral` / `EndUploadDeferral` / `DrainPendingUploads` (batch during heavy regen)
- Vulkan staging + fence retirement queues (`framesInFlight`)
- `Release(mesh)` returns GPU buffers

## Bake-time meshes

AssetBake ContentPass can pack mesh sources (OBJ default parser; host may override `ParseMesh` — e.g. nbmesh). Runtime map section meshes still go through MeshUploader, not Assets.zip, unless authored as pack entries.

## Modding

- SectionLayer / Printer_* finalize → MeshUploader (notes 17, 36). Huge regen spikes → deferral windows matter for hitching.
- Don’t hold Mesh references after map Dispose without Release path (MapDrawer.Dispose destroys meshes).
- Custom GPU mesh APIs: prefer Verse Graphics.DrawMesh (33) unless you own Waylith Mesh types.
