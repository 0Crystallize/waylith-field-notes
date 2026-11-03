# 42 — DefDatabase, XML patches, extensions

**Confidence:** observed (`DefDatabase<T>`, `PatchOperation*`, `DefModExtension`)

## DefDatabase\<T\>

- `AddAllInMods` — unique defName per source; duplicates Error; also adds patched defs labeled `"Patches"`.
- Soft limit warning at >65535 defs of one T (short hash).
- `ResolveAllReferences` — per-def `ResolveReferences()`, optional parallel; errors logged, continue.
- `ErrorCheckAllDefs` — `ConfigErrors()` unless `ignoreConfigErrors`.
- Lookup: `GetNamed` / `GetNamedSilentFail` / short hash / `GetRandom`.

## PatchOperation

Base `Apply` wraps `ApplyWorker` + `success` mode: Normal / Invert / Always / Never.  
Failed forever → `Complete` Error with mod id + sourceFile.

Common workers: Add / Insert / Remove / Replace / SetName / Attribute* / Sequence / Test / Conditional / FindMod / AddModExtension.

## DefModExtension

Abstract; XML under `<modExtensions>`. Override `ConfigErrors`, `ResolveReferences(Def parentDef)`.  
Prefer extensions over Harmony for data-only hooks.

## Modding tips

- Patches run in mod load order; FindMod/Conditional for soft deps.
- Don’t patch Core defs with Replace when Add/Insert suffices — merge-friendly.
- defName is identity; never localize it (canon).
