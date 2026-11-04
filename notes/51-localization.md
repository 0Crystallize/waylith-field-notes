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

## Pack canon (Khatum)

See workspace canon-ru: infinitive UI, Крадол, синдер, prefer BundledRussian / official over duplicate injects. Glossary: `[pack]/Tools/glossary-ru.md`. Skill: `[ru-skill]`.
