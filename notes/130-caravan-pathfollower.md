# 130 — Caravan_PathFollower

**Confidence:** observed (`RimWorld.Planet.Caravan_PathFollower`) — expands 72 / 126

World travel state on a caravan: `nextTile` / costs, `WorldPath curPath`, `ArrivalAction`, pause. `StartPath` / `StopDead` / `PatherTickInterval`. Max move ticks 30000; final no-rest push cap 10000.

Uses WorldPathGrid difficulty (per layer). PostLoadInit may repath or StopDead if invalid.

## Modding

- Custom arrival: `CaravanArrivalAction` subclass + StartPath.
- Don’t mutate nextTileCost without understanding CostToPayThisTick (rest/forced march).
