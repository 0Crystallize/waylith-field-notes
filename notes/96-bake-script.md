# 96 — Community bake scripts (`tools/`)

**Confidence:** observed (engine CLI) + **observed** (batch driver behavior)

## What shipped

Under [`tools/`](../tools/README.md):

| File | Purpose |
|------|---------|
| `Bake-ModAssetPacks.ps1` | Batch wrapper around `-BakeModAssetPacks=` |
| `New-BakeableModsList.ps1` | Inventory → `bake/bakeable_mods.txt` + CSV |
| `Launch-RimWorld-Waylith.ps1` | Optional play launch with VRAM / Eager knobs |

## Engine contract (unchanged)

```text
RimWorld.exe -BakeModAssetPacks=<absPath1>;<absPath2>;...
```

Bootstrap (note 12): bake mode skips Entry; first `OnUpdate` runs `ModAssetPackBake` → per load folder with Textures/Sounds → `ModAssetPacks.BakeForUpload` → `Assets.zip`, then quit.

BC7 / Kaiser / RawMaxSize defaults: note 09.

## Driver design

1. Resolve exe (explicit or Steam registry / common paths).
2. Collect mod roots from `-Mods`, or `bake/bakeable_mods.txt`.
3. Filter with `-Force` / `-SkipExisting` / stale check (zip mtime vs Textures+Sounds).
4. Split into batches of `-BatchSize`.
5. For each batch: optional kill `RimWorld*`, start process with **one** argv (`-BakeModAssetPacks=a;b;c` so PowerShell does not split on `;`), wait / timeout, verify `Assets.zip` exists under each mod.

## Why batching

Full pack bake can be hundreds of mods; one process with everything risks VRAM TDR / long hangs. Small batches (4–8) isolate failures and keep GPU cooler.

## Inventory heuristic

`HasBakeableContent(loadFolder)` in-engine = `Textures/` **or** `Sounds/` directory exists (exact).  
`New-BakeableModsList` matches that at mod-root (also scans depth ≤ 6 for nested version folders). Still pass `-Mods` explicitly for odd layouts.

Deep bake internals: note **97**.

## Operational notes

- Success = zip present after process exit (exit code from game may be empty/unreliable in redirected runs).
- Some mods fail a batch slot (no zip) while siblings succeed — re-run with `-Mods @('that.mod') -Force` or inspect game log.
- Versioned `LoadFolders` (note 43): zip may appear under `1.7/` etc.; recursive zip search covers that.
- Prefer bake over “only downscale loose DDS” for Waylith residency (notes 02, 03, 09).

## Related

CLI catalog 23 · Asset packs 09 · Bootstrap bake path 12 · Launch env 06.
