# 115 — Save / load & meta header

**Confidence:** observed (`GameDataSaveLoader`, `ScribeMetaHeaderUtility`) — expands 59

## Containers

SafeSaver parent nodes: `savegame`, `savedscenario`, `savedworld`, `savedideo`, `savedXenotype`, `savedXenogerm`, `savedModList`, `cameraConfig`. Inner: `game`, `scenario`, …

## Save gates

`SavingIsTemporarilyDisabled` when:

- Tile picker active
- Windows prevent save
- **`WorldComponent_GravshipController.CutsceneInProgress`**

`CurrentGameStateIsValuable` ≈ ticks since last save > 60.

## Meta

`WriteMetaHeader`: gameVersion, modIds (PackageId), modSteamIds, modNames.  
Load compares → `modListChanged` / version fields for dialogs.

## Modding

- Custom save blobs: follow SafeSaver + meta write; don’t invent parallel XML roots without header.
- Gravship cutscene: UI must respect save disabled.
- BackCompatibility converters still run on old saves (separate type family).
