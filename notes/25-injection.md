# 25 — Waylith.Injection (field injection)

**Confidence:** observed (`Waylith.Injection.*`) — surface for advanced mods / PrepatcherCompat

## Purpose

Runtime field injection / accessor rewrite pipeline (replacement for some Prepatcher-era patterns on Waylith).

Bootstrap:

- `PrepatcherCompat.Install()`
- `ModLoadingHooks.AfterAssembliesLoaded = PrepatcherCompat.ProcessModAssemblies`
- each frame: `Injection.ApplyPendingAtFrameBoundary` on `OnUpdate`

## Public API (`Injection`)

- `IsSupported`
- `ProcessAssemblies(assemblies)`
- `RegisterAccessorConvention`
- `BindAccessor(MethodInfo, FieldInfo)`
- `QueueForFrameBoundary(batch, onApplied?)`
- `ApplyPendingAtFrameBoundary()`
- `HasRewrittenBody(method)`
- `HarmonyRegenerate` / `RegisterStaleMethodHandler` — cooperate with Harmony when bodies go stale
- `LogSink`

## Attribute

`[InjectedField(Default=…, Initializer=…)]` on fields — processor rewrites accessors.

## Modding caution

- Frame-boundary apply is intentional (avoid mid-render mutation).
- Stale method handlers must regenerate Harmony safely — Waylith aborts hard on bad Harmony mid-emit (**khatum**/prior notes).
- Not a free replacement for all Prepatcher features; test per mod.
