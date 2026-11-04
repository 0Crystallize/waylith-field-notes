# 124 — DebugActionAttribute

**Confidence:** observed (`LudeonTK.DebugActionAttribute`, `LudeonTK.Dialog_Debug`)

Attribute on static methods for Dev mode menu:

- `category`, `name`, `actionType`, `displayPriority`, `hideInSubMenu`
- DLC gates: `requiresRoyalty|Ideology|Biotech|Anomaly|Odyssey`
- `allowedGameStates` bitflags: Entry / Playing / WorldRenderedNow / IsCurrentlyOnMap / HasGameCondition

`IsAllowedInCurrentGameState` combines program state, world-selected, map, conditions, ModsConfig.

UI: `Dialog_Debug` (+ option listers).

## Modding

- Ship tools with `[DebugAction(...)]` — respect Odyssey/Anomaly flags.
- Don’t put cheats in Production without DevMode check (attribute already filters states).
