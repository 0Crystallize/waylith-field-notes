# 57 — Window / WindowStack

**Confidence:** observed (`Window`)

## Flags (selected)

| Field | Effect |
|-------|--------|
| `layer` | WindowLayer (Dialog default) |
| `doCloseX` / `doCloseButton` | |
| `closeOnAccept` / `closeOnCancel` / `closeOnClickedOutside` | |
| `forcePause` | |
| `absorbInputAroundWindow` | |
| `onlyOneOfTypeAllowed` | |
| `draggable` / `resizeable` | |
| `preventCameraMotion` | default true |
| `forceCatchAcceptAndCancel…` | |

Override `DoWindowContents(Rect)`, `InitialSize`, open via `Find.WindowStack.Add`.

## Modding

- Prefer one window type instance (`onlyOneOfTypeAllowed`).
- Settings UI: `Mod.DoSettingsWindowContents` inside game Options, not always a full Window.
- Don’t block LongEvent with modal that needs content load mid-async (44).
