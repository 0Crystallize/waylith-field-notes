# 79 — Genes & xenotypes (Biotech)

**Confidence:** observed (`Verse.Gene`, `Verse.GeneDef`, `RimWorld.XenotypeDef`)

## GeneDef / Gene

Defs in **Verse** namespace. Runtime `Gene` on pawn gene tracker; many specialized `Gene_*` / `Gene_Resource` subclasses (hemogen, deathrest…).

Templates / implied defs: `GeneTemplateDef`, `GeneDefGenerator`. UI: GeneUtility / GeneUIUtility. Genepacks hold `GeneSet`.

## XenotypeDef

List of GeneDefs + inheritable, icons, combatPowerFactor, factionless weight, nameMaker chance, forbidden weapon classes, double-xenotype chances, archite detection via gene category.

## Modding

- New xenotype = XML genes + XenotypeDef; custom behavior → Gene subclass or gene comps/hediffs.
- Don’t put GeneDef under wrong assembly namespace in docs/patches — **Verse.GeneDef**.
- Archite / metabolic complexity still enforced by vanilla biostats — respect or intentionally break with care.
