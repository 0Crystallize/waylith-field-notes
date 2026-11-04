# 00 — Scope & sources

**Pin (first capture):** RimWorld `1.7.4995 rev309`  
**Waylith product:** `1.0.0+9711575089c3d58df2eb1f09b45de3914b286ae1`  
**UnityStubs / ACS commit fragment:** `41fb34228c24bb10001f7c2ec979b82ddc322517`  
**Brutal.* :** `2026.9.0+…` (см. `MANIFEST.json`)

## Что копировали

Sandbox: `_sandbox/waylith/bin/`

Ключевые сборки для field notes:

- `Waylith.dll` — движок (рендер, residency, jobs, logging)
- `Waylith.UnityCompat.dll` — Unity object world
- `Waylith.AssetBake.dll` — bake/cache контента
- `UnityStubs.dll` — API surface «как Unity»
- `RimWorld.dll` — `RimWorldWaylith.*` (MapMainPass и т.п.)
- `Assembly-CSharp.dll` — игра/Verse (огромный; трогаем точечно)
- `Brutal.Vulkan*`, `Brutal.Texture`, `Brutal.Ktx`, `VulkanEx`

## Инструменты

- `ilspycmd` 9.0.0.7889 (на машине; 11.x требует более новый SDK)
- Списки: `decomp/lists/*.entities.txt` / `*.hits.txt`
- Типы: `decomp/types/*.cs`

## Официальное снаружи

- Ludeon blog / Modder Primer — миграция модов, stubs, шейдеры GLSL
- Глубины residency / VMA / MapMainPass в Primer **нет** → это как раз предмет field notes

## Запреты для агентов

- Не править файлы установки RimWorld на диске ради доков
- Не править live `Mods\` из этой ветки работы
- Не путать field notes с локальным pack-fixes логом (костыли пака)
