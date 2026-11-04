# 147 — WorkGiverDef / DamageDef / ApparelProperties extras

**Confidence:** observed — expands 54 / 58 / 75

## WorkGiverDef

`canBeDoneByMechs`, drafted auto-take priority, equivalence group, bill-giver race filters (humanlike/mech/animal ± corpses), feed-only flags, smoothing, force mote/fleck.

## DamageDef

Worker class, building/plant/corpse factors (passable vs impassable buildings), stun adaptation + resist stat, deflect metal, damageEffecter, execution/ranged flags.

## ApparelProperties

Layers / worn graphics / render skip / parentTagDef. Generation gates: warmth, **`canBeGeneratedToSatisfyVacuumResistance`**, toxic env, ideo desire faction tags. Abilities on wear; wearPerDay.

## Modding

- Mech work: canBeDoneByMechs + capacities.
- Vacuum apparel loot: vacuum resistance generation flag (144).
- Custom damage: prefer DamageDef factors over worker Harmony when enough.
