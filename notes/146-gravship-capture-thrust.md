# 146 — Gravship capture, thruster, audio

**Confidence:** observed (`GravshipCapturer`, `CompGravshipThruster`, `GravshipAudio`) — expands 99 / 122

## Capturer

`BeginGravshipRender(engine, onComplete)`, terrain render, world skybox capture. Statics `IsGravshipRenderInProgress` / `GravshipCaptureBounds` (MapDrawer expands view — 36).

## Thruster

Facility subclass: outdoors + not blocked (substructure/thing) or inactive. Static `IsBlocked` / `IsOutdoors` for placement.

## Audio / shield / precept

`GravshipAudio`; shield generator comps; Ideology `Precept_GravshipLaunch` + ritual workers.

## Modding

- Cutscene-safe: respect IsGravshipRenderInProgress / save disable (115).
- Thrusters: placement workers should call IsBlocked/IsOutdoors.
