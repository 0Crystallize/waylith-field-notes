# 44 — UnityData & LongEvent (modding contract)

**Confidence:** observed (complements notes 05, 11, 15)

## UnityData

`CopyUnityData()` snapshots mainThreadId, paths, platform, job worker counts, compute-shader eligibility.

`IsInMainThread` — gate for ContentFinder, MaterialPool, GraphicDatabase, Prefs.Apply, many Unity stub calls.

Compute shaders: needs `supportsComputeShaders`, VRAM > 5000 MB, not integrated Intel/AMD heuristics, and no `-disable-compute-shaders`.

`DisposeStatic` event — register cleanup for static Unity objects.

## LongEventHandler

Queue: sync Action, IEnumerable (enumerator stepped on main), or async Action on **background thread** (`doAsynchronously`).

Also: `ExecuteWhenFinished`, `SetCurrentEventText`, force pause while any event waiting.

## Waylith / mod dangers

- Async LongEvent thread ≠ full Unity main thread: no ContentFinder/MaterialPool/most Graphics; thin stack + FileLog callstacks (notes 04, 15).
- Prefer sync LongEvent or `ExecuteWhenFinished` for asset work.
- Don’t nest heavy Harmony patches that allocate GPU resources inside async load events.
