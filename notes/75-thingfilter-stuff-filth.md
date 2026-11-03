# 75 — ThingFilter, stuff, filth

**Confidence:** observed (`ThingFilter`, `StuffProperties`, `RimWorld.Filth`)

## ThingFilter

Saveable allow-list for categories / ThingDefs / special filters, hit points & quality ranges. Used by bills, storage, traders, zone settings.

UI tree via `RootNode` / `OverrideRootNode`. ExposeData for player configs.

## StuffProperties

On stuff ThingDefs (`stuffProps`): categories, color, commonality, stat factors/offsets, appearance. Buildings/apparel with `stuffCategories` pull these at make-time.

## Filth

`RimWorld.Filth` : Thing — thickness (≤5), sources list, optional multi-instance draw, thicken/thin, disappear timers, `CanDropAt` + FilthSourceFlags.

Terrain/`FilthMaker`-style spawners create it; cleaning jobs target filth things.

## Modding

- Storage/bill mods: clone/configure ThingFilter carefully (deep copy on bill clone paths).
- Custom stuff: StuffProperties + stuffCategories membership.
- Filth defs: ThingDef with filth class; don’t leave permanent thickness without disappear/clean.
