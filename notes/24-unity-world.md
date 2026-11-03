# 24 — UnityWorld / UnityCompat

**Confidence:** observed (`Waylith.UnityCompat.UnityWorld`)

## Role

Compat layer that makes Verse/mods think they still live in Unity GameObject/Component world.

`UnityWorld.Current` — singleton-ish access.

## Lifecycle hooks

Events: `Updating`, `LateUpdating`, `PostUpdate`, `PostLateUpdate`, `ObjectDestroyed`.  
`Update` / `LateUpdate` driven from Bootstrap/`UnityRuntime`.  
`DispatchOnGUI` — ImGui host path.

## Registration (Bootstrap uses these)

- `RegisterExecutionOrder(Type, int)` — CameraDriver -103, Root_Entry -50, Root_Play -20, …
- `RegisterResource(path, type, asset)` — AudioMixer etc.
- `RegisterPrefab(path, type, token, instantiate)`
- `RegisterCloneFactory`

## Object graph API (mod-relevant)

Find/load: `LoadResource`, `LoadAllResources`, `FindGameObject`, `FindObjectsByType`  
Components: `AddComponent`, `GetComponent*`, `TryGetComponent`  
Hierarchy: transform parent/children/sibling, active flags  
`DontDestroyOnLoad`, `DestroyObject`, scene unload/roots  
`GetDiagnosticsSnapshot`

## StubWarner

UnityStubs logs when unsupported Unity APIs are hit; `-SuppressUnityStubs` quiets.  
Mods should treat warnings as “this Unity API is not really implemented”.

## Practical

- Prefer Verse APIs (`ContentFinder`, `MaterialPool`, `LongEventHandler`) over raw Unity where possible.
- Going direct to `Waylith.*` is possible but **unsupported** by Ludeon guidance; use for diagnostics/advanced packs only.
- Execution order registration is how RimWorld schedules Root/Camera without Unity Editor.
