# 131 — Architect tab & LinkGrid

**Confidence:** observed (`ArchitectCategoryTab`, `Verse.LinkGrid`)

## Architect

Category tab draws `def.ResolvedAllowedDesignators` via `GizmoGridDrawer` with search highlight/lowlight + info box (270px). `preferredColumn` from DesignationCategoryDef. `CacheSearchState` for quick search.

## LinkGrid

Per-cell `LinkFlags` OR of all things’ `graphicData.linkFlags` on that cell. Updated on linker create/destroy. Feeds linked graphics (walls, fences, …).

## Modding

- New architect category: DesignationCategoryDef + designators; tab auto-builds.
- Custom linkable graphic: set linkFlags / linkType on GraphicData; LinkGrid picks it up — no manual grid write.
