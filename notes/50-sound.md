# 50 — Sound (one-shot & sustainers)

**Confidence:** observed (`Verse.Sound.SoundStarter`, `SustainerManager`) + audio backend note 30

## API

```csharp
soundDef.PlayOneShot(SoundInfo.…)
soundDef.PlayOneShotOnCamera(map?)
soundDef.TrySpawnSustainer(info)  // sustain == true only
```

- **Main thread** required for PlayOneShot / OnCamera.
- OnCamera: needs at least one `onCamera` subSound; optional map gate (`Find.CurrentMap` + DrawingMap).
- Sustainer vs one-shot mismatch → Error.
- Slots: `SoundSlotManager.CanPlayNow(soundDef.slot)`.
- Undefined SoundDef: DevMode + DefEditor open may hot-reload SoundDefs and retry.

## Sustainers

`SustainerManager` registers/updates all; `EndAllInMap` on map dispose. Scope limits per SoundDef (max simultaneous). Optional `sustainStartSound` one-shot before spawn.

## Waylith

Backend differs from Unity audio (note 30) but game API stays SoundDef/subSounds. Prefer defs + SoundStarter over raw AudioSource.
