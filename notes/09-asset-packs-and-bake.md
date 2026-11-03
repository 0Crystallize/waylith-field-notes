# 09 — Asset packs & bake

**Confidence:** observed (`ContentPacks`, `ModAssetPacks`, `AssetBake*`, `ContentPack`, `DdsFile`)

## Mount

`UnityStubs.ContentPacks.MountLoadFolder(folder)`:

1. ищет `folder/Assets.zip`
2. `AssetPack.TryOpen`
3. `ContentPack.Mount(folder, pack, stamps)`

`IsPackedSource`: файл есть в pack **или** sidecar entries `.dds` / `-premul.dds` / `.nbmesh`.

Sidecar name pattern: `Assets.zip.*` считается pack sidecar.

## Bake API (моды / тулзы)

`ModAssetPacks`:

| API | |
|-----|--|
| `HasBakeableContent` | есть ли что печь |
| `BakeSettings(borderMipMaps, uncompressed, rdo)` | `TextureBakeSettings` (BC7 default, optional RDO) |
| `Request` / `Bake` | → `ContentPackBaker.Bake` → `Assets.zip` |
| `BakeForUpload` | unmount → bake `Assets.zip` → remount |
| `BorderMipMapSuffixes` / `UncompressedSuffixes` | читает конфиг из load folder |
| `SoundFiles` / `RawSources` | audio + raw enumeration |

`ModAssetPacks.BakeSettings` (observed defaults for RimWorld mod packs):

- Target **BC7**, Quality 1
- `RawMaxSize = 16` (очень жёстко; почти всё жмётся, кроме KeepRaw/uncompressed suffixes)
- `AllowBc1 = false`
- MipFilter **Kaiser**
- `EncodeOnGpu` если `TextureBlockEncoder.IsConfigured`
- optional RDO via `AssetBakeHost.DefaultRdoRules`
- CodeIdentity включает `textures:v47` / `rimworld-modpack-v1`

(Базовый record `TextureBakeSettings` сам по себе имеет другие defaults вроде RawMaxSize=512 — для модов важнее именно `ModAssetPacks`.)

Это официальный ответ на «пережимать DDS руками»: Waylith ждёт **Assets.zip bake**, плюс умеет load-time encode.

**Community batch driver:** [`tools/Bake-ModAssetPacks.ps1`](../tools/README.md) (note 96) — inventory + batched `-BakeModAssetPacks=` for packs.

## ContentPack / AssetPack (Waylith.Assets)

Логический VFS поверх zip/pack: hash manifest, codecs, texture info.  
Runtime cache (`TextureCacheStore`) — отдельный слой после первого decode/encode.

## DdsFile

Есть нативный разбор DDS (`Waylith.Graphics.Textures.DdsFile`) — DDS как вход/sidecar поддерживается, но pipeline заточен под bake+cache, не только «разложили dds рядом».
