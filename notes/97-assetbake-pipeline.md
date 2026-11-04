# 97 — AssetBake pipeline (deep)

**Confidence:** observed (`Waylith.AssetBake.*`, `UnityStubs.ModAssetPacks`, `RimWorldWaylith.ModAssetPackBake`)

## CLI bake entry

`-BakeModAssetPacks=root1;root2` → `ModAssetPackBake.Requested` splits on `;`, `GetFullPath`.

Per mod root:

1. Load `LoadFolders.xml` if present → `ModContentPack.AllLoadFolders`
2. Keep folders where `ModAssetPacks.HasBakeableContent` (**Textures/** or **Sounds/** exists — same heuristic as `New-BakeableModsList.ps1`)
3. Each folder: `BakeForUpload` → unmount ContentPack → bake `Assets.zip` → remount
4. Log: entries / reused / deduplicated / failed / seconds / unchanged
5. Process exit code 1 if any fail

Empty Textures+Sounds → Message + success (nothing to bake).

## ModAssetPacks.Request / BakeSettings

| Setting | Mod pack value |
|---------|----------------|
| Target | **BC7** |
| Quality | 1 |
| RawMaxSize | **16** (tiny tiles stay raw) |
| AllowBc1 | false |
| MipFilter | Kaiser |
| EncodeOnGpu | if `TextureBlockEncoder.IsConfigured` |
| RDO | off unless requested; rules from `AssetBakeHost.DefaultRdoRules` |
| CodeIdentity | `textures:v47` + `rimworld-modpack-v1` + border/raw suffix lists |

`BakeForUpload(loadFolder)` → output `{loadFolder}/Assets.zip`, `shipped: false` (writes stamps/roles).

## ContentPackBaker

1. Enumerate sources (+ raw files) → `BakeFingerprint` (textures + layout + settings)
2. Open previous pack; if fingerprints match → **Unchanged** result, no rewrite
3. Else write `.tmp` via `ContentPass.Run` (parallel by estimated cost)
4. On any Failed → delete tmp, return errors
5. Commit tmp→output; write fingerprint / optional stamps & roles
6. GPU encode contexts released if EncodeOnGpu

Roles of stamps: incremental reuse across rebakes.

## Standalone AssetBake CLI (`AssetBakeOptions`)

Host tool (not RimWorld) flags documented on `AssetBakeOptions.Usage`:

`--out`, `--root`×N, `--shaders` / `--no-shaders`, `--base`, `--tile-max`, `--skip`, `--premul`, `--level` (zstd default **19**), `--codec` zstd|lz4, `--rdo`, `--split-blocks` (default **true** → `.dds.split`), `--align` (Steam chunk-friendly), `--cache` / `WAYLITH_BAKE_CACHE`.

Default host RawMaxSize **512** — **mod packs use 16** via ModAssetPacks; don’t confuse the two.

## ContentPass source kinds

image / tile / sampled (atlas) / **mesh** (`ObjMeshLoader` or host `ParseMesh`) / raw (sounds etc.). Mesh encoded via `CpuMeshCache.EncodePackEntry`.

## Modding config in Defs XML

Under load folder Defs, elements:

```xml
<borderMipMaps>true</borderMipMaps>   <!-- sibling with texPath -->
<uncompressed>true</uncompressed>
```

Scanner walks `//borderMipMaps` and `//uncompressed`; if InnerText true, collects parent `texPath` → suffix `/Textures/{texPath}` for BorderMipMaps / KeepRaw funcs.

## Sidecars

Fingerprint / stamps / roles next to Assets.zip; damaged pack or stamp mismatch → full rebake.
