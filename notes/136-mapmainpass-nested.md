# 136 — MapMainPass nesting

**Confidence:** observed (entities list) — expands 03 / 07 / 12

`MapMainPass` is a **nested type**: `RimWorldWaylith.Rendering.MapRenderFeature.MapMainPass` (not a top-level class). ilspycmd `-t MapMainPass` alone fails; decompile `MapRenderFeature` or use nested name.

Still the map GPU pass that flushes pending texture commands before mesh record.

## Modding

- When grepping / decompiling Waylith RimWorld.dll, search nested types under MapRenderFeature / WorldRenderFeature.
