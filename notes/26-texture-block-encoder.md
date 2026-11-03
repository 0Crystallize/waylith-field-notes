# 26 — TextureBlockEncoder

**Confidence:** observed

## Role

GPU/CPU path that turns RGBA (or GPU image) into BC1/4/5/7 payloads used by bake, TextureBuildBatch, load-time encode.

## Lifecycle

`Configure(GraphicsDevice)` in Bootstrap texture runtime; `Shutdown` on graphics teardown.  
`IsConfigured` / `Bc7FastPermitted` / `CanEncodeBc7Fast`.

## API highlights

| API | |
|-----|--|
| `TryEncodeFromPixels` | CPU encode mip chain |
| `TryEncodeFromPixelsOnGpu` / Begin+Complete | async GPU pixel encode |
| `EncodeFromImage` | from `GpuTextureAllocation` |
| `TryEncodeBc7Fast` | fast BC7 path (± dest image) |
| `EncodeWithKernel` | named compute kernel |
| `CanBatchEncode` / `SubmitBuildBatch` / `CompleteBuildBatch` | TextureBuildBatch |

Staging via `CreateUploadBuffer`.

## Modding

- You rarely call this directly; bake/`texFormat`/TextureBuildBatch do.
- Mods that ship custom compress should prefer **Assets.zip bake** so runtime skips heavy encode.
- `TextureUsageHints` + `TextureEncodingRules` choose BC5 for NormalXY, BC4 single-channel, etc.
