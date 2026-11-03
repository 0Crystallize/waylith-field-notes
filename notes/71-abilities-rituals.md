# 71 — Abilities & rituals

**Confidence:** observed (`Ability`, `AbilityDef`, `RitualBehaviorWorker`)

## Ability

On pawn: AbilityDef, VerbTracker primary verb, comps (`AbilityComp`), cooldown/charges, gizmos via `gizmoClass`.

Cast path goes through verb targeting; Ideology precepts can source abilities.

## Rituals

`RitualBehaviorWorker` (from RitualBehaviorDef): CanStartRitualNow / CanExecuteOn / TryExecuteOn → usually starts `LordJob_Ritual`.  
Tick/Cleanup/PostCleanup; roles via RitualRoleAssignments; spectators; reservation checks.

## Modding

- AbilityDef + verbProperties (+ effecter/comps) covers most powers.
- Rituals: Precept_Ritual + behavior worker; heavy lifting in LordJob (64).
- Cooldown UI uses same Gizmo stack as drafts (56).
