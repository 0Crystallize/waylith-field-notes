# 88 — Sketch / SketchGen

**Confidence:** observed (type catalog: `RimWorld.Sketch`, `RimWorld.SketchGen.*`)

## Sketch

Serializable structure of SketchThing / SketchTerrain / entities — a blueprint of geometry used by monument, mech cluster, ancient rooms, gravship pieces.

## SketchGen

`SketchResolver_*` pipeline: FloorFill, AddWallEdgeThings, AssignRandomStuff, DamageBuildings, MechCluster, Monument, Gravship, ancient room kits, Cerebrex, etc.

`SketchGen` / `SketchGenUtility` orchestrate resolvers from `SketchResolverDef`.

## Modding

- Custom structure gen: new SketchResolver + def, or compose existing resolvers.
- Prefer resolvers over hand-placing hundreds of cells in incidents.
- Stuff assignment and light damage resolvers give ruins “lived-in” look cheaply.
