# 138 — Pawn_IdeoTracker

**Confidence:** observed (`RimWorld.Pawn_IdeoTracker`) — expands 80

Certainty, conversion attempts, previous ideos, baby exposure weights (`ExposurePointsPerTick = 0.0004`). `SetIdeo`, Reassure / OffsetCertainty, TryJoinIdeoFromExposures.

## Modding

- Conversion mechanics: IdeoConversionAttempt + certainty — don’t set `ideo` field raw without SetIdeo side effects.
- Baby culture: exposure APIs before join.
