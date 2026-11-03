# 87 — Blueprints, frames, ghosts

**Confidence:** observed (`Blueprint_Build`, `Frame`, `GhostUtility`)

## Build flow

Designator → **Blueprint** (ghost plan) → builders create **Frame** → resources delivered → Frame completes → real Building spawned.

`GhostUtility` draws translucent placement previews (materials/colors) for designators and blueprints.

## Modding

- Custom buildables usually inherit this automatically via ThingDef constructibility.
- Special placement: PlaceWorker (60) + designator; ghost draw via GhostUtility / PlaceWorker.DrawGhost.
- Frames hold stuff/cost list — ExposeData matters for unfinished saves.
