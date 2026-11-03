# 58 — Stats, Hediffs, Damage (pointers)

**Confidence:** observed (type surfaces; large classes — patterns only)

## StatDef / StatWorker

StatDef holds workerClass, categories, display.  
`StatWorker` computes values (base + offsets + factors + cache). Override worker for custom formulas; prefer stat parts / extends when enough.

Huge surface — read worker for the specific stat you touch.

## Hediff / HediffDef

HediffDef → hediffClass. Runtime Hediff on pawn: severity, stages, comps (`HediffComp`).  
Tick via hediff set; Careful with permanent vs temporary and save (`ExposeData`).

## DamageWorker

DamageDef.workerClass. `Apply` path mutates pawn/thing; returns DamageResult.  
Custom damage: subclass worker, keep armor/armorpen conventions.

## Mod preference order

1. XML stats / hediff comps / damage defs  
2. DefModExtension data  
3. Worker subclass  
4. Harmony on Apply/Tick only if unavoidable
