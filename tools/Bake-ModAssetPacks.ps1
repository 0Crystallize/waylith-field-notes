<#
.SYNOPSIS
  Batch-bake Waylith ModAssetPacks (Assets.zip) for RimWorld 1.7 mods.

.DESCRIPTION
  Drives the official engine switch -BakeModAssetPacks=path1;path2;...
  (bake on first OnUpdate, then quit — see notes/09, /12, /23, /96).

  Designed for community packs: point -ModsRoot / -FromFile / -Mods at your folders.
  No pack-specific paths baked in.

.PARAMETER ModsRoot
  Folder that contains mod directories. Used to resolve short names and as default
  scan root for New-BakeableModsList.ps1.

.PARAMETER FromFile
  Text file of mod folder paths (one per line, absolute or relative to ModsRoot).
  Default: <scriptDir>/bake/bakeable_mods.txt

.PARAMETER Mods
  Explicit mod folder names (under ModsRoot) or absolute paths. Replaces FromFile.

.PARAMETER BatchSize
  Mods per RimWorld process. Keep small on VRAM-constrained GPUs (4–8 typical).

.PARAMETER SkipExisting
  Skip mods that already have at least one Assets.zip under the mod tree.

.PARAMETER Force
  Bake even if Assets.zip exists (overrides SkipExisting / stale check).

.PARAMETER SkipStaleCheck
  If a zip exists and -Force is off: do not bake (ignore Textures/Sounds mtimes).

.PARAMETER RimWorldExe
  Path to RimWorld.exe / RimWorldWin64.exe. Auto-detects Steam install if omitted.

.PARAMETER NoKillRunning
  Do not stop RimWorld* processes before each batch (default: kill them).

.PARAMETER DryRun
  Print batches only.

.PARAMETER TimeoutSec
  Per-batch timeout (default 7200).

.EXAMPLE
  .\New-BakeableModsList.ps1 -ModsRoot D:\RimWorld\Mods
  .\Bake-ModAssetPacks.ps1 -ModsRoot D:\RimWorld\Mods -SkipExisting -BatchSize 4

.EXAMPLE
  .\Bake-ModAssetPacks.ps1 -Mods @('MyMod') -ModsRoot D:\RimWorld\Mods -Force
#>
[CmdletBinding()]
param(
  [string]$ModsRoot = "",
  [string]$FromFile = "",
  [string[]]$Mods = @(),
  [int]$BatchSize = 8,
  [switch]$SkipExisting,
  [switch]$Force,
  [switch]$SkipStaleCheck,
  [string]$RimWorldExe = "",
  [switch]$NoKillRunning,
  [switch]$DryRun,
  [int]$TimeoutSec = 7200
)

$ErrorActionPreference = "Stop"
$toolsRoot = $PSScriptRoot
$bakeDir = Join-Path $toolsRoot "bake"
New-Item -ItemType Directory -Path $bakeDir -Force | Out-Null
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$log = Join-Path $bakeDir "bake_$stamp.log"
$summary = Join-Path $bakeDir "bake_$stamp.summary.txt"

function Write-Log([string]$msg) {
  $line = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $msg"
  Add-Content -Path $log -Value $line -Encoding UTF8
  Write-Host $line
}

function Find-RimWorldExe([string]$explicit) {
  if ($explicit) {
    if (-not (Test-Path $explicit)) { throw "RimWorldExe not found: $explicit" }
    return (Resolve-Path $explicit).Path
  }
  $candidates = New-Object System.Collections.Generic.List[string]
  foreach ($prop in @(
      'HKCU:\Software\Valve\Steam',
      'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam',
      'HKLM:\SOFTWARE\Valve\Steam'
    )) {
    $steam = (Get-ItemProperty -Path $prop -Name SteamPath -EA SilentlyContinue).SteamPath
    if ($steam) {
      foreach ($name in @('RimWorld.exe', 'RimWorldWin64.exe')) {
        $candidates.Add((Join-Path $steam "steamapps\common\RimWorld\$name"))
      }
    }
  }
  foreach ($name in @('RimWorld.exe', 'RimWorldWin64.exe')) {
    $candidates.Add((Join-Path ${env:ProgramFiles(x86)} "Steam\steamapps\common\RimWorld\$name"))
    $candidates.Add((Join-Path $env:ProgramFiles "Steam\steamapps\common\RimWorld\$name"))
  }
  foreach ($c in $candidates) {
    if ($c -and (Test-Path $c)) { return (Resolve-Path $c).Path }
  }
  throw "RimWorld exe not found. Pass -RimWorldExe path\to\RimWorld.exe (1.7 / Waylith build)."
}

function Test-HasAssetsZip([string]$modPath) {
  return [bool](Get-ChildItem $modPath -Recurse -Filter "Assets.zip" -EA SilentlyContinue | Select-Object -First 1)
}

function Get-NewestContentMtime([string]$modPath) {
  $newest = [datetime]::MinValue
  foreach ($name in @("Textures", "Sounds")) {
    Get-ChildItem $modPath -Recurse -Directory -Filter $name -Depth 6 -EA SilentlyContinue | ForEach-Object {
      Get-ChildItem $_.FullName -Recurse -File -EA SilentlyContinue | ForEach-Object {
        if ($_.LastWriteTime -gt $newest) { $newest = $_.LastWriteTime }
      }
    }
  }
  return $newest
}

function Get-OldestZipMtime([string]$modPath) {
  $zips = @(Get-ChildItem $modPath -Recurse -Filter "Assets.zip" -EA SilentlyContinue)
  if ($zips.Count -eq 0) { return [datetime]::MinValue }
  return ($zips | Measure-Object LastWriteTime -Minimum).Minimum
}

