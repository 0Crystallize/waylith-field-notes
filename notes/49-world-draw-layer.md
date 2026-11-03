# 49 — WorldDrawLayer

**Confidence:** observed (`RimWorld.Planet.WorldDrawLayer` / base)

## Role

Planet view meshes (terrain, roads, pollution, objects, …) — parallel idea to map `SectionLayer`, but world-scoped and often **coroutine-style** `Regenerate()` yielding (`IEnumerable` / state machine) to spread work.

Subclass `WorldDrawLayer` (or `GlobalDrawLayer_*` for sun/stars). Auto-discovered like map layers.

## Modding

- Custom planet overlay: subclass, implement regenerate/draw via base helpers (submeshes / materials with World* shaders from ShaderDatabase).
- Yield in Regenerate for large geometry — don’t block the planet UI for seconds.
- Materials: `ShaderDatabase.WorldOverlay*` / WorldTerrain — note 37.
- Dirty/regen triggers differ from MapMeshFlag — follow existing layer patterns when porting.

Map vs world:

| | Map | World |
|--|-----|-------|
| Grid | Section 17 | Tiles / spheres |
| Layer base | MapDrawLayer / SectionLayer | WorldDrawLayerBase |
| Pass | MapMain | WorldMain (notes 07, 28, 33) |
