# 113 — DynamicDrawManager cull jobs

**Confidence:** observed (`Verse.DynamicDrawManager`)

Things with dynamic draw (pawns, projectiles, …) go through a **CullJob** (`IJobParallelFor`, Burst):

Inputs: viewRect, shadowViewRect, fog bitarray, snow/sand depth grid, per-thing `ThingCullDetails` (cell, coarseBounds, seeThroughFog, hideAtSnowOrSandDepth, drawOffscreen, silhouette, sun shadows, TRS).

Outputs: `shouldDraw` / `shouldDrawShadow`.

Fog and depth can cull before mesh submit — fewer DrawMesh calls.

## Modding

- `seeThroughFog` / draw size / snow hide depth come from thing defs / drawers — tune defs, not CullJob IL.
- Silhouette path is part of the same details struct.
- World side: `WorldDynamicDrawManager` (separate).