function Test-NeedsBake([string]$modPath) {
  if ($Force) { return $true }
  $has = Test-HasAssetsZip $modPath
  if ($SkipExisting -and $has) { return $false }
  if (-not $has) { return $true }
  if ($SkipStaleCheck) { return $false }
  $content = Get-NewestContentMtime $modPath
  $zipAge = Get-OldestZipMtime $modPath
  if ($content -eq [datetime]::MinValue) { return $false }
  return ($zipAge -lt $content)
}

function Resolve-ModPath([string]$m, [string]$root) {
  if (Test-Path $m) { return (Resolve-Path $m).Path }
  if ($root) {
    $cand = Join-Path $root $m
    if (Test-Path $cand) { return (Resolve-Path $cand).Path }
  }
  throw "Mod not found: $m"
}

$RimWorldExe = Find-RimWorldExe $RimWorldExe

$paths = New-Object System.Collections.Generic.List[string]
if ($Mods -and $Mods.Count -gt 0) {
  if (-not $ModsRoot) {
    # allow absolute-only -Mods without ModsRoot
    foreach ($m in $Mods) { $paths.Add((Resolve-ModPath $m "")) }
  } else {
    if (-not (Test-Path $ModsRoot)) { throw "ModsRoot not found: $ModsRoot" }
    $ModsRoot = (Resolve-Path $ModsRoot).Path
    foreach ($m in $Mods) { $paths.Add((Resolve-ModPath $m $ModsRoot)) }
  }
} else {
  if (-not $FromFile) { $FromFile = Join-Path $bakeDir "bakeable_mods.txt" }
  if (-not (Test-Path $FromFile)) {
    throw "FromFile missing: $FromFile — run .\New-BakeableModsList.ps1 -ModsRoot <path> first"
  }
  Get-Content $FromFile | Where-Object { $_.Trim() -ne "" -and $_ -notmatch '^\s*#' } | ForEach-Object {
    $p = $_.Trim()
    try {
      if ($ModsRoot -and -not [IO.Path]::IsPathRooted($p)) {
        $paths.Add((Resolve-ModPath $p $ModsRoot))
      } elseif (Test-Path $p) {
        $paths.Add((Resolve-Path $p).Path)
      } else {
        Write-Warning "Skip missing path: $p"
      }
    } catch {
      Write-Warning "Skip missing path: $p"
    }
  }
}

if ($paths.Count -eq 0) { throw "No mod paths to consider." }

$todo = New-Object System.Collections.Generic.List[string]
foreach ($p in $paths) {
  if (Test-NeedsBake $p) { $todo.Add($p) }
  else { Write-Log "SKIP $(Split-Path $p -Leaf)" }
}

Write-Log "Bake start mods=$($paths.Count) todo=$($todo.Count) batch=$BatchSize force=$Force skipExisting=$SkipExisting"
Write-Log "exe=$RimWorldExe"
Write-Log "log=$log"

if ($todo.Count -eq 0) {
  Write-Log "Nothing to bake."
  "todo=0" | Set-Content $summary -Encoding UTF8
  return
}

$batches = @()
for ($i = 0; $i -lt $todo.Count; $i += $BatchSize) {
  $end = [Math]::Min($i + $BatchSize - 1, $todo.Count - 1)
  $batches += , @($todo[$i..$end])
}

$ok = 0; $fail = 0
$batchIdx = 0
foreach ($batch in $batches) {
  $batchIdx++
  $names = ($batch | ForEach-Object { Split-Path $_ -Leaf }) -join ", "
  # Official CLI: semicolon-separated absolute mod roots
  $bakeArg = "-BakeModAssetPacks=" + ($batch -join ";")
  Write-Log "BATCH $batchIdx/$($batches.Count) ($($batch.Count)): $names"
  Write-Log "CMD $RimWorldExe $bakeArg"
  if ($DryRun) { continue }

  if (-not $NoKillRunning) {
    Get-Process -Name "RimWorld*" -EA SilentlyContinue | Stop-Process -Force -EA SilentlyContinue
    Start-Sleep -Seconds 2
  }

  $batchLog = Join-Path $bakeDir "bake_$stamp`_batch$batchIdx.out.log"
  $batchErr = Join-Path $bakeDir "bake_$stamp`_batch$batchIdx.err.log"
  # Single argv element so ';' inside the path list is not split by PowerShell
  $p = Start-Process -FilePath $RimWorldExe -ArgumentList @($bakeArg) -PassThru `
    -WorkingDirectory (Split-Path $RimWorldExe) `
    -RedirectStandardOutput $batchLog -RedirectStandardError $batchErr -WindowStyle Minimized

  $deadline = (Get-Date).AddSeconds($TimeoutSec)
  while (-not $p.HasExited -and (Get-Date) -lt $deadline) {
    Start-Sleep -Seconds 5
  }
  if (-not $p.HasExited) {
    Write-Log "TIMEOUT batch $batchIdx — killing pid=$($p.Id)"
    Stop-Process -Id $p.Id -Force -EA SilentlyContinue
    $fail += $batch.Count
    continue
  }
  Write-Log "batch $batchIdx exit=$($p.ExitCode)"

  foreach ($modPath in $batch) {
    $leaf = Split-Path $modPath -Leaf
    if (Test-HasAssetsZip $modPath) {
      Write-Log "OK $leaf"
      $ok++
    } else {
      Write-Log "FAIL no Assets.zip: $leaf"
      $fail++
    }
  }
}

$msg = "DONE ok=$ok fail=$fail batches=$batchIdx"
Write-Log $msg
Set-Content $summary -Value $msg -Encoding UTF8
if ($fail -gt 0) { exit 1 }
exit 0
