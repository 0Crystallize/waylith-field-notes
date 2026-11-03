# 78 — VerbTracker & IVerbOwner

**Confidence:** observed (`VerbTracker`)

Owns/creates Verb instances for an `IVerbOwner` (CompEquippable, abilities, hediff verb givers, …).

- Builds verbs from VerbProperties / tools / maneuvers
- Primary verb accessors; ticks verbs; exposes DirectOwner
- Load IDs via `Verb.CalculateUniqueLoadID`

Equipment pickup/loss notifies verbs (`Notify_PickedUp` / `Notify_EquipmentLost`).

## Mod tip

Adding verbs at runtime: go through the owner’s VerbTracker / comps — don’t orphan Verb instances without a tracker (ExposeData / UniqueLoadID break).
