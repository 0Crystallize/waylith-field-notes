# 106 — Psychic rituals (runtime)

**Confidence:** observed (`PsychicRitualDef`, `Verse.AI.Group.PsychicRitual`) — expands 86

## Def surface

Research gate, drafting/float-menu allows, cooldownHours, AI vs player castable, minThreatPoints, pocket maps, **planet layerWhitelist**, AI letter texts, icon.

Virtuals: `CreateGraph` / `CreateToils`, candidate pool, role assignments, BlockingIssues, messages, `MakeNewLord`, target validation, `CalculateMaxPower`.

Concrete defs: InvocationCircle, summon variants, pulses, chronophagy, pit gate, void provocation, …

## Runtime

LordJob_PsychicRitual (+ Repeating). Toils under `Verse.AI.Group.PsychicRitualToil_*`. Spot: `CompPsychicRitualSpot`. Manager: `GameComponent_PsychicRitualManager`. Siege: `RaidStrategyWorker_PsychicRitualSiege`.

## vs Ideology rituals

Different pipeline from Precept_Ritual / RitualBehaviorWorker (71). Don’t share toil graphs blindly.

## Modding

- New ritual: PsychicRitualDef subclass + toils + roles; respect layer whitelist on Odyssey.
- Offerings: `OfferingReachable` helper.
- Gizmos via PsychicRitualGizmo / dialog BeginPsychicRitual.
