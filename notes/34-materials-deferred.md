# 34 — Materials (stub) & deferred resolve

**Confidence:** observed (`UnityEngine.Material`, `UnityEngine.Shader`)

## Dual material

Stub `UnityEngine.Material` wraps `Waylith.Rendering.Material` (`engineMaterial`).  
Extra shader passes → `ExtraPassMaterials` array.

## Deferred materials

Some materials constructed before shader registry ready:

- `_deferredResolver` + `PendingDeferredMaterials`
- `IsDeferredMaterial`
- `Material.ResolveAllDeferred()` called from PlayDataLoader after static ctors

Until resolved, engine material may be unseeded — don’t force GPU work on them early.

## Shader stub

- `Shader.Find` / `FromEngineShader` / `ForDef` / `CreateLateBound`
- Global keywords: `EnableKeyword` / `DisableKeyword` → `GlobalKeywordKey` string for variant plans
- `PropertyToID`, global float/matrix setters
- `MarkEngineRegistryReady` / `EngineRegistryReady`

## MaterialPool reminder

Still main-thread only; caches by `MaterialRequest`.  
Plant shaders notify `WindManager` when created.
