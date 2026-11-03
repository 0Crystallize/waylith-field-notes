# 92 — MapGenerator, GenStep, Sites

**Confidence:** observed (`MapGenerator`, `GenStep`, `SitePartWorker`, `Site`)

## MapGenerator

`GenerateMap(size, parent, MapGeneratorDef, extraGenSteps…)`.  
Runs GenStepDef list (biome-filtered) with seeds; float grids Elevation/Fertility/Caves; vars dictionary (`GetOrGenerateVar`); PlayerStartSpot; pocket maps; step debugger.

`GenStep`: `SeedPart` + `Generate(map, parms)` (+ optional PostMapInitialized).

## World sites

`Site` world object with SiteParts. `SitePartWorker`: tick, questgen notify, PostMapGenerate, faction ownership, letters, threat params, abandon settlement leave-behind.

## Modding

- Custom map feel: MapGeneratorDef + GenStepDefs (order matters).
- Quest sites: SitePartDef + worker; generate maps with appropriate MapGeneratorDef.
- SketchGen (88) often used inside gen steps / site map gen.
