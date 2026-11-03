# 03 — GPU memory & TDR

**Confidence:** observed (types) + **khatum** (симптомы пака)

## Учёт памяти (observed)

- `GpuMemoryTracker` — категории, labels, snapshots, top allocations  
- `GpuMemoryReport` / `GpuMemoryHistory` — human summaries (в т.ч. в логах residency)  
- `GpuCrashDiagnostics` — диагностика GPU crash  
- Categories (`GpuMemoryCategory`): MeshVertex/Index, GameTexture, UITexture, Atlas, Font, RenderTarget, Staging, UniformBuffer, ComputeBuffer, DynamicDraw, Other  

Offloaded textures трекаются с label `"OffloadedTexture"`.

## MapMainPass и TDR (**khatum** + observed hook)

**khatum:** на первом кадре карты бывали hangs → Windows TDR → `VK_ERROR_DEVICE_LOST`; в стеках фигурировал `MapRenderFeature.MapMainPass`.

**observed:** `MapMainPass.Record`:

1. `GpuTextureService.FlushPendingTextureCommands()`
2. water depth pre-pass (optional)
3. scene slices / scene grabs / mesh batch record

Связка «дожать pending uploads + полный map pass» объясняет, почему TDR выглядит как «умер MapMainPass», даже если корень — VRAM thrash / долгий submit (**inferred**).

## Когда residency не успевает

Residency помогает при **постепенном** давлении и при OOM retry. Хуже, если:

- hot-set уникальных full-res > device budget (offload ↔ promote ping-pong)
- огромный синхронный flush pending uploads в том же кадре, что и первый MapMain
- host/system тоже забит → eviction на disk cache → I/O stalls в GPU timeline
- TDR timeout Windows короче, чем «честный» recover path

Тогда снова работают capacity-рычаги: меньше исходников, bake/BC, `WAYLITH_VRAM_BUDGET_MB` (раньше начать offload), не держать лишние карты/слои (**khatum**/inferred).

## Что смотреть в логах

Искать категории / строки из декомпила:

- `TextureResidency` warnings: device-local refused / system memory refused / over budget
- `GpuMemoryReport` compact summary (движок сам дописывает в эти warning’и)
- `DEVICE_LOST` / `MapMainPass` / `GpuCrashDiagnostics`

Не путать с managed abort `0xc00000fd` (часто Harmony/stack) — см. triage skill.
