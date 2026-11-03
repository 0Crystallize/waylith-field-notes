# 85 — Mechanitor (Biotech)

**Confidence:** observed (`Pawn_MechanitorTracker`)

Per-pawn tracker for mechanitor bandwidth, controlled mechs, groups (`MechanitorControlGroup`), remote control range.

Mechs are pawns with mech ThingDefs; work/combat via duties and mechanitor assignments. Bandwidth from implants/buildings.

## Modding

- New mech: PawnKind/ThingDef mech + work types + optionally custom CompMech*.
- Bandwidth/control: extend carefully — softcap UI assumes tracker math.
- Verbs on mechs still VerbTracker (73, 78); controlGroup appears on Verb.
