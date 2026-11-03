# 14 — Shaders & warmup

**Confidence:** observed (`ShaderWarmup`, `ShaderSourceLoader`, `ShaderPrewarmer`, `AssetBundleShaders`, Bootstrap)

## Источники

- Директория: `{BaseDirectory}/Rendering/Shaders` (GLSL → compile on load)
- Hot reload: `ShaderHotReloader` (если `-WatchShaders` / `Bootstrap.WatchShaders`)
- Legacy Unity asset bundles: `AssetBundleShaders` (Linux/Vulkan bytecode rewrite) — см. Primer

## Warmup

`ShaderWarmup.PrewarmEnabled` включается в Bootstrap (!Headless).

`KickPrewarmOnce()` → `ShaderPrewarmer.WarmInBackground(BuildPlan())`.

Plan:

- keyword contributions из `DefDatabase<MaterialDef>` (shader defName + keywords)
- global keyword key из `UnityEngine.Shader.GlobalKeywordKey`
- `ShaderVariantEnumerator.Enumerate(...)`

Цель — не компилировать варианты в первый кадр карты (**inferred** связь с TDR: меньше CPU/GPU stalls на PSO, но не лечит VRAM).

## Verse side

`ShaderDatabase` / `ShaderDef` / `ShaderDefRegistry` — как раньше, но runtime шейдеры живут в Waylith `ShaderRegistry` / `RuntimeShaderCompiler` (Slang/GLSL → SPIR-V).

## Mesh path (коротко)

`UnityMeshUploadService` + `MeshUploader` + `MeshDrawSubmission.BeginFrame` (из Bootstrap PrePoll).  
Draw → `MeshBatchRenderer` / `VulkanMeshDrawEncoder` в Map/World passes.
