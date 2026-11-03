# 19 — StaticTextureAtlas & ModDdsLoader

**Confidence:** observed

## MaxPagePixels (VRAM-aware)

```text
base = maxTextureSize² / 2
if DeviceLocalHeapBytes > 0:
  base = min(base, DeviceLocalHeapBytes / 6 / 16)
base = floor_pow2(base)
MaxPagePixels = max(4 Mpx, base)
MaxPixelsPerAtlas (batch split) = MaxPagePixels * 5/8
```

То есть лимит страницы атласа **зависит от residency heap** (`TextureResidency.DeviceLocalHeapBytes`, уже capped `WAYLITH_VRAM_BUDGET_MB`). На бедных GPU страницы меньше → больше atlas pages, но каждая легче.

Mip policy страницы: `log2(min(w,h)/512)+1` (грубо).

## Bake flow (одна группа)

1. Pack textures into page(s); retry with divisor if over MaxPagePixels / MaxAtlasSize  
2. `TryAdoptCachedPages` — keyed texture cache (`TextureCompressionSettings.CacheTag` в ключе)  
3. иначе blit sources → generate mips → optional `CompressAtlas`  
4. `EvictSourceTextures` → `EvictGpuResource` на members (если eviction enabled)  
5. между батчами: `GpuTextureService.RetireDeferredDisposalsAfterIdle()`

`FastCompressDXT` — legacy helper для single textures / prefs path.

## ModDdsLoader

Только `FilesystemFile` (не произвольный VirtualFile stream).

1. `Texture2D.LoadFromTextureCache(fullPath)` — hit → готово (aniso 0, trilinear)  
2. mmap read `DdsHeader`; magic/`Size`/`PixelFormat.Size` checks  
3. BC7 header offset 148, иначе 128  
4. BGR888 uncompressed → CPU swap R/B  
5. `LoadRawTextureData` + `PersistToTextureCache` + `Apply`

Форматы через `PixelFormat.ToTextureFormat()` (включая BC7).  
Связь с shadowing: рядом лежащий PNG не грузится, если есть DDS.

## PawnTextureAtlas (отдельно)

Runtime **RenderTexture** 2048², 128² frames, 32 pawns × 8 frames.  
Это `RenderTarget` category (pinned), не GameTexture offload path. Много колонистов → несколько atlas RT (**observed** размеры; рост с pawn count **inferred**).
