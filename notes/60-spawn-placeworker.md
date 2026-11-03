# 60 — GenSpawn & PlaceWorker

**Confidence:** observed

## GenSpawn

- `Spawn(def|thing, loc, map, rot?, wipeMode)`
- `TrySpawn` / `CanSpawnAt`
- `WipeExistingThings` / `SpawningWipes` / refund helpers
- `SpawnBuildingAsPossible` for load/rebuild
- `respawningAfterLoad` flag changes wipe/leave behavior

WipeMode controls destruction of overlapping things. Prefer TrySpawn when failure is OK.

## PlaceWorker

On BuildableDef `placeWorkers`:

- `AllowsPlacing` → AcceptanceReport
- `DrawGhost` / mouse attachment GUI
- `PostPlace`, `ForceAllowPlaceOver`, affordance display

Runs at designator time — keep cheap; no heavy ContentFinder per-frame without cache.
