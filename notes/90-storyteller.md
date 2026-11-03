# 90 — Storyteller

**Confidence:** observed (`Storyteller`, `StorytellerComp`)

## StorytellerComp

`MakeIntervalIncidents(target)` → `FiringIncident` stream.  
`GenerateParms`, category filters, pawn/dissolution notifies, Initialize.

StorytellerDef lists comps with StorytellerCompProperties. Threat points via StorytellerUtility / population intent curves.

## Modding

- New pacing: StorytellerComp + properties def — cleaner than Harmony on Storyteller.TryFire.
- Reuse IncidentDefs (55); comps choose *when*, workers *what*.
- Debug: `DebugTablesIncidentChances`.
