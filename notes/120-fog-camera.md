# 120 — FogGrid & CameraDriver

**Confidence:** observed (`Verse.FogGrid`, `Verse.CameraDriver`)

## Fog

Native-friendly grid (`IDisposable`). Unfog / Refog / FloodUnfogAdjacent (letters optional). Door entry: `Notify_PawnEnteringDoor`. Fog blockers: `Notify_FogBlockerRemoved`. Feeds DynamicDraw cull (113) via NativeBitArray.

## Camera

Map `CameraDriver`: RootSize zoom, `CurrentViewRect`, shaker, `CameraMapConfig`, hitch reduce. Each Update → `SubcameraDriver.UpdatePositions`. GUI: `CameraDriverOnGUI` + config. Constants: StartingSize 24, MinAltitude 15, FullDurationPanDistance 70, MaxDeltaTime 0.1.

Gravship / cutscene may override view (36, 99).

## Modding

- Reveal: FloodUnfogAdjacent / Unfog — don’t poke fog bits raw if disposable native.
- Camera mods: CameraMapConfig subclass or Harmony on driver carefully (also drives subcameras).
