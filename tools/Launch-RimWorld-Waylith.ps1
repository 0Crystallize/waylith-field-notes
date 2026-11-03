<#
.SYNOPSIS
  Launch RimWorld 1.7 / Waylith with optional VRAM residency knobs.

.DESCRIPTION
  From field notes (02, 06, 12, 23):
  - WAYLITH_VRAM_BUDGET_MB caps residency heap (earlier offload)
  - -EagerTextureUpload → TextureResidency.Policy = OffloadUnderPressure
    (boot default without the flag is OnDemand)

  Prefer Assets.zip bake (Bake-ModAssetPacks.ps1) over fighting loose DDS alone.
  Do NOT pass -noEvictAtlasSources / -noCompressAtlases (inflate VRAM).

.PARAMETER VramBudgetMb
  Env WAYLITH_VRAM_BUDGET_MB. Example: 8192 on a 12GB GPU.

.PARAMETER MemoryReport
  Adds -MemoryReportAfterBoot

.PARAMETER NoEagerUpload
  Leave residency at OnDemand (engine default for RimWorld boot).

.PARAMETER RimWorldExe
  Optional; Steam auto-detect if omitted (same helper idea as bake script).

.PARAMETER ExtraArgs
  Extra RimWorld CLI tokens (with or without leading '-').
#>
[CmdletBinding()]
param(
  [int]$VramBudgetMb = 8192,
  [switch]$MemoryReport,
  [switch]$NoEagerUpload,
  [string]$RimWorldExe = "",
  [string[]]$ExtraArgs = @()
)

$ErrorActionPreference = "Stop"

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
  foreach ($c in $candidates) {
    if ($c -and (Test-Path $c)) { return (Resolve-Path $c).Path }
  }
  throw "RimWorld exe not found. Pass -RimWorldExe."
}

function Normalize-Arg([string]$a) {
  if (-not $a) { return $null }
  if ($a.StartsWith("-")) { return $a }
  return "-$a"
}

$exe = Find-RimWorldExe $RimWorldExe
$env:WAYLITH_VRAM_BUDGET_MB = "$VramBudgetMb"

$argList = New-Object System.Collections.Generic.List[string]
if (-not $NoEagerUpload) { $argList.Add("-EagerTextureUpload") }
if ($MemoryReport) { $argList.Add("-MemoryReportAfterBoot") }
foreach ($a in $ExtraArgs) {
  $n = Normalize-Arg $a
  if ($n) { $argList.Add($n) }
}

Write-Host "WAYLITH_VRAM_BUDGET_MB=$env:WAYLITH_VRAM_BUDGET_MB"
Write-Host "Args: $($argList -join ' ')"
Write-Host "Exe: $exe"
Start-Process -FilePath $exe -ArgumentList $argList.ToArray() -WorkingDirectory (Split-Path $exe)
