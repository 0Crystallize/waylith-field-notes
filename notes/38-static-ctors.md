# 38 — StaticConstructorOnStartup

**Confidence:** observed (`StaticConstructorOnStartupUtility`, `ShaderDatabase`, `GenDraw`)

## Contract

Attribute on a type → `RuntimeHelpers.RunClassConstructor` during `CallAll()` (PlayData / content load), **main thread**, profiled under DeepProfiler.

Sets `coreStaticAssetsLoaded = true` after all succeed/fail individually (errors logged per type, others continue).

## What belongs there

Static fields that are Texture / Material / Shader / Graphic / GameObject / MaterialPropertyBlock (or arrays thereof).  
`ReportProbablyMissingAttributes` Parallel.ForEach-scans types without the attribute that hold such fields → Warning.

Examples: `ShaderDatabase`, `GenDraw` line/overlay mats via `MaterialPool.MatFrom`.

## Waylith risks

- Static ctor that loads many textures → residency / LongEvent interaction (notes 02, 15, 16).
- Don’t assume GPU upload finished; OnDemand may defer.
- Heavy `Log.*` with FileLog stacks on thin threads — note 04.
- Order among attributed types is discovery order, not declared dependency — avoid cross-type static field races; call into ContentFinder/MaterialPool only after content is ready for that phase.

## Mod pattern

```csharp
[StaticConstructorOnStartup]
public static class MyMats
{
    public static readonly Material Overlay =
        MaterialPool.MatFrom("Things/MyOverlay", ShaderDatabase.MetaOverlay);
}
```
