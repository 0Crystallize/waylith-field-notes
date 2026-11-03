# 83 — Books & colony policies

**Confidence:** observed (`Verse.Book`, `ApparelPolicy`, `DrugPolicy`)

## Book (Anomaly-era reading)

`ThingWithComps` with keyword/subSymbols, float menu read options, hyperlinks, outcome doers (`BookOutcomeDoer*` / properties for research, skill, quest, joy, mental break…).

## Policies

- **ApparelPolicy** (outfit database) — what apparel is allowed/forced
- **DrugPolicy** — schedule / frequency for recreational & medical drugs  
- Food restriction type lives nearby in policy UI (FoodRestriction / similar)

Assigned per pawn via schedules/policies UI; mods should extend policy defs carefully and ExposeData.

## Modding

- New book effects: BookOutcomeProperties + doer class.
- Policy UI hooks are fiddly — prefer appending entries over replacing OutfitDatabase wholesale.
