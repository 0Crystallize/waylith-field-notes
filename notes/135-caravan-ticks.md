# 135 — CaravanTicksPerMoveUtility

**Confidence:** observed (`RimWorld.Planet.CaravanTicksPerMoveUtility`) — expands 130

`GetTicksPerMove` overloads: live Caravan, CaravanInfo, or raw pawn list + massUsage/capacity (+ `isShuttle`). Feeds PathFollower cost payment rate.

## Modding

- Speed effects: pawn stats / mass that this utility reads — not PathFollower tick alone.
- Shuttle pathing passes `isShuttle: true`.
