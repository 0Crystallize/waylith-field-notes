# 84 — Transporters & shuttle

**Confidence:** observed (`CompTransporter`, `CompShuttle`)

## CompTransporter

Pod/dropship cargo: ThingOwner, launch group, group ID, fuel/mass checks, leave/enter map. Works with transport pod launch UI and arrival actions (planet).

## CompShuttle

Odyssey/modern shuttle: larger surface (autonomy, passengers, missions). Overlaps transporter concepts with shuttle-specific flight.

## Modding

- Arrival behavior: `TransportPodsArrivalAction*` subclasses (land in map, attack, give items…).
- Mass/fuel caps are player-visible — keep UI honest.
- Multi-pod groups share transporter group IDs — don’t break grouping.
