# 55 — Incidents

**Confidence:** observed (`IncidentWorker`, `IncidentDef`)

## Worker API

- `CanFireNow(parms)` → caches / calls `CanFireNowSub`
- `TryExecute(parms)` → `TryExecuteWorker` + letter plumbing
- Chance: `BaseChanceThisGame`, `ChanceFactorNow(target)`, `FiredTooRecently`
- Letters: `SendStandardLetter` / static `SendIncidentLetter`

`IncidentDef.workerClass` points at subclass; storyteller picks defs by category/points/target.

## Modding

- Soft-fail in CanFireNowSub (return false) rather than throwing.
- Use LookTargets for camera jump; NamedArgument for letter translation.
- Points / threat population still storyteller-owned — don’t hardcode ignoring `parms.points` unless intentional.
