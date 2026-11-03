# 68 — Rooms & beauty (pointer)

**Confidence:** observed (type sizes / BeautyUtility)

## Room

`Verse.Room` — large; regions, roles, stats (cleanliness, wealth, impressiveness…), owners. Rebuilds with region dirty.  
Mods reading room stats: use RoomRoleWorker / RoomStatDef rather than parsing cells each tick.

## BeautyUtility

Helpers for beauty cell scores used by needs/thoughts. Custom beauty: StatParts / Thing beauty fields / terrain.

## Tip

Don’t cache Room references across ticks without invalidation — rooms recompose.
