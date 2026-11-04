# 133 — Pawn_RoyaltyTracker

**Confidence:** observed (`RimWorld.Pawn_RoyaltyTracker`) — expands 63 / 71

Per-pawn Royalty state:

- Titles: `AllTitlesForReading` / `InEffect`, `MostSeniorTitle`, `TryUpdateTitle`, favor get/set/gain
- Permits: `AllFactionPermits`, Add/Has/Refund, permit points, aid permit
- Abilities list from titles
- Room / apparel requirement toggles; decree ticks

## Modding

- Grant title/permit via tracker APIs — don’t invent parallel favor stores.
- Custom permits: RoyalTitlePermitDef + worker; wire through AddPermit.
