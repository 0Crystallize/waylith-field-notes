# 99 — Gravship capture & cutscene render

**Confidence:** observed (`WorldComponent_GravshipController`, `GravshipRenderer`, `SectionLayer_GravshipMask`, `SectionLayer_GravshipHull`, `GravshipUtility`)

## Flow

1. **Takeoff:** `InitiateTakeoff(engine, targetTile)` → `GravshipCapturer.BeginGravshipRender` → on complete pan/zoom → `GravshipRenderer.BeginCutscene` + audio
2. **Landing:** `InitiateLanding(gravship, map, pos, rot)` → optional skybox curtain → capture → cutscene
3. While cutting: `GravshipRenderInProgess` / `GravshipRenderBounds` expand map draw view (note 36 MapDrawer)
4. Prefs: `gravshipCutscenes` (note 39); camera `gravshipPanOnCutsceneStart`

## GravshipRenderer

Uses `Capture` (baked look of ship): DrawBatch, distortion / downwash / shadow / thruster flames (renderQueue 3201), lens flare, engine glow, indoor mask LayerSubMeshes, exhaust flecks.

`UpdateTakeoff` / `UpdateLanding(progress)` interpolate altitude & effects; `EndUpdate` forces fleck draw.

Materials under `Map/Gravship/*` (+ FakeTerrain curtain).

## Masks / hull

- `SectionLayer_GravshipMask` — static Engine + OverrideMode (None/Shadow/Gravship); bake shadow masks from substructure cells
- `SectionLayer_GravshipHull` — map mesh for hull visuals
- Valid substructure from `Building_GravEngine`

## Utility

Connected substructure colors, pre-launch confirmation (left-behind pawns/buildings), gen steps for wreckage / reserve area, player engine lookup, launch quality curves → landing outcomes.

## Modding

- New facilities: `CompGravshipFacility` / thruster props + PlaceWorkers.
- Cutscene FX: materials/shaders Gravship path; don’t assume MapMain alone — capture → skyfaller altitudes.
- Launch rituals: Precept_GravshipLaunch + RitualBehaviorWorker (71, 80).
- While `GravshipRenderInProgess`, map mesh dirty/view expansion — avoid fighting capturer bounds.
