# 43 — LoadFolders.xml

**Confidence:** observed (`ModLoadFolders`, `LoadFolder`)

## Shape

Per-version lists (`v1.6`, `1.7`, or `default` — default deprecated warning). Leading `v` stripped.

Each folder entry:

| Attribute | Meaning |
|-----------|---------|
| (inner text) | Relative folder; `/` or `\` = mod root |
| `IfModActive` | required **any** of packageIds (comma) |
| `IfModActiveAll` | required **all** |
| `IfModNotActive` | fail if **any** of those active |

`LoadFolder.ShouldLoad` uses `ModLister.*NoSuffix` (packageId without `_steam` etc.).

## Validation (`GetIssueList`)

Empty list, duplicate folders, malformed version, out-of-order versions, missing directories, version not in SupportedVersions.

## Practice (1.7 / Waylith)

- Put versioned Assemblies/Defs/Languages under `1.6` / `1.7` (or shared + conditional).
- RU injects: same LoadFolders version as content (skill `[ru-skill]`).
- Conditional folders for DLC/mod soft deps beat giant PatchOperationFindMod trees for whole trees of assets.
