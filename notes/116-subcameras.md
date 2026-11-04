# 116 — Subcameras

**Confidence:** observed (`Verse.SubcameraDriver`, `SubcameraDef`)

One Unity `Camera` per `SubcameraDef`, parented under driver, cullingMask from def layer, depth/clear/background from def. `UpdatePositions` syncs ortho size with main camera and allocates/resizes `RenderTexture` to Screen size (`BestFormat`).

`doNotUpdate` skips RT chase. Used for water/depth/effects / portrait-adjacent paths together with camera bake (104).

## Modding

- New effect camera: `SubcameraDef` XML — layer + format + depth ordering.
- Don’t orphan extra Cameras outside driver; Waylith still expects Unity Camera stubs (24).
