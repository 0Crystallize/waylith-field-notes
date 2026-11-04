# 111 — SectionLayer auto-discovery

**Confidence:** observed (`Verse.Section` ctor) — expands 36

Every `Section` constructs **all** non-abstract `SectionLayer` subclasses via `AllSubclassesNonAbstract` + `Activator.CreateInstance(type, section)`.

Gates in ctor:

- Sun shadows skipped if `map.info.disableSunShadows` or `Biome.disableShadows`
- Edge shadows skipped if `Biome.disableShadows`
- `SectionLayer_PollutionCloud` only if `ModsConfig.BiotechActive`

`SectionLayer_Dynamic` instances also collected for off-view draw.

## Cost model

`O(sectionCount × layerTypeCount)` constructors + regen. Adding a SectionLayer type to any loaded assembly multiplies cost on **every** map section.

## Modding

- Prefer `MapDrawLayer` (global) if overlay doesn’t need per-17×17 mesh.
- Gate expensive layers with `ModsConfig` / def flags inside subclass if needed.
- `relevantChangeTypes` must match `MapMeshFlagDef` bits or layer never dirties.
