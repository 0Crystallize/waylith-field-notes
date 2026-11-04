# 125 — QuestGen.QuestNode

**Confidence:** observed (`RimWorld.QuestGen.QuestNode`) — expands 70

Abstract node: `Run()` → `RunInt()`; `TestRun` → `TestRunInt(Slate)`. Optional `selectionWeight` SlateRef. Short type name strips `QuestNode_` prefix for translations (`myTypeShort`).

Errors dump slate vars. `testRunCallback` slate action for tooling.

Hundreds of concrete nodes (`QuestNode_HasGravEngine`, math, lists, …).

## Modding

- Custom quest script: subclass QuestNode, register via quest XML script; implement both RunInt and TestRunInt.
- Gravship-aware nodes exist — reuse rather than reimplement launch checks.
