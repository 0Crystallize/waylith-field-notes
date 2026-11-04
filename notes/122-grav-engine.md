# 122 — Building_GravEngine & facilities

**Confidence:** observed (`Building_GravEngine`, `CompGravshipFacility`) — expands 99

## Engine

`Building_GravEngine` : Building, `IRenameable`. Tracks:

- `GravshipComponents` (`CompGravshipFacility` via facility links)
- Substructure sets (valid / all connected; dirty flag)
- `TotalFuel` / `MaxFuel` from components with `providesFuel` + `CompRefuelable`
- `MaxLaunchDistance` ← stat `GravshipRange`
- `LaunchInfo`, cooldown, pawnsToBoard / pawnsToLeave
- Orbital warnings (closed rooms without outdoor temp)
- Jobs: `InspectGravEngine`; gizmos + float menus

Save blocked while gravship cutscene (115).

## Facility

`CompGravshipFacility` : CompFacility. Active only if Odyssey + linked engine in range on valid substructure (or loose connection flag). Max-distance / link events refresh engine component list.

## Modding

- New thruster/fuel/sensor: CompProperties_GravshipFacility + component type def; stay on substructure.
- Don’t bypass `CanBeActive` / substructure checks for launch readiness UI.
