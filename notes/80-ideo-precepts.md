# 80 — Ideo & precepts (Ideology)

**Confidence:** observed (`Ideo`, `Precept`, `StyleItemDef`)

## Ideo

Large runtime culture object: precepts, styles, memes, rituals, roles, apparel requirements, icon/color. Generated and player-edited.

## Precept

`Precept` + many `Precept_*` subclasses. Tied to PreceptDef / issue; Init/Regenerate with Ideo; tips, alerts, apparel requirements, impact sorting.

Rituals hang off precepts → RitualBehaviorWorker / LordJob_Ritual (notes 71, 64).

## StyleItemDef

Hair/beard/tattoo/etc. style catalog for ideoligions and pawns.

## Modding

- Prefer PreceptDef / MemeDef XML + existing precept classes.
- Custom precept class when you need new alerts/rituals/apparel rules.
- Ideo generation is order-sensitive — test with multiple cultures.
