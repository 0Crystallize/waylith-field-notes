# 141 — RaceProperties & FactionDef (1.7 flags)

**Confidence:** observed (`Verse.RaceProperties`, `RimWorld.FactionDef`)

## Race (selected)

Think trees, food, body, biomes, caravan/master flags, `renderTree` / `startingAnimation`, shambler, **`canBeVacuumBurnt`**, **`canFlyInVacuum`**, herd/pack/predator, petness, … (Odyssey gates inside ConfigErrors / helpers).

## Faction

Raid/siege/stage flags, **`canPsychicRitualSiege`**, temperature arrival, royal favor labels/tags/titles, pawn group makers, forageability, **`layerWhitelist` / `layerBlacklist`** (`PlanetLayerDef`), settlement loot ThingSetMaker, …

## Modding

- Vacuum/Odyssey pawns: set canBeVacuumBurnt / canFlyInVacuum intentionally.
- Faction presence per layer: whitelist/blacklist (with biomes 127).
- Anomaly sieges: canPsychicRitualSiege on faction.
- New race: prefer RaceProperties fields over Harmony for movement/caravan eligibility.
