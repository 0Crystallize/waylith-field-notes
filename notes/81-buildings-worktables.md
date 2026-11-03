# 81 — Building & worktables

**Confidence:** observed (`Verse.Building`, `Building_WorkTable`)

## Building

Thing subclass for edifices: power, rooms, HP, claim, deconstruct, etc. Large surface — prefer comps (`CompPowerTrader`, `CompFacility`, …) over subclassing Building when possible.

## Building_WorkTable

Bill host (`IBillGiver`) — BillStack, usable checks, work speed. Recipes via `recipes` / recipe users (note 66).

## Modding

- New production building: ThingDef (building) + comps + recipes + work table class if needed.
- Interaction cell / linkable facilities matter for room roles and work giver reachability.
