# 118 — Reachability & region dirty

**Confidence:** observed (`Verse.Reachability`, `RegionDirtyer`) — expands 105 / 63

Reachability caches path-connectedness on the region graph. `RegionDirtyer` marks regions invalid when doors/terrain/buildings change → RegionAndRoomUpdater rebuild → reachability invalidate.

`WorldReachability` is the planet analogue for caravan tiles.

PathFinder (105) uses traverse params + grids; reachability answers “can ever get there” cheaper than full path.

## Modding

- After structural edits: call map notify / dirty APIs — don’t clear Reachability internals.
- Custom doors/passability: implement via PathGrid / traverse modes so both reachability and PathFinder agree.
