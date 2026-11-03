# 37 — GraphicDatabase, ShaderDatabase, MaterialPool

**Confidence:** observed

## GraphicDatabase

- Cache: `Dictionary<GraphicRequest, Graphic>`; getters cached per graphic class via reflection → `GetInner<T>`.
- **Main thread only** (`UnityData.IsInMainThread`); off-thread → ErrorOnce + null.
- Colors coerced to `Color32` for stable keys.
- Failure → `BaseContent.BadGraphic`.
- `Clear()` empties cache (load/reload paths).

Prefer `GraphicDatabase.Get<T>(...)` over raw `new Graphic_*` so materials/textures dedupe.

## ShaderDatabase

`[StaticConstructorOnStartup]` — fields call `LoadShader("Map/...")` etc.

`TryLoadShader`:

1. Cache hit in `lookup`
2. Else if no `ShaderDef` named from last path segment → try `ContentFinder<Shader>.TryFindAssetInModBundles`
3. Else `Shader.CreateLateBound(defName)` (Waylith registry / GLSL path — notes 14, 29, 34)

Optional `uiShaderPath` → separate UI shader mapped in `uiLookup` (`TryGetUIShader`).

## ShaderTypeDef

XML: `shaderPath`, optional `uiShaderPath`.  
`.Shader` lazy → `ShaderDatabase.LoadShader(this)`.

## MaterialPool

- Keyed by `MaterialRequest` (tex, shader, colors, mask, secondary, queue, shaderParameters).
- Main thread only.
- Creates via `MaterialAllocator.Create`; sets main/mask/secondary/colorTwo; plant shaders notify `WindManager`.
- Reverse map: `TryGetRequestForMat`.

See also deferred materials (34) — pool materials may still resolve late if shader registry not ready.
