# 74 — Effecters, flecks, motes

**Confidence:** observed (`Effecter`/`EffecterDef`, `FleckDef`, `RimWorld.FleckMaker`, `RimWorld.MoteMaker`)

## Effecter

Def-driven multi-child VFX (`SubEffecter` list). Spawn helpers on `EffecterDef`: `Spawn`, `SpawnMaintained`, `SpawnAttached` (cell/thing/TargetInfo pairs, scale/offset).

Runtime: `EffectTick(A,B)`, `Trigger`, `ForceEnd`/`Cleanup`, optional `ticksLeft`. Verbs often `AddEffecterToMaintain`.

Prefer EffecterDef XML for cast/impact FX bundles.

## Flecks (modern lightweight)

`FleckDef`: `fleckSystemClass` (Thrown/Static/Splash…), altitude, GraphicData, fade/solid times, accel/speed, growth, collide, arch curves.

`FleckMaker` static helpers: Static, AttachedOverlay, dust/smoke/sparks/footprints/water, meta puffs, explosion cells.

Cheaper than Thing motes — prefer flecks for ephemeral particles.

## Motes (Thing-based)

`MoteMaker`: static/attached/dual-attached overlays, text, bubbles (mood/thought/speech), connecting lines, explosion interiors. Spawn real `Mote` Things.

Use when you need Thing semantics (attach links, interaction overlays). Otherwise flecks.

## Waylith

Still go through Graphics/mesh submission; heavy mote spam = draw cost (notes 17, 33, 40).
