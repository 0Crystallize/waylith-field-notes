# 64 — Lords (group AI)

**Confidence:** observed (`Lord`, `LordJob`, `LordToil`)

## Pieces

- **Lord** — runtime group on a map: pawns/buildings/corpses, faction, current LordJob + StateGraph + CurLordToil.
- **LordJob** — `CreateGraph()` abstract; tick/cleanup; many Notify_* (pawn lost, mental, buildings…).
- **LordToil** — `UpdateAllDuties()` abstract; duty hooks, float menus, gizmos, fail conditions.

Start via LordMaker / incidents / quests → `lord.SetJob(lordJob)`.

## Modding

- Raids, rituals, caravans-on-map, custom events → LordJob + toils + transitions in StateGraph.
- Duties drive JobGiver; don’t fight the duty think tree blindly.
- ExposeData on job/toil data for save.
- ShouldExistWithoutPawns / KeepExistingWhileHasAnyBuilding for structure-centric lords.
