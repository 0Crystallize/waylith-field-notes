<#
.SYNOPSIS
  Inventory mods under a Mods root that look bakeable for Waylith Assets.zip.

.DESCRIPTION
  Heuristic (not the engine HasBakeableContent API): any mod folder that contains
  a Textures/ or Sounds/ directory (depth ≤ 6). Writes:

    bake/bakeable_mods.txt   — one path per line (for Bake-ModAssetPacks.ps1)
    bake/inventory_<stamp>.csv — size / existing zip summary

.PARAMETER ModsRoot
  Folder containing mod directories (required).

.PARAMETER OutDir
  Default: <scriptDir>/bake

.PARAMETER RelativePaths
  Write paths relative to ModsRoot (portable list). Default: absolute paths.

.EXAMPLE
  .\New-BakeableModsList.ps1 -ModsRoot D:\RimWorld\Mods
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$ModsRoot,
  [string]$OutDir = "",
  [switch]$RelativePaths
)

$ErrorActionPreference = "Stop"
if (-not (Test-Path $ModsRoot)) { throw "ModsRoot not found: $ModsRoot" }
$ModsRoot = (Resolve-Path $ModsRoot).Path
if (-not $OutDir) { $OutDir = Join-Path $PSScriptRoot "bake" }
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$listPath = Join-Path $OutDir "bakeable_mods.txt"
$csvPath = Join-Path $OutDir "inventory_$stamp.csv"

function Test-LooksBakeable([string]$modPath) {
  foreach ($name in @("Textures", "Sounds")) {
    $hit = Get-ChildItem $modPath -Recurse -Directory -Filter $name -Depth 6 -EA SilentlyContinue |
      Select-Object -First 1
    if ($hit) { return $true }
  }
  return $false
}

function Get-TexMB([string]$modPath) {
  $bytes = [long]0
  Get-ChildItem $modPath -Recurse -Directory -Filter "Textures" -Depth 6 -EA SilentlyContinue | ForEach-Object {
    Get-ChildItem $_.FullName -Recurse -File -EA SilentlyContinue | ForEach-Object { $bytes += $_.Length }
  }
  return [math]::Round($bytes / 1MB, 1)
}

function Get-ZipStats([string]$modPath) {
  $zips = @(Get-ChildItem $modPath -Recurse -Filter "Assets.zip" -EA SilentlyContinue)
  $zipMB = [math]::Round((($zips | Measure-Object Length -Sum).Sum / 1MB), 1)
  if (-not $zipMB) { $zipMB = 0 }
  return @{ Count = $zips.Count; MB = $zipMB; Has = ($zips.Count -gt 0) }
}

$rows = New-Object System.Collections.Generic.List[object]
$paths = New-Object System.Collections.Generic.List[string]

Get-ChildItem $ModsRoot -Directory -EA Stop | ForEach-Object {
  $modPath = $_.FullName
  if (-not (Test-LooksBakeable $modPath)) { return }
  $zip = Get-ZipStats $modPath
  $texMB = Get-TexMB $modPath
  $outPath = if ($RelativePaths) { $_.Name } else { $modPath }
  $paths.Add($outPath)
  $rows.Add([pscustomobject]@{
      Mod     = $_.Name
      Path    = $outPath
      TexMB   = $texMB
      ZipCount = $zip.Count
      ZipMB   = $zip.MB
      HasZip  = $zip.Has
    })
}

$paths | Set-Content $listPath -Encoding UTF8
$rows | Sort-Object TexMB -Descending | Export-Csv $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "Wrote $($paths.Count) mods → $listPath"
Write-Host "Inventory CSV → $csvPath"
Write-Host "Next: .\Bake-ModAssetPacks.ps1 -ModsRoot `"$ModsRoot`" -SkipExisting -BatchSize 4"
