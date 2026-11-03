# 72 — Caravans (world)

**Confidence:** observed (`RimWorld.Planet.Caravan`)

## Nature

`WorldObject` + `IThingHolder` + `IIncidentTarget` + `ITrader`.  
Trackers: pather, tweener, trader, forage, needs, carry, beds, babies; StoryState.

Player-controlled when faction is player. ImmobilizedByMass, night resting, shuttle dirty flags.

## Modding

- World incidents target caravans via IIncidentTarget.
- Path: Caravan_PathFollower — don’t teleport Tile without stopping pather.
- Inventory = pawns + carried things in ThingOwner hierarchy.
- Draw uses WorldMain path / altitude (notes 49, 40).
