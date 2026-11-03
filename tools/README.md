# Tools — Waylith mod asset bake

Unofficial helpers for RimWorld **1.7 / Waylith**. They wrap the engine CLI; they do not ship game binaries.

## Why bake?

Waylith prefers **`Assets.zip`** (ModAssetPack) over loose PNG/DDS for residency / upload. Official switch:

```text
RimWorld.exe -BakeModAssetPacks=C:\Mods\MyMod;C:\Mods\OtherMod
```

Bakes on the first `OnUpdate`, then quits (no normal Entry boot). Details: [notes/09](../notes/09-asset-packs-and-bake.md), [12](../notes/12-bootstrap.md), [23](../notes/23-cli-catalog.md), [96](../notes/96-bake-script.md).

## Scripts

| Script | Role |
|--------|------|
| `New-BakeableModsList.ps1` | Scan a Mods folder → `bake/bakeable_mods.txt` + CSV inventory |
| `Bake-ModAssetPacks.ps1` | Batch-run `-BakeModAssetPacks=` with skip/stale/force + logs |
| `Launch-RimWorld-Waylith.ps1` | Optional play launch with `WAYLITH_VRAM_BUDGET_MB` / `-EagerTextureUpload` |

## Quick start

```powershell
cd path\to\waylith-field-notes\tools

# 1) Inventory (required once / when mods change)
.\New-BakeableModsList.ps1 -ModsRoot "D:\RimWorld\Mods"

# 2) Dry-run batches
.\Bake-ModAssetPacks.ps1 -ModsRoot "D:\RimWorld\Mods" -SkipExisting -BatchSize 4 -DryRun

# 3) Bake (closes any running RimWorld* by default)
.\Bake-ModAssetPacks.ps1 -ModsRoot "D:\RimWorld\Mods" -SkipExisting -BatchSize 4
```

Single mod:

```powershell
.\Bake-ModAssetPacks.ps1 -ModsRoot "D:\RimWorld\Mods" -Mods @('my.mod.packageid') -Force
```

Custom exe:

```powershell
.\Bake-ModAssetPacks.ps1 -RimWorldExe "E:\Games\RimWorld\RimWorld.exe" -ModsRoot "..." -SkipExisting
```

## Parameters worth knowing

**Bake-ModAssetPacks.ps1**

- `-BatchSize` — mods per process (lower if GPU TDR / OOM during bake)
- `-SkipExisting` — skip if any `Assets.zip` already under the mod
- `-Force` — rebake always
- Default (neither Force nor SkipExisting): bake if **no zip** or zip **older** than newest file under `Textures/` / `Sounds/`
- `-NoKillRunning` — do not kill existing RimWorld processes (default: kill `RimWorld*`)
- Logs under `tools/bake/bake_<stamp>.log` (+ per-batch stdout)

**Success check:** after each batch, script looks for `Assets.zip` under the mod tree. Engine may still write zips under versioned load folders (`1.6/`, `1.7/`, …).

## Play knobs (optional)

```powershell
.\Launch-RimWorld-Waylith.ps1 -VramBudgetMb 8192
.\Launch-RimWorld-Waylith.ps1 -NoEagerUpload   # keep OnDemand residency
```

Bake first; launch knobs do not replace asset packs.

## Safety

- Backup existing `Assets.zip` before large `-Force` runs.
- Use a **1.7 Unstable / Waylith** build that implements `-BakeModAssetPacks=`.
- Script may kill `RimWorld*` processes between batches (pass `-NoKillRunning` to disable).
- Do not commit your private `bake/bakeable_mods.txt` if it contains local absolute paths you care about.

## License

Same as the repo (CC BY 4.0). Scripts are provided as-is for modders.
