# 127 — PollutionGrid & BiomeDef layers

**Confidence:** observed (`Verse.PollutionGrid`, `RimWorld.BiomeDef`)

## Pollution (Biotech)

Cell bool grid + drawer. `SetPolluted` / CanPollute / CanUnpollute / tick + update. `TotalPollutionPercent` vs pollutable cells. Dissolution effecter duration 45.

## Biome

Classic densities + weather commonalities + fertility terrains + wild plants/animals. Explicit terrain overrides (beach, mud, gravel, water shallow/deep/ocean/moving).

**`List<PlanetLayerDef> layerWhitelist`** — biome only on listed planet layers (Odyssey). Empty/null = legacy surface assumption (confirm per def).

Also: `disableShadows` consumed by Section ctor (111).

## Modding

- New biomes for orbit/asteroid: set layerWhitelist + terrains that exist on that layer.
- Pollution mods: use PollutionGrid APIs; respect EverPollutable.
