# 149 — ShipJob & pocket maps

**Confidence:** observed (`ShipJob`, `PocketMapParent`, `MapParent`) — expands 84

## ShipJob

Abstract jobs on `TransportShip`: TryStart / TickInterval / End, gizmos, interruptible, destination flag. Defs via ShipJobDef (`ShipJob_Wait`, …).

## Pocket maps

`PocketMapParent`: holds `sourceMap` + `MapGeneratorDef`. Map exposes child pocket maps; exit building `PocketMapExit`. `Verse.PocketMapUtility` / `PocketMapProperties` generate & dispose pocket maps from a parent.

## MapParent Odyssey

`Abandon(wasGravshipLaunch)` can spawn `GravshipLaunch` world object on surface. Inspect string for named gravship on tile. `wasSpawnedViaGravShipLanding` / `BeingTransportedOnGravship` flags.

## Modding

- Shuttle sequences: ShipJob subclasses + TransportShip.
- Pocket encounter: PocketMapParent + generator; link exit back to sourceMap.
