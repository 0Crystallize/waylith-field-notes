# 20 — TextureBuildBatch & RenderTexture

**Confidence:** observed

## TextureBuildBatch

Асинхронный **GPU/CPU block-encode** уже загруженных Texture2D (после deferred/load):

- `Enqueue(texture, mip0, premultiplied)` → job; `texture.PendingBuild`
- `OnFrameStart` (из main RunLoop рядом с residency):  
  - idle ≥ 2 frames since last enqueue → `Flush`  
  - idle ≥ 120 frames → extra cleanup  
  - `TextureCacheStore.FlushIfIdle()`
- `Flush` собирает `TextureBlockEncoder.BuildItem`, staging ≥ 32 MiB, in-flight GPU batches
- `CanBuild` / `CanBatchEncode` фильтруют кандидатов

Это «дожать compress в фоне», не замена bake `Assets.zip`. Пик staging + encode может совпасть с первым MapMain (**inferred** риск).

## RenderTexture (Waylith)

- Category: **`GpuMemoryCategory.RenderTarget`** → **не** offloadable residency  
- `Configure` before create; color (+ optional depth) via `GpuTextureService.AllocateTextureImage`  
- SceneColorTargets / water depth / camera bake / pawn atlases сидят здесь  
- Resize/rebuild на смене framebuffer (см. frame loop rebuild path)

Pinned RT + большой hot GameTexture set = двойное давление на device-local.
