# 73 — Verbs & projectiles

**Confidence:** observed (`Verb`, `VerbProperties`, `VerbTracker`, `Verb_Shoot`, `Projectile`)

## Verb

Abstract cast/attack unit owned by `IVerbOwner` via `VerbTracker` (equipment, apparel, hediff, ability, terrain…).

Key API:

- `TryStartCastOn(castTarg, destTarg?, …)` → warmup stance → `WarmupComplete` → burst ticks
- `CanHitTarget` / `ValidateTarget` / `DrawHighlight` / `Available` / `IsStillUsableBy`
- Sources: `EquipmentCompSource`, hediff/apparel reloadable, `TerrainDefSource`
- `AddEffecterToMaintain` for cast VFX

Subclass for custom attacks (`Verb_Shoot` is thin over base shoot path). Props live on `VerbProperties` (range, warmup, burst, projectile def, targetParams…).

## Projectile

`ThingWithComps` launched by verbs:

- `Launch(launcher, origin, usedTarget, intendedTarget, hitFlags, …)`
- Damage from `def.projectile` or overrides (`damageDefOverride`, `extraDamages`)
- `ExactPosition` / `DrawMat` / hit resolution; `Projectile_Explosive` for AoE

## Modding

- Prefer XML VerbProperties + Projectile ThingDef over Harmony on VerbTick.
- Friendly fire: `preventFriendlyFire` + HitFlags.
- Equipment quality/stuff feeds `GetDamageAmount` / armor pen — keep that chain.
