# 114 — Power nets

**Confidence:** observed (`RimWorld.PowerNetManager`, `PowerNet`, `CompPower`, `CompPowerTrader`)

## Manager

Per-map. Register/deregister of transmitters & connectors is **delayed** (`DelayedAction` queue) so spawn/despawn mid-tick doesn’t tear nets immediately. Wire mesh dirty: `NotifyDrawersForWireUpdate`.

`Notfiy_TransmitterTransmitsPowerNowChanged` = deregister+register pair (typo preserved in API).

Connectors skip duplicate register while Scribe inactive.

## Comp

`CompPower` / trader / transmitter — classic net membership; traders pull from net energy.

## Modding

- New power buildings: CompProperties_Power* + link types; don’t rebuild AllNets manually.
- During load (`Scribe.mode != Inactive`) connector register is gated — expose carefully.
