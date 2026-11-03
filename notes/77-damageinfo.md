# 77 — DamageInfo

**Confidence:** observed

Struct-like payload into `DamageWorker.Apply` / pawn damage pipeline:

- Amount, def, angle, intended target, instigator, weapon/equipment defs, armor penetration, healable flags, distance, quality category, …

Mods constructing hits:

```csharp
new DamageInfo(DamageDefOf.Cut, amount, armorPenetration, angle, instigator, hitPart, weaponDef, …)
```

(Exact ctor overloads — see decomp; prefer matching vanilla call sites.)

Pass through existing Apply paths so armor, apparel, hediffs, and Tale/history hooks stay consistent (note 58).
