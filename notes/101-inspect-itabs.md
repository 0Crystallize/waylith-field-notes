# 101 — Inspect pane, ITabs, main tabs

**Confidence:** observed (`ITab`, `MainTabsRoot`, `InspectPaneFiller`, `FloatMenuMakerMap`, `MainTabWindow`)

## Main tabs

`MainTabsRoot` tracks open `MainTabWindow` via WindowStack.  
`ToggleTab` / `SetCurrentTab` / `EscapeCurrentTab`.  
RMB empty map → Architect. Selecting nothing / world view auto-closes Inspect.  
Tutor events: `MainTab-{defName}-Open`.

Main buttons = `MainButtonDef` → worker + TabWindow type.

## Inspect

`MainTabWindow_Inspect` hosts object tabs.  
`InspectPaneFiller.DoPaneContentsFor` draws health/mood/timetable/area/energy bars + inspect string (`ISelectable`). Errors swallowed with ErrorOnce.

## ITab

`RimWorld.ITab` : `InspectTabBase` — selected object(s) via Selector. Valid only while Inspect tab open and this tab is in `CurTabs`. Close plays TabClose.

Wire via ThingDef / Race props `inspectorTabs` / `inspectorTabsResolved` (vanilla pattern). Many specialized ITab_* (Bills, Storage, Genes, Entity, …).

## Float menus

`FloatMenuMakerMap.GetOptions(selectedPawns, clickPos, out context)` — provider-based options; `ShouldGenerateFloatMenuForPawn`; auto-take helper.

## Modding

- New building tab: subclass ITab + register on def; draw with Widgets (Immediate mode — note 21/57).
- Don’t assume Inspect stays open across world/map switches.
- Float menu: prefer `FloatMenuOptionProvider` patterns over Harmony on GetOptions when possible (1.5+ style).
- Keep pane DoPaneContents cheap — runs every frame while selected.
