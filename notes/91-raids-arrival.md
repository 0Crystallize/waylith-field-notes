# 91 — Raid strategies & arrival modes

**Confidence:** observed (`RaidStrategyDef`, `PawnsArrivalModeWorker`)

## RaidStrategyDef

`workerClass` → RaidStrategyWorker; selection curves by points/faction; planet layer white/black lists; arriveModes list; letter/arrival text; loot factor; food flag.

## PawnsArrivalModeWorker

`CanUseWith` / OnMap / OnTile, selection weight, **`Arrive`**, **`TryResolveRaidSpawnCenter`**, transporter arrival hook.

Edge walk-in, drop pods, caves, etc. are worker subclasses.

## Modding

- New entrance style: PawnsArrivalModeDef + worker; register on strategies that should use it.
- Spawn center resolution must set parms.spawnCenter / spawnRotation appropriately before Arrive.
