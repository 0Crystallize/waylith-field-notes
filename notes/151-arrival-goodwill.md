# 151 — Arrival modes & goodwill

**Confidence:** observed (`PawnsArrivalModeDef`, `GoodwillSituationManager`, `FactionRelation`) — expands 91 / 69

## Arrival

`PawnsArrivalModeDef` + workers select how raid/visitor pawns appear. Def-side filters: `layerWhitelist` / `layerBlacklist`, biome white/black, `minSpaceSelectionWeight`, walkIn, tech level curves. Pair with PlanetLayerDef `onlyAllowWhitelistedArrivalModes` (145).

## Goodwill

`GoodwillSituationManager` evaluates situation workers affecting faction goodwill; `FactionRelation` stores hostiles/goodwill per pair.

## Modding

- Space/orbit raids: whitelist arrival modes on the layer; custom worker must handle vacuum maps.
- Diplomacy: situation workers > raw goodwill field writes.
