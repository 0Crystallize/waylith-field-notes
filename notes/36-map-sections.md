# 36 — Map sections & draw layers

**Confidence:** observed (`MapDrawer`, `Section`, `MapDrawLayer`, `SectionLayer`, `LayerSubMesh`, `Printer_Plane`)

## Grid

- Section size **17×17** cells (`Section.Size`).
- `MapDrawer.SectionCount` = ceil(mapSize / 17) per axis.
- Dirty via `MapMeshDirty(loc, dirtyFlags)` → section + optional adjacent cells/sections; `globalDirtyFlags` for map-wide layers.

## Two layer kinds

1. **Global** `MapDrawLayer` — all non-`SectionLayer` subclasses of `MapDrawLayer`, constructed with `(Map)` via `AllSubclassesNonAbstract`.
2. **Per-section** `SectionLayer` — every non-abstract `SectionLayer` subclass per section (some gated: sun/edge shadows, Biotech pollution cloud).

`SectionLayer_Dynamic` also drawn for off-view sections via `DrawDynamicSections`.

## Regen / draw

- Per frame first: `MapMeshDrawerUpdate_First` — dirty globals, then `Section.TryUpdate(viewRect)` (one visible dirty section preferred, then scan).
- Draw: globals then overlapping sections (`DrawSection`); off-view still may draw dynamics.
- Gravship render expands view rect when in progress.

## Building geometry

Typical pattern in `Regenerate()`:

```
ClearSubMeshes(...)
Printer_Plane.PrintPlane(layer, center, size, mat, ...)  // or Printer_Mesh / Thing.Print
FinalizeMesh(MeshParts...)
```

`GetSubMesh(material)` keys by material identity.  
`DrawLayer` → `Graphics.DrawMesh(mesh, identity, material, renderLayer)` — goes through Waylith mesh submission (note 17 / 33).

## Modding

- Custom **section** overlay: subclass `SectionLayer`, set `relevantChangeTypes` (MapMeshFlag bits), implement `Regenerate`. Auto-discovered — no registration list.
- Custom **map-wide** overlay: subclass `MapDrawLayer` (not SectionLayer).
- Don’t allocate materials off main thread; regenerations can throw per-layer and log without killing the section.
- Cost: every new SectionLayer type × every section × maps — keep regen cheap; use dirty flags tightly.
