# 62 — ThoughtWorker & Alert

**Confidence:** observed

## ThoughtWorker

ThoughtDef.workerClass. Override `CurrentStateInternal` and/or `CurrentSocialStateInternal` → `ThoughtState`.  
`def.invert` flips active. `ThoughtUtility.CanGetThought` gate. Label/desc Formatted with PAWN.

## Alert

Abstract; `GetReport()` → `AlertReport` (active + targets).  
DLC gates: requireRoyalty/Ideology/Biotech/Anomaly.  
Priority, label, explanation, DrawAt, jump-on-click.

Auto-discovered alert subclasses — keep GetReport cheap (cachedActive via Recalculate).

## RU

Alert/thought player text via Keyed/DefInjected; workers return states not hardcoded prose when defs hold strings.
