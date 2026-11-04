# 100 — PlanetLayer (Odyssey / space)

**Confidence:** observed (`PlanetLayerDef`, `RimWorld.Planet.PlanetLayer`)

## PlanetLayerDef

Defines a **world sphere / layer** (surface, orbit, …):

| Area | Fields |
|------|--------|
| Type | `layerType` (: PlanetLayer), `tileType`, `isSpace`, surface tiles flag |
| Content gates | onlyAllowWhitelisted Incidents / Biomes / GameConditions / Quests / Arrivals / ArrivalModes |
| World objects | default / settlement / destroyed settlement WorldObjectDefs |
| Draw | `worldDrawLayers` (WorldDrawLayer subclasses), lineColor/width, view gizmo |
| Gameplay | canFormCaravans, raidPointsFactor, generatedLocationFactor, rangeDistanceFactor, backgroundBiome, ignoreNoBuildArea |
| Camera | Extra altitude / parallax knobs on runtime layer |

Connections between layers (`PlanetLayerConnection`) for travel / gizmo visibility (`viewGizmoOnlyVisibleWithDirectConnection`).

## Runtime PlanetLayer

Tiles + verts/neighbors native arrays, WorldPathing / FloodFiller / FastTileFinder, WorldDrawLayers list, zoomIn/Out sibling layers, view center/angle.

Scenarios: `ScenPart_PlanetLayer` / Fixed (89). Quests: RequirementsToAcceptPlanetLayer. Raids: strategy layer white/black lists (91).

## Orbital content

GenSteps: OrbitalPlatform / Satellite / Relay / Wreck / Mechhive. MapDrawLayer_OrbitalDebris. WorldObject `Gravship` lives on layers and launches between tiles/layers.

## Modding

- New layer = PlanetLayerDef + layerType class + worldDrawLayers + whitelist policy (empty whitelist + onlyAllow* = very closed layer).
- Incidents/arrival modes must opt into layer or be blocked.
- Space layers: `isSpace` changes assumptions (caravans, biomes, buildings).
- Test view gizmo + connection graph or players can’t navigate.

See also SketchResolver_Gravship (88), Gravship render (99).
