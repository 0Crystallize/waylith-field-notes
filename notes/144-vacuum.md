# 144 — Vacuum (Odyssey)

**Confidence:** observed (`VacuumUtility`, `VacuumComponent`, related hediffs/comps)

## Pawn tick

`PawnVacuumTickInterval`: if Odyssey + biome `inVacuum` + `HarmedByVacuum` + vacuum ≥ **0.5** → severity += `0.02 * vacuum * (1 - VacuumResistance)` on `HediffDefOf.VacuumExposure` (60-tick hash).

Burn: `CanBeVacuumBurnt` (race flag, hediff prevent, gene `immuneToVacuumBurns`), protective apparel via resist ≥ **0.1** / cover checks, `TryGetVacuumBurnablePart`.

## Map

`VacuumComponent` MapComponent: room groups, adjacency, `ExchangeRoomVacuum`, paths to space (`ExposedToSpace`), dirty on RegionsRoomsChanged. Temperature twin: `TemperatureVacuumCache`.

## Apparel

`ApparelProperties.canBeGeneratedToSatisfyVacuumResistance` (with warmth / toxic twins).

## Modding

- Space races: HarmedByVacuum / race vacuum flags / genes.
- Suits: VacuumResistance stat + protective apparel helpers.
- Room airtightness: doors/walls affecting ExposedToSpace — don’t poke roomVacuums dict.
