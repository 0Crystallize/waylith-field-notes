# 29 — Shaders: load, prewarm, hot reload

**Confidence:** observed

## Sources

Directory: `{BaseDirectory}/Rendering/Shaders` (GLSL; compiled by Waylith / Slang).  
Env: `WAYLITH_SLANG_COMPILER` may override toolchain.

Legacy: AssetBundle Linux/Vulkan bytecode rewritten on load (`AssetBundleShaders`).

## Prewarm

`ShaderWarmup.KickPrewarmOnce` after defs → `ShaderPrewarmer.WarmInBackground` with variants from MaterialDefs + global keywords.  
Reduces first-hit PSO stalls on map.

## Hot reload

`ShaderHotReloader.Current`:

- `WatchContentShaders` from `-WatchShaders`
- `Watch(dir)`, `Tick()` on PrePoll
- `RequestReload`, `Redefine(...)`, event `ShadersReloaded`

## Modding

- New effects: ship GLSL under game/mod conventions per Primer; expect Vulkan (Linux bytecode) for bundles.
- Keyword explosions hurt prewarm/time-to-first-frame — keep MaterialDef keywords tight.
- Hot reload is a **dev** tool, not a substitute for shipping correct shaders.
