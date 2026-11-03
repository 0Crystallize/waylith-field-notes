# 76 — TerrainDef

**Confidence:** observed

## Fields (selected)

- Textures: `texturePath`, edge shapes (O/U/corner/loop paths), `edgeType`, optional `customShader` + parameters
- Water: `waterDepthShader` (+ params)
- `renderPrecedence`, `affordances`, `layerable`, `scatterType`
- Behavior: footprints/splashes, natural, avoidWander, changeable, smoothedTerrain, gravshipReplacementTerrain, holdSnowOrSand, paintable, extinguishesFire
- `color`, fertility/pathCost/etc. (full def large)

Edge/loop shaders default toward `ShaderDatabase.TerrainEdge` / Transparent when unset.

## Map mesh

Terrain drawn via `SectionLayer_Terrain` (+ edges/watergen) — dirty `MapMeshFlag` terrain bits on change (note 36).

## Modding

- New floors: TerrainDef XML + affordances; smooth pairs via `smoothedTerrain`.
- Custom edge look: shader paths + shape textures; Waylith GLSL (notes 14, 29, 37).
- Don’t forget Research/cost/designation for player-buildable terrain.
