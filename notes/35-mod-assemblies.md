# 35 — Mod assemblies

**Confidence:** observed (`ModAssemblyHandler`) + prior Harmony notes

## Load

`ModAssemblyHandler.ReloadAll`: `GetAllFilesForModPreserveOrder(..., "Assemblies/", .dll)` then `Assembly.LoadFrom`.  
`AssemblyIsUsable` — `GetTypes()`; logs ReflectionTypeLoadException details; unusable skipped. LoadFrom exception → Error and **break** (later DLLs in that mod not loaded). See note 53.

## Post-load hooks

`UnityStubs.ModLoadingHooks` — static `Action<IReadOnlyList<Assembly>> AfterAssembliesLoaded`; `RunAfterAssembliesLoaded` from `LoadedModManager` after all mod DLLs load.

Bootstrap assigns `AfterAssembliesLoaded = PrepatcherCompat.ProcessModAssemblies` (and Injection `ProcessAssemblies` path — see note 25).

## Targets for 1.7

- `net10.0`, refs: `Assembly-CSharp`, `UnityStubs`, `Waylith` (Copy Local false)
- Harmony **3.0.x** with strict `__instance`/`__result` types
- Avoid Prepatcher-only mods until updated; prefer Injection attribute patterns where applicable

## Danger zones on Waylith

- Patching Harmony internals / mid-emit → native abort
- Heavy work + `Log.Message` with FileLog stacks on thin LongEvent thread
- Assuming Unity Editor/`Resources.Load` semantics without ContentFinder/ContentPack

## Testing knobs

`-mod=…` (wiki), `savedatafolder=`, `Verbose`, `NoFileLogCallstacks`, headless/CI bake.
