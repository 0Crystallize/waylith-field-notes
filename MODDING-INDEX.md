# Modding index — where to look

Task-oriented map into `notes/`. Unofficial; pin your game build.

## Ship textures / art

| Want | Read |
|------|------|
| Official bake → Assets.zip | 09, 12, 23 (`BakeModAssetPacks`) |
| DDS vs PNG, shadowing | 16, 19 |
| BC7 / normals / usage | 26, 27, Prefs in 23 |
| Runtime compress prefs | 16, 23 |
| Atlases & source eviction | 16, 19 (`noEvictAtlasSources`) |
| VRAM / TDR | 02, 03, 07, 08, 19, 20 |

## Load & content

| Want | Read |
|------|------|
| ContentFinder / MaterialPool | 13, 16, **41**, 37 |
| DefDatabase / XML patches | **42** |
| LoadFolders | **43** |
| ModContentPack / Assemblies | **53**, 35 |
| Keyed / DefInjected | **51** |
| Save/config paths | **52** |
| Deferred GPU upload | 08, 16 |
| Prefetch | 08, 16 |
| AssetPack mmap | 22, 31 |
| LongEvent / thin stack | 15, 05, 04, **44** |
| Graphic / ThingComp | **45**, 36 |

## Rendering / FX

| Want | Read |
|------|------|
| Frame loop / passes | 07, 01, 12 |
| MapMain / World / PostFx | 03, 12, 28 |
| Camera → RT / portraits | 28 |
| Shaders GLSL / prewarm / hot reload | 14, 29 |
| Mesh draw path | 17, 33 |
| Section / MapDrawLayer / Printer | 36, 40 |
| WorldDrawLayer | 49 |
| Graphic / Shader / MaterialPool | 37, 34, 13 |
| Altitudes / GenDraw | 40 |
| ImGui / UI GPU | 21 |
| SoundDef / sustainers | **50**, 30 |
| RenderTargets pinned | 20, 28 |

## Code mods / Harmony / Prepatcher

| Want | Read |
|------|------|
| UnityWorld compat | 24 |
| Field injection | 25 |
| Load mod DLLs | 35 |
| AfterAssembliesLoaded | 35, 25 |
| StaticConstructorOnStartup | 38 |
| Mod / Game / Map / World components | 46 |
| TickManager | 47 |
| PlayDataLoader order | 48 |
| Graphics.DrawMesh | 33 |
| Materials / deferred | 34, 37 |
| Prefs / EarlyPrefs | 39 |
| Logging stacks | 04, 10, 23 |
| Jobs vs LongEvent | 11, 15, 44 |

## Perf / diagnostics

| Want | Read |
|------|------|
| CLI/env knobs | **23**, 06, 10 |
| GPU probe tiers | 18 |
| Residency policy | 02, 12 (`EagerTextureUpload`) |
| Profiling / crash | 32 |
| Caches / save paths | 31 |

## Gameplay systems (classic modding)

| Want | Read |
|------|------|
| Jobs / WorkGivers | **54** |
| Incidents | **55** |
| Designators / Gizmos | **56** |
| Windows / GUI | **57**, 21 |
| Stats / Hediffs / Damage | **58** |
| Scribe / saves | **59** |
| Spawn / PlaceWorker | **60** |
| Reservations | **61** |
| Thoughts / Alerts | **62** |
| Research / Needs / Mental | **63** |
| Lords (group AI) | **64** |
| GameConditions | **65** |
| Bills | **66** |
| Letters | **67** |
| Rooms / beauty | **68** |
| Factions | **69** |
| Quests | **70** |
| Abilities / rituals | **71** |
| Caravans | **72** |

## Architecture overview

Start: 00 → 01 → 12 → 07 → 02.  
Modding “hello”: 43 → 35 → 42 → 38 → 45 → 54.
