# 121 — MemoryUtility unload

**Confidence:** observed (`Verse.Profile.MemoryUtility`)

- `UnloadUnusedUnityAssets()` — Unity Resources/GC style cleanup after content churn.
- `ClearAllMapsAndWorld()` — tear down map/world references (menu return / reload).

Pair with ContentPack `DropResidentPages` and texture residency offload (02) — different layers (managed Unity stubs vs GPU residency vs mmap pages).

## Modding

- After huge def reload / language switch, game may call unload — don’t hold Texture2D forever in statics without weak policy.
- Gravship / multi-map: ClearAllMapsAndWorld is nuclear — only game lifecycle.
