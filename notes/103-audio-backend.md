# 103 — AudioBackend (MiniAudio)

**Confidence:** observed (`Waylith.Audio.AudioBackend`, `MiniAudioBackend`) — expands note 30

## Contract

`AudioBackend.Current` singleton. Abstract: Initialize/Shutdown/Update, master volume, listener pose, groups, LoadSound (path/memory/PCM/stream), Play → voice.

## Streaming thresholds

| Constant | Bytes |
|----------|------|
| `StreamingFileSizeThresholdBytes` | 1 MiB |
| `ModStreamingThresholdBytes` | 307 200 (~300 KiB) |
| TranscodedSizeFactor | ×10 for .ogg/.mp3 length estimate |

`ShouldStream(path)` uses ContentPack length if packed, else FileInfo; ogg/mp3 treated as transcoded.

## Mod sounds

Bake packs sounds as raw entries in Assets.zip (97). Runtime may stream large clips. FSB decode optional (`CanDecodeFsb`).

## Modding

- Prefer SoundDef + SoundStarter (50); don’t talk to MiniAudio directly.
- Huge custom music: expect streaming; keep under thresholds or accept stream path.
- Backend swap is engine-owned — mods shouldn’t replace `Current`.
