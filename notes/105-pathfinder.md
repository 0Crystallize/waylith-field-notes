# 105 — PathFinder (1.7 jobs)

**Confidence:** observed (`Verse.PathFinder`, `RegionAndRoomUpdater`)

## PathFinder

Not a simple sync A* wrapper anymore — uses **Unity.Jobs**-style path requests:

- `PathRequest` + `JobHandle` / `PathJobOutput`
- Map grid cache keyed by `MapGridRequest` (traverse params, cost tuning, customizer, allowed Area, AvoidGrid)
- `UnmanagedGridTraverseParams` from `TraverseParms` (bash fences, fog, darkness, buildable rect, …)

Dispose with map. Prefer `pawn.pather` / `TraversalUtility` / reachability helpers (63) over new PathFinder internals.

## Regions

`RegionAndRoomUpdater` still rebuilds region graph when dirty; PathFinder sits on top of map grids + region links.

## Modding

- Custom path costs: PathFinderCostTuning / area / avoid grid / traverse mode — not Harmony inside job.
- Jobs that path every tick: cache PathRequests carefully; watch job worker thread rules (11, 44).
- Multi-map: each map has its own PathFinder data.
