# 47 — TickManager & TickList

**Confidence:** observed

## Rates

| TickerType | Interval (game ticks) |
|------------|----------------------|
| Normal | 1 |
| Rare | 250 |
| Long | 2000 |

Things register into one list via def `tickerType` → `RegisterAllTickabilityFor`.

Buckets: `TicksGame % TickInterval` — spreads Rare/Long load across frames.

## DoSingleTick (order sketch)

1. All maps `MapPreTick`
2. Increment `ticksGameInt` (or +2000 if fastEcology)
3. `Shader.SetGlobalFloat(GameSeconds, …)`
4. tickList Normal / Rare / Long → `thing.DoTick()`
5. DateNotifier, Scenario, World, StoryWatcher, GameEnder, Storyteller, Tale, Quest, … (each try/catch)
6. Map post-tick / components (continues below in file)

Frame loop may run multiple single ticks based on `TickRateMultiplier` / time budget (~45ms soft stop vs WorstAllowedFPS 22).

## Modding

- Heavy per-tick work → Rare/Long or MapComponentTick with own cadence.
- Don’t assume one tick per rendered frame (time controls / catch-up).
- Destroyed things skipped in TickList; register/deregister queued then applied at Tick start.
- Multi-map: ticks all maps; ActiveMaps-style mods matter for perf (pack: [local-mod]).
