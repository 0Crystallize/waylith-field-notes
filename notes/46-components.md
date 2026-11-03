# 46 — Game / Map / World components & Mod entry

**Confidence:** observed

## GameComponent

Global per Game. Hooks: Update / Tick / OnGUI / ExposeData / FinalizeInit / StartedNewGame / LoadedGame / AppendDebugString.  
Register via subclass discovery (same pattern as other components — constructed when Game builds component list).

## MapComponent

Per Map (`readonly Map map`). Hooks: MapComponentUpdate / Tick / OnGUI / Draw / ExposeData / FinalizeInit / MapGenerated / MapRemoved.

Prefer MapComponent over static caches keyed by map — survives cleanup via MapRemoved.

## WorldComponent

`RimWorld.Planet.WorldComponent(World)` — Update / Tick / OnGUI / ExposeData / `FinalizeInit(fromLoad)`.  
(Verse also hosts some world-ish controllers, e.g. gravship.)

## Mod (settings)

`abstract class Mod(ModContentPack content)`:

- `GetSettings<T>()` — one settings type per Mod subclass; loads via `LoadedModManager.ReadModSettings`
- `DoSettingsWindowContents` / `SettingsCategory` / `WriteSettings`

Wire in About.xml / assembly attribute as usual for RimWorld mods.

## Choice guide

| Need | Use |
|------|-----|
| Mod options UI | `Mod` + `ModSettings` |
| Save with colony | GameComponent / MapComponent ExposeData |
| Per-map visuals each frame | MapComponentDraw / Update |
| Data on a Def | DefModExtension (42) |
| Per-thing behavior | ThingComp (45) |
