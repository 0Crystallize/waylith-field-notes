# 89 — Scenarios & ScenParts

**Confidence:** observed (`Scenario`, `ScenPart`)

## ScenPart hooks (selected)

Config UI, Summary, Randomize, merge/coexist, config pages, starting pawn filters, Notify_* pawn gen/death, PreConfigure, PostWorldGenerate, PostIdeoChosen, PreMapGenerate, PlayerStartingThings, GenerateIntoMap, …

ScenPartDef.workerClass → subclass. Scenario = ordered list of parts + metadata.

## Modding

- Custom start rules: ScenPart subclass + def; keep ExposeData for scenario save/share.
- GenerateIntoMap for map seeds (animals, items); PlayerStartingThings for inventory.
- CanCoexistWith prevents impossible combos in editor.
