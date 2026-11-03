# 40 — Altitudes & GenDraw

**Confidence:** observed

## Altitudes

- 40 `AltitudeLayer` slots, spacing **0.36585367** world Y between layers.
- Fine offset: `AltInc` = **0.03658537** (`AltitudeFor(layer, incOffset)`).
- `AltIncVect` = `(0, AltInc, 0)` for stacking drawings.

Y is draw order / depth for map overlays — wrong altitude → z-fight or under terrain.

## GenDraw

`[StaticConstructorOnStartup]` overlay toolkit: target squares, colored lines, world lines, ritual stencil, interaction cell, fillable bars, etc.

Uses `MaterialPool` + `ShaderDatabase.Transparent` / `MetaOverlay` / world overlay shaders.  
Instancing helper list `instancingMatrices` for batched draws.

## When to use what

| Goal | Prefer |
|------|--------|
| Persistent map mesh (terrain-like) | `SectionLayer` + Printer_* (36) |
| Ephemeral highlight / UI-in-world | `GenDraw` / `Graphics.DrawMesh` in draw pass |
| Thing print into section | `Thing.Print` / graphic print into layer |

Ephemeral draws every frame cost more than baked section meshes; don’t GenDraw entire floors.
