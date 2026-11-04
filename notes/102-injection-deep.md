# 102 — Waylith.Injection (deep)

**Confidence:** observed (`Injection`, `InjectionProcessor`, `InjectedFieldAttribute`, `ComponentInjectionSites`) — expands note 25

## Attribute

`[InjectedField(Default = …, Initializer = …)]` on methods that act as field accessors (getter/setter conventions via `IAccessorConvention`).

## Pipeline

1. Bootstrap / AfterAssembliesLoaded → `Injection.ProcessAssemblies`
2. `InjectionProcessor` collects methods with InjectedField and/or convention Describe → Requests
3. Accepts → IL **splices** rewriting method bodies to touch injected fields
4. Runtime apply: `QueueForFrameBoundary` / `ApplyPendingAtFrameBoundary` → `FieldInjection.ApplyPending`
5. Stale Harmony: `RegisterStaleMethodHandler` / `HarmonyRegenerate` — must regenerate patches if body rewritten (abort risk if mid-emit)

Also: `RegisterAccessorConvention`, `BindAccessor`, `HasRewrittenBody`, `LogSink`.

`ComponentInjectionSites` maps Unity/Verse component patterns for injection targets.

## Modding

- Prefer Injection for Prepatcher-like field inject when targeting 1.7 Waylith.
- Don’t Harmony-patch methods that Injection will rewrite without regenerating.
- ApplyPending runs on frame boundary — don’t assume fields exist before first OnUpdate after load.
