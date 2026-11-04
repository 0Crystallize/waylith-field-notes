# 139 — Settlement (Odyssey hooks)

**Confidence:** observed (`RimWorld.Planet.Settlement`) — expands 95 / 99

Classic trader settlement plus:

- `GravShipCanLandOn` — false for player faction settlements
- `CanBeSettled` AcceptanceReport
- Visitable / Attackable / quests related flags
- Named by player; FormCaravan / Attack / SellableItems commands

## Modding

- Custom world object landing: override GravShipCanLandOn / settlement rules carefully for Odyssey.
- Trade still via Settlement_TraderTracker.
