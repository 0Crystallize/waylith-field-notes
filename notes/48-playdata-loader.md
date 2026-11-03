# 48 — PlayDataLoader sequence (mod-relevant)

**Confidence:** observed (`PlayDataLoader.LoadAllPlayData` / hot reload)

## High-level order (simplified)

1. Load defs from mods / patches (LongEvent text LoadingDefs)
2. Cross-refs (silent) → implied defs pre-resolve → cross-refs (errors) → `DefDatabase<*>.ResolveAllReferences` (categories/recipes parallel; ThingDef later)
3. `ExecuteWhenFinished(ShaderWarmup.KickPrewarmOnce)`
4. Implied defs post-resolve / more init
5. `ExecuteWhenFinished`: **`StaticConstructorOnStartupUtility.CallAll()`** then **`Material.ResolveAllDeferred()`** (and missing-attribute report in verbose paths)
6. More ExecuteWhenFinished (incl. Log.ResetMessageCount)

`ClearAllPlayData` before reload. `HotReloadDefs` re-runs a similar pipeline inside a LongEvent.

## Why mods care

- Staticctors and MaterialPool work run in **ExecuteWhenFinished** after def resolve — not mid-XML parse.
- Deferred materials (34) resolve here — early graphics before this can see unseeded mats.
- Shader prewarm queued before staticctors in the when-finished chain — ordering between queued actions is FIFO; don’t assume GPU warm complete before your staticctor unless you queue after.
- Errors in ResolveReferences are per-def; pack still loads.

See also notes 13, 14, 16, 38.
