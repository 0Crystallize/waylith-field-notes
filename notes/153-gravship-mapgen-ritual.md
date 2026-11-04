# 153 — Gravship mapgen & launch ritual

**Confidence:** observed (`GenStep_GravshipMarker`, `GenStep_ReserveGravshipArea`, `GenStep_GravshipWreckage`, `RitualBehaviorWorker_GravshipLaunch`, `LandingOutcomeWorker_MinorGravshipCrash`) — expands 92 / 122 / 146

## GenSteps

| Step | Role |
|------|------|
| `GravshipMarker` | Place marker; clear edge radius **2** |
| `ReserveGravshipArea` | Reserve cells + `UsedRects`; `SetStartSpot` for player start near substructure |
| `GravshipWreckage` | Wreck layout + mech combat pawns from points |

## Launch ritual

`RitualBehaviorWorker_GravshipLaunch`: board colony animals/mechs flags, force visitors leave, no reservation checks, role fill validation, `TryExecuteOn` → lord. Ties to `Precept_GravshipLaunch` (146).

## Landing outcomes

e.g. `LandingOutcomeWorker_MinorGravshipCrash.ApplyOutcome(Gravship)`.

## Modding

- Custom landing maps: compose these GenSteps (or forks) in MapGeneratorDef; honor UsedRects.
- Crash outcomes: LandingOutcomeWorker subclass + def.
- Launch as Ideology ritual: don’t mix with PsychicRitual pipeline (152).
