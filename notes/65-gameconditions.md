# 65 — GameConditions

**Confidence:** observed (`GameCondition`, `GameConditionManager`)

## Lifecycle

Init → GameConditionTick / Draw → Expired or End() → manager OnConditionEnd.  
Duration / Permanent / TransitionTicks; letters from def; conditionCauser; multi-map via AffectedMaps / CanApplyOnMap.

## Modding

- Subclass GameCondition for eclipse-like effects (weather overrides, pawn stats, draw).
- Def: GameConditionDef + conditionClass.
- Hide when stacked (`HiddenByOtherCondition`); respect map filters.
- ElectricityDisabled and similar virtuals for facility logic.
