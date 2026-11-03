# 52 — GenFilePaths (saves, config, mods)

**Confidence:** observed

## Save data root

`SaveDataFolderPath` — `-savedatafolder=` or platform persistent path (Mac nests `…/RimWorld` under parent of persistentDataPath).

Under it:

| Path | Use |
|------|-----|
| `Config/` | Prefs.xml, ModsConfig.xml, KeyPrefs.xml, … |
| `Saves/` | save games |
| `Screenshots/`, `DevOutput/` | |

`ModsFolderPath` → game `Mods` (create if needed). Official content under `Data`.

## ContentPath\<T\>

Folder segment for Resources/bundles (Textures, Sounds, …) — used by ContentFinder.

## Modding / tools

- Respect `savedatafolder` in CI / multi-instance.
- Don’t write next to game install for user config — use Config under save data.
- EarlyPrefs (39) duplicates Prefs path logic for pre-init reads.
