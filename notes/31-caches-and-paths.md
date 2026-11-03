# 31 — Caches & paths

**Confidence:** observed

## Save / config

`GenFilePaths.SaveDataFolderPath` — override with `savedatafolder=`.  
Under it: Config, Saves, ModLists, Screenshots, …

## PlatformPaths

`PersistentDataRoot(company, product)`, `CacheDataRoot`, `DeleteMovedCaches`.

## CacheFileWriter

- `InstallRoot` / `InstallId` = first 8 hex of SHA256(InstallRoot)
- async write queue; install records under `cache/installs/{InstallId}`
- sweeps for abandoned temps / other installs

TextureCacheStore keyed packs use this InstallId (per-machine/install isolation).

## Asset / texture caches

- Mod `Assets.zip` (ContentPack mmap)
- Runtime `TextureCacheStore` (encoded pages, keyed)
- Static atlas keyed adopt (`TryAdoptCachedPages`)
- DDS `PersistToTextureCache` on first load

## Modding / CI

- Parallel test profiles: different `savedatafolder` + clean cache roots.
- After changing texFormat/quality/bake identity, expect cache misses / rebake.
- Don’t delete live Steam caches blindly while game runs.
