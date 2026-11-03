# 94 — Relations & interactions

**Confidence:** observed (`PawnRelationDef`, `Pawn_RelationsTracker`, `InteractionWorker`)

## Relations

`Pawn_RelationsTracker` on pawn — family/social links via PawnRelationDef (worker classes for opinion, incest checks, etc.). Generation can seed relations (`CanGeneratePawnRelations` on request).

## Interactions

`InteractionDef` + `InteractionWorker`:

- `RandomSelectionWeight(initiator, recipient)`
- `Interacted(...)` → optional letter outs + RulePack sentence extras

Social tick picks interactions by weight.

## Modding

- New chitchat/romance: InteractionDef + worker; keep weights low unless common.
- Letters from Interacted must be translated (67).
