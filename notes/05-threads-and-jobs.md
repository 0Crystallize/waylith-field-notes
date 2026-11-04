# 05 — Threads & jobs

**Confidence:** observed (поверхностно) + **khatum**

## Observed поверхности

| Тип | Роль (по имени/фрагментам) |
|-----|----------------------------|
| `RenderThread` | отдельный render loop / stop в crash stacks |
| `RenderToMainThreadDispatcher` | marshal render→main |
| `MainThreadSynchronizationContext` | sync context |
| `WaylithJobRuntime` | job system (в crash: `WaylithJobs: frame=…`) |
| `LoadingScope` / `ProgressCounter` | load progress |
| `AssetPrefetcher` workers | I/O decode threads |
| `FrameProfiler` / `ThreadEventQueue` | profiling |

## Load path (thin worker)

- Загрузка модов идёт не на «толстом» стеке процесса; LongEvent worker historically thin (~1 MiB default thread stack)
- PE `SizeOfStackReserve` на exe **не** спасает `new Thread(ThreadStart)` workers
- Pack-side fat stack для LongEvent / FatLoadTail — локальный костыль; процедуры сюда не копировать

## Правило для будущих идей

Любой «I/O Thread Separation 2.0» обязан стыковаться с:

1. `AssetPrefetcher` (уже есть)
2. `GpuTextureService` pending batches + `FlushPendingTextureCommands` на render/map pass
3. `TextureResidency.Update` / `CanRunResidencyWork`

Параллельный самодельный uploader без этих контрактов — гонка со staging/fences (**inferred**).
