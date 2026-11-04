# 123 — FloatMenuOptionProvider

**Confidence:** observed (`RimWorld.FloatMenuOptionProvider`)

1.6+ style: abstract provider instead of only `FloatMenuMakerMap` statics.

## Hooks

- `Applies` / `AppliesInt(FloatMenuContext)`
- `SelectedPawnValid` (manipulation capacity if `RequiresManipulation`)
- `TargetThingValid` / `TargetPawnValid` / `CanTargetDespawned` / `CanSelfTarget`
- Options: `GetSingleOption` | `GetSingleOptionFor(Thing|Pawn)` → wrapped by `GetOptions*` enumerators

Discovered as subclasses (same pattern as many workers). Capture/Transfer entity providers sit here (107).

## Modding

- Prefer new provider subclass over Harmony on FloatMenuMakerMap for 1.7.
- Context carries multi-select; validate FirstSelectedPawn carefully.
