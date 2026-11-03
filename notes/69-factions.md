# 69 — Factions

**Confidence:** observed (`Faction`, `FactionManager`)

## Faction

Runtime instance of FactionDef: goodwill, relation kinds, leader, ideos tracker, royal favor flags, temporary/hidden/defeated.

Statics: `OfPlayer`, Mechanoids, Insects, Ancients, Empire, Pirates, HoraxCult, Entities, TradersGuild, Salvagers, …

Goodwill via situations + `GoodwillWith` / `TryAffectGoodwillWith`.

## FactionManager

List/create/remove factions; Of* accessors.

## Modding

- New faction: FactionDef (+ pawn kinds, xenotypes, ideo prefs) more than Harmony.
- Temporary factions for quests/events — set `temporary`, cleanup on end.
- RelationKind Hostile/Neutral/Ally gates raids/trade — test PlayerRelationKind.
