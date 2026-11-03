# 00 — Scope & sources

**Pin (first capture):** RimWorld `1.7.4995 rev309`  
**Waylith product:** `1.0.0+9711575089c3d58df2eb1f09b45de3914b286ae1`  
**UnityStubs / ACS commit fragment:** `41fb34228c24bb10001f7c2ec979b82ddc322517`  
**Brutal.\*:** `2026.9.0+…` (record hashes locally when you refresh)

## How these notes were produced

1. Copy selected DLLs from a local RimWorld **1.7 unstable** install into a private sandbox (do not redistribute).
2. Inventory types with `ilspycmd -l c`.
3. Decompile only the types needed for a question; summarize into notes.
4. Pin Version.txt + ProductVersion / content hashes every refresh.

## Assemblies that matter most

- `Waylith.dll` — engine (render, residency, jobs, logging)
- `Waylith.UnityCompat.dll` — Unity object world
- `Waylith.AssetBake.dll` — content bake/cache
- `UnityStubs.dll` — Unity-shaped API surface
- `RimWorld.dll` — `RimWorldWaylith.*` (MapMainPass, Bootstrap, …)
- `Assembly-CSharp.dll` — Verse / game (huge; touch surgically)
- `Brutal.Vulkan*`, `Brutal.Texture`, `Brutal.Ktx`, …

## Official docs elsewhere

- Ludeon blog / [Modder Primer](https://rimworldwiki.com/wiki/Modding_Tutorials/RimWorld_1.7_Mod_Updates) — mod migration, stubs, GLSL shaders
- Deep residency / VMA / MapMainPass / LongEvent stack behavior are **not** covered there → purpose of this repo

## Rules

- Do not patch or redistribute install binaries for “docs”.
- Do not commit decompiled trees or DLL copies to git.
- Separate pack-specific workarounds from engine contracts (label pack repros clearly).
