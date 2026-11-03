# 39 — Prefs & EarlyPrefs

**Confidence:** observed (`Verse.Prefs` / `PrefsData`, `RimWorldWaylith.EarlyPrefs`)

## Prefs.xml

Path: `{persistentData}/Config/Prefs.xml`  
Override root with `-savedatafolder=` (empty arg → root separator).

`EarlyPrefs.Read(element)` — XML element value **before** full Prefs init (bootstrap / GPU / window). Uses same path rules; Mac nests under parent `RimWorld` folder.

## PrefsData (game-facing, selected)

| Field | Notes |
|-------|--------|
| `textureCompression` | default **true** → `Prefs.TextureCompression` |
| `preferredGpuName` / `preferredGpuUuid` | GPU pick |
| `preferredMonitor` | `EngineWindow.SetPreferredMonitor` |
| `plantWindSway` | plant materials |
| `uiScale` / system scaling flags | |
| `devMode`, `logVerbose`, `openLogOnWarnings` | diagnostics |
| `runInBackground` | `Application.runInBackground` |

`PrefsData.Apply()` — main thread only; resolution / fullscreen / cursor / audio listener.

## Modding

- Don’t write Prefs from mods casually; users own Config.
- Reading `Prefs.TextureCompression` affects runtime compress path (notes 16, 23) — not a substitute for Assets.zip bake.
- Early boot decisions (monitor/GPU) may need `EarlyPrefs` if Prefs not loaded yet — rare for mods; mostly engine.
