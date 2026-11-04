# 112 — GlowGrid (Burst jobs)

**Confidence:** observed (`Verse.GlowGrid`, `Verse.Glow.*`)

Lighting flood is **Burst + Unity.Jobs**, not classic managed BFS alone:

- `FloodFillerPool`: `NativeArray<GlowUniqueState>` sized to `UnityData.MaxJobWorkerThreadCount`
- `GlowPool` of `LocalGlowArea` (NativeList, growable)
- `CombineColorsJob : IJobParallelFor` merges light contributions over dirty cells
- Register/deregister: glowers, terrain glow, custom glow handles
- Per-frame: `GlowGridUpdate_First`; dirties via `DirtyCell` / light blockers

`[BurstCompile(CompileSynchronously = true)]` on the type.

## Modding

- Custom lights: `CompGlower` / register APIs — don’t write glow arrays from Harmony.
- Job-thread rules (11): no managed alloc inside Burst Execute.
- Dispose tied to `UnityData.DisposeStatic` for the shared flood pool.
