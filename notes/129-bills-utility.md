# 129 — BillUtility

**Confidence:** observed (`RimWorld.BillUtility`) — expands 66

Static helpers around bills:

- `Clipboard` bill for copy/paste UI
- `MakeNewBill(RecipeDef, Precept_ThingStyle?)`
- Enumerate `GlobalBillGivers` / `MapBillGivers` / bills
- Slot-group / colonist-unavailable notifies
- Ingredient order + bill-giver container containment
- Surgery violation vs extra-faction member
- Info window helper

Workgiver resolution: `GetWorkgiver(IBillGiver)`.

## Modding

- Custom bill UI: reuse Clipboard + MakeNewBill; notify slot groups on stockpile changes.
- Style precepts affect MakeNewBill — Ideology aware.
