# Waylith Field Notes

Unofficial, version-pinned observations of **RimWorld 1.7 / Waylith** (Vulkan, .NET 10) for modders and heavy modpack maintainers.

This is **not** Ludeon documentation and **not** affiliated with Ludeon Studios.  
Prefer the official [RimWorld 1.7 Modder Primer](https://rimworldwiki.com/wiki/Modding_Tutorials/RimWorld_1.7_Mod_Updates) for migrating mods. These notes cover engine internals the Primer does not (texture residency, frame loop, VRAM pressure, LongEvent threads, bake pipeline, CLI knobs).

Notes are currently written in **Russian** (`notes/`). English translations welcome via PR.

---

## Why this exists

Waylith already includes serious GPU texture residency, bake/BC7, asset packs, and upload deferral. Large packs still hit Windows **TDR** / `DEVICE_LOST` when the hot working set exceeds VRAM. Understanding the real pipelines beats inventing a second Texture Pool on top of the engine’s.

## Confidence labels

| Tag | Meaning |
|-----|---------|
| **observed** | Seen in decompile / log / pinned build |
| **inferred** | Reasonable conclusion from code, not runtime-proven here |
| **khatum** | Reproduced on a large private modpack; treat as field report, not engine contract |

## Pinned build (first capture)

| | |
|--|--|
| Game | `1.7.4995 rev309` (Steam `unstable`) |
| Waylith | `1.0.0+9711575089c3d58df2eb1f09b45de3914b286ae1` |
| UnityStubs / ACS fragment | `41fb34228c24bb10001f7c2ec979b82ddc322517` |

Re-verify after every unstable bump.

## Table of contents

1. [Scope & sources](notes/00-scope-and-sources.md)
2. [Architecture map](notes/01-architecture-map.md)
3. [Texture residency](notes/02-texture-residency.md) — engine already has a residency manager
4. [GPU memory & TDR](notes/03-gpu-memory-and-tdr.md)
5. [Logging / stack capture](notes/04-logging-and-stacks.md)
6. [Threads & jobs](notes/05-threads-and-jobs.md)
7. [Env knobs](notes/06-env-knobs.md)
8. [Frame loop](notes/07-frame-loop.md)
9. [Texture load pipeline](notes/08-texture-load-pipeline.md)
10. [Asset packs & bake](notes/09-asset-packs-and-bake.md)
11. [CLI & knobs](notes/10-cli-and-knobs.md)
12. [Jobs](notes/11-jobs.md)
13. [Bootstrap](notes/12-bootstrap.md)
14. [Content & materials](notes/13-content-and-materials.md)
15. [Shaders & warmup](notes/14-shaders-and-warmup.md)
16. [LongEvent](notes/15-longevent.md)

## Headline findings

- **Default residency after boot is `OnDemand`.** `-EagerTextureUpload` switches to `OffloadUnderPressure`.
- Runtime compression defaults to **BC7**, `RawMaxSize=16`, BC1 off; CLI: `-texFormat`, `-texQuality`.
- Official mod bake: `-BakeModAssetPacks=path;path` → `Assets.zip`.
- Async `LongEventHandler` uses `new Thread` with **default stack size** (relevant to load crashes / abort).
- File log stacks: `-NoFileLogCallstacks` (and related switches in note 10).
- Useful env: `WAYLITH_VRAM_BUDGET_MB`, `WAYLITH_LOAD_ENCODE`, `WAYLITH_NO_ASSET_PREFETCH`, `WAYLITH_VULKAN_DEVICE`.

## What is not in this repo

- No game DLLs, no full decompilation dumps, no redistributed Ludeon binaries.
- Method of study: local copies of your own install + `ilspycmd` / metadata inspection. Do not publish those copies.

## License

Documentation is licensed under [CC BY 4.0](LICENSE).  
RimWorld, Waylith, and related trademarks belong to Ludeon Studios.

## Contributing

- Pin the game/Waylith hash when you add or correct a claim.
- Mark **observed** / **inferred** / pack repro clearly.
- Prefer short notes over pasting decompiled source.
- PRs for English translations of `notes/*.md` are especially welcome.
