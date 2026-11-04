# 107 — Entities & codex (Anomaly)

**Confidence:** observed (`EntityCodex`, `CompEntityHolder`, `Verse.Entity`)

## Verse.Entity

Abstract spawnable label+tick base (not “Anomaly monster” alone — Thing/Pawn hierarchy sits above). Anomaly **entities** are pawns/things studied/held.

## Holding

`CompEntityHolder` / Platform: containment strength stat, HeldPawn, Container, EjectContents, Available. Workgivers: tend / transfer / execute / release / take to platform. Jobs: CarryToEntityHolder*, TendEntity, ExecuteEntity.

## Codex

`Find.EntityCodex`: discovery per `EntityCodexEntryDef` / categories.  
`SetDiscovered` → signal **`EntityDiscovered`**, message, delayed letter, unlocks linked research, HiddenItemsManager.  
Research can stay Hidden until entry discovered.

UI: Dialog_EntityCodex, ChoiceLetter_EntityDiscovered, ITab_Entity.

## Modding

- New study target: EntityCodexEntryDef + category + research links; call SetDiscovered on first sight/capture.
- Holders: CompProperties_EntityHolder* + platform building; containment strength outdoors/doors matter.
- Capture/transfer float menus: FloatMenuOptionProvider_CaptureEntity / TransferEntity.
