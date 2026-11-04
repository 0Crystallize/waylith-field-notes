# 145 — PlanetLayerDef

**Confidence:** observed (`RimWorld.PlanetLayerDef`) — expands 100 / 137

Whitelist-only toggles: incidents, biomes, game conditions, quests, arrivals, arrival modes.  
`isSpace`, `canFormCaravans`, raid/location/range factors, `backgroundBiome`, `worldDrawLayers` (type list), `layerType` / `tileType`, settlement density curves, gen steps ordered, WITabs, gizmos.

Scenarios: `ScenPart_PlanetLayer` / Fixed. Quests: `QuestPart_RequirementsToAcceptPlanetLayer`.

## Modding

- New layer: PlanetLayerDef + settings + gen steps; set whitelist flags so Core content doesn’t spill into orbit.
- Space layer: isSpace + vacuum biomes (144).
