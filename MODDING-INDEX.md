# Modding index — where to look

Task-oriented map into `notes/`. Unofficial; pin your game build.

## Ship textures / art

| Want | Read |
|------|------|
| Official bake → Assets.zip | 09, 12, 23, **96**, **97** + `tools/` |
| ContentPack mounts / suffixes | **119**, 22 |
| DDS vs PNG, shadowing | 16, 19 |
| BC7 / normals / usage | 26, 27, Prefs in 23 |
| Runtime compress prefs | 16, 23 |
| Atlases & source eviction | 16, 19 (`noEvictAtlasSources`) |
| Mesh GPU upload | **98**, 17 |
| Gravship cutscenes / hull | **99**, **122** |
| Planet layers / Odyssey | **100**, **126**, **127**, **137**, **139**, **145** |
| Vacuum / space exposure | **144** |
| Gravship capture / thruster | **146**, **122**, **99** |
| Gravship mapgen / launch ritual | **153** |
| VRAM / TDR | 02, 03, 07, 08, 19, 20 |
| Memory unload / ClearAllMaps | **121** |

## Load & content

| Want | Read |
|------|------|
| ContentFinder / MaterialPool | 13, 16, **41**, 37 |
| DefDatabase / XML patches | **42**, **128** |
| LoadFolders | **43** |
| ModContentPack / Assemblies | **53**, 35 |
| Keyed / DefInjected | **51** |
| Save/config paths | **52** |
| Deferred GPU upload | 08, 16 |
| Prefetch | 08, 16 |
| AssetPack mmap | 22, 31, **119** |
| LongEvent / thin stack | 15, 05, 04, **44** |
| Graphic / ThingComp | **45**, 36 |
| DebugAction / Dialog_Debug | **124** |

## Rendering / FX

| Want | Read |
|------|------|
| Frame loop / passes | 07, 01, 12 |
| MapMain / World / PostFx | 03, 12, 28, **104**, **136** |
| Camera → RT / portraits | 28, **104**, **116** |
| LayerPassRouter / water depth | **104** |
| Shaders GLSL / prewarm / hot reload | 14, 29 |
| Mesh draw path | 17, 33 |
| Section / MapDrawLayer / Printer | 36, 40, **111** |
| GlowGrid Burst jobs | **112** |
| DynamicDraw cull jobs | **113** |
| Fog / CameraDriver | **120** |
| WorldDrawLayer / WorldRenderer | 49, **117** |
| Graphic / Shader / MaterialPool | 37, 34, 13 |
| Altitudes / GenDraw | 40 |
| ImGui / UI GPU | 21 |
| SoundDef / sustainers | **50**, 30, **103** |
| RenderTargets pinned | 20, 28 |
| EngineSwitches / lifecycle | **109**, **110** |

## Code mods / Harmony / Prepatcher

| Want | Read |
|------|------|
| UnityWorld compat | 24 |
| Field injection | 25, **102** |
| MayRequire* / soft DLC | **108** |
| Load mod DLLs | 35 |
| AfterAssembliesLoaded | 35, 25, 102 |
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
| Inspect / ITabs / main tabs | **101** |
| PathFinder / reachability | **105**, **118** |
| Power nets | **114** |
| Stats / Hediffs / Damage | **58** |
| Scribe / saves | **59**, **115** |
| Spawn / PlaceWorker | **60** |
| Reservations | **61** |
| Thoughts / Alerts | **62**, **142** |
| Research / Needs / Mental | **63** |
| Lords (group AI) | **64** |
| GameConditions | **65** |
| Bills | **66**, **129** |
| Architect / LinkGrid | **131**, 56 |
| Letters | **67** |
| Rooms / beauty | **68** |
| Factions | **69** |
| Quests / QuestNode | **70**, **125** |
| FloatMenu providers | **123** |
| Abilities / rituals | **71** |
| Caravans / PathFollower | **72**, **130** |
| Verbs / projectiles | **73**, **78** |
| Effecters / flecks / motes | **74** |
| ThingFilter / stuff / filth | **75** |
| Terrain | **76** |
| DamageInfo | **77**, 58 |
| Genes / xenotypes / growth / biosculpter | **79**, **134** |
| Royalty titles / permits | **133** |
| Ideo / precepts / tracker | **80**, **138** |
| Buildings / worktables | **81** |
| Zones / areas | **82** |
| Books / policies | **83** |
| Transporters / shuttle / launchable | **84**, **148**, **149** |
| Mechanitor | **85** |
| Psychic rituals | **86**, **106** |
| Entities / codex (Anomaly) | **107** |
| Blueprints / frames | **87** |
| SketchGen | **88** |
| Scenarios | **89** |
| Storyteller | **90** |
| Raids / arrival | **91**, **151** |
| Map gen / sites | **92** |
| Pawn generation | **93** |
| Relations / interactions | **94** |
| Trade / ThingSetMaker | **95**, **140** |
| Race / Faction layer flags | **141** |
| Sketch / WorldFeature | **143**, 88 |

## Architecture overview

Start: 00 → 01 → 12 → 07 → 02.  
Modding “hello”: 43 → 35 → 42 → 38 → 45 → 54.
