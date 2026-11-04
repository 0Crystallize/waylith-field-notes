# 148 — CompLaunchable (PlanetLayer-aware)

**Confidence:** observed (`RimWorld.CompLaunchable`) — expands 84

Fuel + fueling port. Destination chooser takes `PlanetTile` + `TransportersArrivalAction`.

Layer-aware:

- `MaxLaunchDistanceEver(PlanetLayer)`
- `MaxLaunchDistanceAtFuelLevel(fuel, PlanetLayer)`
- `FuelNeededToLaunchAtDist(dist, PlanetLayer)`

`TryLaunch` / `ChoseWorldTarget` / tile float-menu options. `Notify_Arrived`.

Passenger shuttle / transport ship still compose on this + ShipJobs (149).

## Modding

- Cross-layer range: always pass the destination layer into fuel math.
- Custom launchable: subclass CompLaunchable; don’t hardcode surface-only distances.
