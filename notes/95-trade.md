# 95 — Trade

**Confidence:** observed (`TradeSession`, `TradeDeal`, `StockGenerator`)

## Session

`TradeSession.SetupWith(trader, negotiator, giftMode)` builds `TradeDeal`; `Close` clears.  
`ITrader` (caravan, orbital, settlement…) supplies currency and stock.

## StockGenerator

Per TraderKindDef: abstract `GenerateThings` / `HandlesThingDef`, count & price ranges, tech level caps, PriceType.

## Modding

- Custom trader stock: StockGenerator subclass on TraderKindDef.
- Gift mode still uses deal validation (`cannotSellReasons`).
- Prices: respect Tradeability and PriceType helpers.
