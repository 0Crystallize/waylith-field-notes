# 63 — Research, Needs, MentalState (map)

**Confidence:** observed (locations) / light touch

## Research

- Def: `Verse.ResearchProjectDef` (not RimWorld namespace)
- Runtime: `RimWorld.ResearchManager` — progress, current project, prerequisites

Mods: XML projects + tabs; Harmony ResearchManager only for exotic unlock rules.

## Needs

`RimWorld.Need` / `NeedDef` / concrete `Need_*`.  
Pawn_NeedsTracker ticks needs; custom need = NeedDef + needClass.

## MentalState

`Verse.AI.MentalStateWorker` (+ many subclasses). MentalStateDef.workerClass; state classes under AI.

## Reachability

`Verse.Reachability` (+ WithinRegion / Immediate / Cache / Utility) — path region reach queries for AI. Prefer utility helpers from jobs rather than reimplementing BFS.
