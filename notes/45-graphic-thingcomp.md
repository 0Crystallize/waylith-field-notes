# 45 — Graphic draw/print & ThingComp

**Confidence:** observed (`Graphic`, `ThingComp`, `CompProperties`)

## Graphic

- `Init(GraphicRequest)` — subclass fills mats/meshes.
- **Draw path:** `Draw` → `DrawWorker` → `MeshAt` + `MatAt` + `DrawMeshInt` → `Graphics.DrawMesh` (layer 0).
- **Print path:** `Print(SectionLayer, Thing, …)` → `Printer_Plane.PrintPlane` into section mesh (cheaper ongoing).
- Atlas: `TryGetTextureAtlasReplacementInfo` / `TryInsertIntoAtlas`.
- Colored copies via `GraphicDatabase.Get` (`GetColoredVersion` / `GetCopy`).

Choose Print for static map things; Draw for movers / selection / temporary.

## ThingComp

Lifecycle hooks: Initialize, PostSpawnSetup, ticks (normal / Interval / Rare / Long), damage, draw/print, gizmos, inspect, expose.

Draw/print hooks for overlays:

- `DrawAt` / `PostDraw` / `PostDrawExtraSelectionOverlays`
- `PostPrintOnto(SectionLayer)` / `CompPrintForPowerGrid`

XML: `CompProperties` subclass on ThingDef `comps`; `compClass` + fields.

## DefModExtension vs Comp

| | Extension | Comp |
|--|-----------|------|
| On | any Def | ThingWithComps |
| Runtime tick/draw | no | yes |
| Harmony-free data | yes | props + code |

## Waylith

Printed comps still finalize into LayerSubMesh → same MapMain submission. Ensure materials/textures ready; don’t Print from wrong thread.
