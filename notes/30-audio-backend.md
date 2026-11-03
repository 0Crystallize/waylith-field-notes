# 30 — AudioBackend

**Confidence:** observed (abstract surface; MiniAudio concrete in RimWorld)

## Thresholds

- Stream if size ≥ **1 MiB** (×10 if treated as transcoded)
- Mod streaming threshold property default **300 KiB** (`ModStreamingThresholdBytes`)

## API

`Current` singleton: Initialize/Shutdown/Update, master volume, listener, pause output (focus loss in RunLoop).  
Groups, LoadSound path/memory/PCM, stream sounds, Play voices.  
`CanDecodeFsb` virtual (default false).

## Prefetch

`AssetPrefetcher.EnqueueAudio` during mod content load (with textures).

## Modding

- Large custom music/SFX: expect streaming; don’t assume full decode into RAM.
- Focus-loss pauses output via engine — don’t fight unless intentional.
- Asset packs can include Sounds/ in bake (`ModAssetPacks.SoundFiles`).
