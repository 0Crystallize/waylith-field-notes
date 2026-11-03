# 67 — Letters

**Confidence:** observed (`Verse.Letter`, `LetterDef`)

## Letter

Stack UI + archive (`IArchivable`). Fields: def, label, lookTargets, relatedFaction, arrivalTick.  
`OpenLetter()` abstract; draw button; right-click dismiss.

IncidentWorker helpers send ChoiceLetter / standard letters (55).

## LetterDef

Icon, color, sound, letterClass — XML driven.

## Modding

- Prefer `LetterMaker.MakeLetter` + `Find.LetterStack.ReceiveLetter`.
- LookTargets for jump-to; translate label/text via TaggedString / Keyed.
- Choice letters: options with callbacks — keep save-safe (no capturing unserializable state without care).
