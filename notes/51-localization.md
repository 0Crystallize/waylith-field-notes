# 51 — Localization (Keyed / inject)

**Confidence:** observed (`LanguageDatabase`, `Translator`, `LoadedLanguage`) + canon-ru rule

## Runtime

- `LanguageDatabase.activeLanguage` from `Prefs.LangFolderName` (default English).
- `SelectLanguage` → clear play data → `LoadAllPlayData` (full reload).
- `"Key".Translate()` / `TryTranslate` / args overloads; missing → key + optional PseudoTranslated in some modes.
- `GuiBackend.SetTextLanguage` on init.

## Mod files

Under LoadFolders version:

- `Languages/<Folder>/Keyed/*.xml` — UI/job strings
- `Languages/<Folder>/DefInjected/<DefType>/*.xml` — def fields

Do **not** hardcode RU in C# or scatter UI strings in PatchOperation. `defName` / logs stay EN identity.

## RU style notes (community / pack)

Prefer vanilla RU RimWorld voice: infinitives in job/UI strings, not calques. Prefer BundledRussian / official injects over duplicate overlays. Controversial terms: ask / document once.

