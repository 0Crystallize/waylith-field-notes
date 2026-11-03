# 59 — Scribe (save/load)

**Confidence:** observed

## Modes

`Scribe.mode`: Inactive / Saving / LoadingVars / ResolvingCrossRefs / PostLoadInit.

`EnterNode` / `ExitNode` — structure XML; ForceStop resets.

## Helpers

| API | Use |
|-----|-----|
| `Scribe_Values.Look(ref T, label, default, forceSave)` | primitives, strings, enums |
| `Scribe_Deep.Look(ref T, label, ctorArgs…)` | nested IExposable |
| `Scribe_References` | Thing/Pawn refs by load ID |
| `Scribe_Collections` | lists/dicts |

Implement `IExposable.ExposeData` on components / custom data. Cross-refs resolve after vars; PostLoadInit for rebuild.

## Mod tips

- Always pair defaults with Look so old saves load.
- Don’t touch Unity/ContentFinder during LoadingVars on wrong assumptions — prefer PostLoadInit for asset binds.
- BackCompatibility hooks exist for renames (BackCompatibility type).
- MapComponent / GameComponent / WorldComponent / ThingComp all expose through this path (46, 45).
