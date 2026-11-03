# 66 — Bills (workbenches)

**Confidence:** observed (`Bill`, `Bill_Production`, `IBillGiver`)

## Bill

Tied to `BillStack` + `RecipeDef`. Filters, skill range, search radius, pawn/slave/mech restrictions, suspended/deleted.

WorkGivers ask `ShouldDoNow` / pawn allowed → create jobs from recipe.

`Bill_Production` adds repeat modes, target count, store mode, pause-on-ready, etc.

## IBillGiver

Buildings (and some things) exposing BillStack.

## Modding

- Custom recipes usually enough; custom Bill subclass for exotic UI/logic.
- Ingredient search cost: respect nextTickToSearchForIngredients pacing.
- Style/precept/xenogerm fields — Ideology/Biotech aware.
