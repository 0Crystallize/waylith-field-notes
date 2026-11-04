# 134 — Biosculpter, growth vat, mech carrier

**Confidence:** observed (`CompBiosculpterPod`, `Building_GrowthVat`, `CompMechCarrier`) — expands 79 / 85

## Biosculpter

Cycles via `CompBiosculpterPod_Cycle` comps. Nutrition liquified (need 5). Biotuning, age-reversal auto, power trader, suspended contents, held pawn draw pose. State machine `BiosculpterPodState`.

## Growth vat

Embryo or pawn growth: `AgeTicksPerTickInGrowthVat = 20`, embryo gestation **540000** ticks. Nutrition buffer 10; biostarvation daily offset. Insert pawn/embryo gizmos; storage settings.

## Mech carrier

Fixed ingredient → spawn mechanoids (`costPerPawn`, `maxPawnsToSpawn`). Autofill amount; `TrySpawnPawns`.

## Modding

- New biosculpter cycle: CompProperties cycle subclass on the pod.
- Carrier: CompProperties_MechCarrier costs; respect CanSpawn AcceptanceReport.
