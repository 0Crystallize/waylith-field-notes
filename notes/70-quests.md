# 70 — Quests

**Confidence:** observed (`Quest`, `QuestManager`)

## Quest

Scripted by `QuestScriptDef` → QuestParts + slate signals (`Quest{id}.Added` / `.Initiate`).  
Lifecycle: appear → accept/expire → parts run → endOutcome → cleanupTick.

hidden / hiddenInUI / parent / charity / points / challengeRating / tags.

## QuestManager

Holds active quests; ticks; signal routing (`ISignalReceiver`).

## Modding

- Prefer QuestScriptDef XML + existing QuestPart_* over raw C#.
- Custom QuestPart for new behaviors; send signals, don’t bypass slate.
- Save: parts must ExposeData; avoid non-scribed closures in callbacks.
