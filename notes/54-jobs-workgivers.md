# 54 — Jobs, JobDrivers, WorkGivers

**Confidence:** observed (`JobDriver`, `WorkGiver_Scanner`)

## JobDriver

Abstract; XML `JobDef.driverClass`.

Must implement:

- `TryMakePreToilReservations(errorOnFailed)`
- `MakeNewToils()` → sequence of `Toil`

Helpers: TargetA/B/C, fail/finish conditions, JumpToToil, EndJobWith, GetReport (infinitive UI — RU canon), pather notifies.

Toils are built once then ticked (`DriverTick` / Interval).

## WorkGiver_Scanner

Work type scanners: override PotentialWorkThingRequest / PotentialWorkThingsGlobal / cells, `HasJobOnThing` / `JobOnThing`, or cell variants, priority, PathEndMode.

Wire via `WorkGiverDef` → work type → pawn work settings.

## Flow

WorkGiver finds target → creates `Job` → JobTracker starts driver → reservations → toils.

## Mod tips

- Reservations first; never assume exclusive access without them.
- Prefer scanner globals that are cheap; MaxRegionsToScanBeforeGlobalSearch gates region flood.
- Report strings: Keyed infinitives, not third-person narrative.
