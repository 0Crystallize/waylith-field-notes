# 82 — Zones & areas

**Confidence:** observed (`Zone`, `Area`)

## Zone

Player-drawn map zones (stockpile, growing, dumping, …). Cell sets, UI, ExposeData, designation integration. Subclasses add allow-lists (ThingFilter on stockpile).

## Area

Boolean cell grids (home, snow clear, no-roof, allowed areas for pawns). Cheaper “mask” than full zones for some AI filters.

## Modding

- Custom zone type: subclass Zone + designator; register like vanilla zone types.
- Allowed areas: pawn playerSettings / AreaManager — don’t invent parallel masks without UI.
