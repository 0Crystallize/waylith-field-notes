# 13 — ContentFinder → Materials → GPU

**Confidence:** observed (`ContentFinder<T>`, `MaterialPool`, `Resources`, `ModContentPack`)

## Цепочка для текстуры мода

```
ContentFinder<Texture2D>.Get(path)
  → ModContentHolder (per ModContentPack) / reload cache
  → else Resources.Load<Texture2D>(ContentPath + path)   // base game
  → else TryFindAssetInModBundles (legacy AssetBundle)
MaterialPool.MatFrom(...)
  → MaterialAllocator.Create(shader) + mainTexture = tex
  → UnityEngine.Material (stub) ↔ Waylith.Rendering.Material
Graphic_* рисует material/mesh → MeshDrawSubmission / MapMainPass
EnsureResident / upload когда реально нужно (OnDemand)
```

## ContentFinder&lt;T&gt;

Методы: `Get`, `GetAllInFolder`, `TryFindAssetInModBundles*`.

Порядок поиска (упрощённо):

1. Holders модов (`ModContentPack.GetContentHolder<T>`) — основной путь loose/pack файлов
2. Builtin `Resources.Load*` по `GenFilePaths.ContentPath<T>`
3. AssetBundle trie (folder name / packageId) для Texture2D/AudioClip

`Resources.Load` для Texture2D:

- `Waylith.Resources.Load` → `Waylith.Rendering.Texture2D`
- wrap в `UnityEngine.Texture2D` + `CompressLikeImporter`

То есть даже «ванильный» Load уже проходит Waylith decode/compress pipeline.

## MaterialPool

Кэш `Dictionary<MaterialRequest, Material>` **только с main thread** (`UnityData.IsInMainThread`).  
Материал держит ссылку на `Texture2D` stub → CoreTexture → GPU residency.

Размножение материалов = размножение binding’ов; сами texel’ы шарятся, если один Texture2D.

## ModContentPack

- Holders: textures / audioClips / strings
- `ReloadContent` → `textures.ReloadAll` (DeepProfiler "Reload textures")
- Файловый обход: `GetAllFilesForMod*` под content paths
- LoadFolders учитываются при bake (`ModAssetPackBake` + `AllLoadFolders`)

## Практический смысл для VRAM

При **OnDemand** (дефолт boot) ContentFinder/MaterialPool **не обязаны** сразу залить все мод-текстуры в device-local. Пик часто на первом показе (меню/карта) + Flush в MapMain.

`-EagerTextureUpload` меняет residency policy на OffloadUnderPressure — другое поведение hot-set (раньше грузить / агрессивнее держать device-local с offload под давлением). Точные runtime-эффекты — мерить (**inferred** до прогона).
