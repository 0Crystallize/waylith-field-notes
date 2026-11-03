# 27 — TextureUsageHints / encoding roles

**Confidence:** observed

## Enum `TextureUsage`

`Default`, `NormalXY`, `RgbOnly`, `ArrayLayer`, `AtlasTile`

## Hints registry

`TextureUsageHints.Register(path, usage)` / `RegisterSource` / `For(sourcePath)` / `Clear`.

Key extraction: substring after `/Textures/`, extension stripped (case-insensitive dict).

Conflict rule: different usages collapse toward `ArrayLayer`.

## Encoding impact (`TextureEncodingRules.Refine`)

- `NormalXY` → **BC5**
- `ArrayLayer` / `AtlasTile` → keep target (often no BC1 refine)
- single-channel detect → **BC4** + swizzle
- opaque + BC1 candidate → PSNR / visible-step gates (`MinBc1ChannelPsnr` etc.)
- RimWorld mod bake sets **AllowBc1=false**, so BC1 refine rarely wins in pack bake

## Modding tip

If you author normal maps or special atlases, register usage (or rely on bake `UsageFor` / path conventions) so encode picks BC5/BC4 instead of BC7 RGB noise.
