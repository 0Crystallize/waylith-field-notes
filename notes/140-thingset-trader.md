# 140 — ThingSetMaker & TraderKindDef

**Confidence:** observed (`ThingSetMaker`, `TraderKindDef`) — expands 95

## ThingSetMaker

Abstract generate into list with `ThingSetMakerParams`. `CanGenerate`, debug all-generatable defs, `thingsBeingGeneratedNow` stack. Def wraps maker via ThingSetMakerDef.

## TraderKind

`stockGenerators`, `orbital`, royalty `permitRequiredForTrading` / title required, `tradeCurrency`, commonality curves, `WillTrade` / `PriceTypeFor`.

## Modding

- Reward/loot: ThingSetMaker subclass + def.
- Orbital traders: `orbital = true`; gate with Odyssey as needed.
- Royal trade: set permit/title requirements on kind.
