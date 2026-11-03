# 61 — ReservationManager

**Confidence:** observed (`Verse.AI.ReservationManager`)

## Core

```
CanReserve(claimant, target, maxPawns=1, stackCount=-1, layer=null, ignoreOther=false)
Reserve(claimant, job, target, …)
Release / ReleaseClaimedBy / ReleaseAllClaimedBy / ReleaseAllForTarget
```

Layers (`ReservationLayerDef`) allow parallel claims (e.g. hauling vs interaction).  
`playerForced` jobs may ignore others then re-check.

## JobDriver contract

`TryMakePreToilReservations` must Reserve what toils need; failures abort start.  
WorkGiver_Scanner can supply `GetReservationLayer`.

## Bugs to avoid

- Reserving then failing to Release on job end → softlocks (engine releases on job clear, but custom systems must be careful).
- Ignoring CanReserve → two pawns same interactive spot.
- Null claimant → Error.
