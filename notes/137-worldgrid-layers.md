# 137 — WorldGrid (Surface + Orbit)

**Confidence:** observed (`RimWorld.Planet.WorldGrid`) — expands 100 / 126

Not a single tile array anymore:

- `Surface` / `Orbit` PlanetLayers
- `PlanetLayers` dictionary by id; `RegisterPlanetLayer`, `OnPlanetLayerAdded/Removed`
- `TryGetLayerByTag`
- Indexers: `this[int]` → surface tile; `this[PlanetTile]` → layer-aware
- Native mesh helpers still on surface (`UnsafeVerts`, neighbor arrays)
- Constants: SubdivisionsCount 10, PlanetRadius 100

## Modding

- Always carry `PlanetTile` (layer + id), not bare int tile ids across Odyssey content.
- Custom layers: RegisterPlanetLayer + defs; path grid recalcs per layer (126).
