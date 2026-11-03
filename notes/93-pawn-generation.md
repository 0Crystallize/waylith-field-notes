# 93 — Pawn generation

**Confidence:** observed (`PawnGenerator`, `PawnGenerationRequest`)

## Entry

```csharp
PawnGenerator.GeneratePawn(kindDef, faction?, tile?)
PawnGenerator.GeneratePawn(request)
PawnGenerator.RedressPawn(pawn, request)
```

Internal may reuse/redress world pawns then apply request constraints.

## PawnGenerationRequest

Large options struct: KindDef (or getter from xenotype), Context, Faction, Tile, force new, body type, allow dead/downed/gay/pregnant/food/addictions, traits force/prohibit, violence capability, relation chances, biocode chances, validators pre/post gear, fixed ages/gender/name, ForcedXenotype, …

## Modding

- Fill a request rather than constructing Pawn manually.
- Validators + prohibited traits beat post-hoc deletes.
- ScenParts hook Notify_NewPawnGenerating / PawnGenerated (89).
