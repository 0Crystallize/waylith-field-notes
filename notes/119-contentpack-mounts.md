# 119 — ContentPack mounts

**Confidence:** observed (`Waylith.Assets.ContentPack`) — expands 09 / 22 / 97

## MountPoint

`Root` (filesystem or logical content root) + `AssetPack` + `Stamps` + optional `TextureInfo`. Multiple mounts; lookup prefers **longer Root** match.

API: `Use` (primary), `Mount` / `Unmount`, `TryGetMount`, `TryGetContentRelativePath`, `TryGetEntryName(suffix)`, `TryGetTextureContentHash`, `DropResidentPages`.

## Suffixes

| Suffix | Meaning |
|--------|---------|
| `.dds` | baked texture |
| `-premul.dds` | premultiplied |
| `.nbmesh` | mesh |
| `.split` | split entry |

Relative paths normalized to `/`.

## Modding

- Bake stamps must match mount Roots or ContentFinder misses packs.
- Multi-mod mounts: longer root wins — avoid ambiguous overlapping roots.
