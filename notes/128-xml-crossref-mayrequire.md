# 128 — DirectXmlCrossRefLoader + MayRequire

**Confidence:** observed (`Verse.DirectXmlCrossRefLoader`) — expands 42 / 108

WantedRef variants: object field, list\<T\>, dictionary. Constructor args include `mayRequireMod` / `mayRequireAnyMod` so missing soft refs fail soft when DLC/mod absent.

Resolve via `GenDefDatabase.GetDefSilentFail`; SoundDef undefined treated as miss. FailMode Silent vs Error.

## Modding

- Optional cross-DLC def fields: MayRequire* on the field **and** mayRequire on the XML attribute — both matter.
- Don’t leave hard refs to Odyssey-only defs without MayRequireOdyssey if Core-only load must succeed.
