# 126 — WorldPathGrid (per PlanetLayer)

**Confidence:** observed (`RimWorld.Planet.WorldPathGrid`) — expands 100 / 72

`layerMovementDifficulty: Dictionary<PlanetLayer, float[]>` — path costs are **per layer**, not one global array.

Tick: `WorldPathGridTick`. Recalc: tile / layer / all layers. Winter offset (+2 when temp ≤ 5°C style rules). `Passable` / `PassableFast` / `PerceivedMovementDifficultyAt`.

## Modding

- Odyssey multi-layer: always recalc the correct `PlanetLayer`; caravan pathing breaks if only surface layer updated.
- Custom world difficulty: hook CalculatedMovementDifficultyAt carefully — layer aware.
