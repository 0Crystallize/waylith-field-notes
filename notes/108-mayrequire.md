# 108 — MayRequire* attributes

**Confidence:** observed (`MayRequireAttribute` + DLC variants)

XML/C# soft dependency markers:

- `MayRequireAttribute(modId)`
- `MayRequireRoyalty` / Ideology / Biotech / Anomaly / Odyssey
- `MayRequireAnyOfAttribute`

Used so fields/defs parse when DLC/mod absent without hard refs. Pair with LoadFolders `IfModActive` (43) for whole folders.

## Modding

- Prefer MayRequire on optional cross-DLC fields in Defs.
- Odyssey content: MayRequireOdyssey + PlanetLayer whitelists (100).
