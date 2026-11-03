# 56 — Designators & Gizmos

**Confidence:** observed (`Designator` : `Command` : `Gizmo`)

## Designator

Architect/order tools on current map:

- `CanDesignateThing` / `CanDesignateCell` → AcceptanceReport
- `DesignateThing` / `DesignateCell`
- Optional DesignationDef, drag sounds, designate-all float menu, reverse designation gizmo
- Tutor tags `Designate-*`

Selected via Command/Gizmo bar (`ProcessInput` → designator manager).

## Gizmo / Command

Colonist/building buttons: `GizmoOnGUI`, groups, shrinkable, `ProcessInput`.  
`Command_Action` / `Command_Toggle` common patterns.

ThingComp: `CompGetGizmosExtra` (note 45).

## Waylith / UI

Still Immediate-mode Verse GUI (ImGui GPU path for some overlays — note 21). Designator cell highlights use GenDraw / mesh paths.
