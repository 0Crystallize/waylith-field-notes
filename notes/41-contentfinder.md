# 41 — ContentFinder\<T\>

**Confidence:** observed

## Rules

- **Main thread** for `Get` (Error + null off-thread).
- Search order when `ModContentHolder<T>.anyReloaded` (not Shader): **last running mod wins** (iterate packs reverse).
- Then Unity `Resources.Load` for Texture2D / AudioClip under `GenFilePaths.ContentPath<T>()`.
- Then `TryFindAssetInModBundles` for Texture2D / AudioClip / Shader.
- `reportFailure` → Error with optional `ContentFinderRequester.requester` defName context.

## Bundles

Uncached path walks running mods reverse; for each loaded AssetBundle tries:

`Assets/Data/{FolderName|PackageIdPlayerFacing}/{ContentPath}/{itemPath}{ext}`

Official mods skip PackageIdPlayerFacing fallback. Extensions from `ModAssetBundlesHandler`.

Main-thread path caches by path; stamp invalidates when loaded bundle counts change. Off-thread bundle lookup skips cache.

## Waylith note

Loose textures / Assets.zip residency still go through TextureResourceManager after ContentFinder returns a Texture2D stub (notes 02, 08, 09, 22). ContentFinder does not upload GPU itself.
