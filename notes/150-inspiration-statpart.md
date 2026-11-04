# 150 — InspirationHandler & StatPart

**Confidence:** observed (`InspirationHandler`, `StatPart`)

## Inspiration

Per-pawn: TryStartInspiration / End / Reset / random available def. Tick interval driven.

## StatPart

Abstract `TransformValue` + `ExplanationPart`; priority order on parent StatDef. ForceShow / hyperlinks / ConfigErrors.

VacuumResistance and similar Odyssey stats are normal StatDefs with parts — extend via StatPart subclass in XML rather than Harmony on GetStatValue when possible.

## Modding

- New inspiration: InspirationDef + start via handler.
- New stat modifier: StatPart + list on StatDef.
