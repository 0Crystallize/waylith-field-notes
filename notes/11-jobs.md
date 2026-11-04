# 11 — WaylithJobRuntime

**Confidence:** observed (сигнатуры + static ctor фрагменты)

## Модель

Отдельный пул worker-потоков (`Workers`), не ThreadPool BCL:

- `For` / `ScheduleFor` / `Schedule` / `Complete`
- struct jobs через `IWaylithParallelForJob`
- chunked parallel-for
- `dependsOn` для простых зависимостей handle’ов
- `BeginFrame(frameIndex)` из main `EngineApplication.BeginFrame`
- crash dumps показывают счётчики `WaylithJobs: frame=…, pending=…`

`LoadingScope` / `ProgressCounter` — обёртки прогресса load (детали — по мере надобности).

## Связь с Khatum

Проблемы thin-stack LongEvent / Xml resolve — это **не** обязательно эти Workers; чаще vanilla `new Thread` / LongEvent.  
Не путать `WaylithJobRuntime` workers с load-worker стеком [pack-fixes].

## Правило

Тяжёлый decode/encode текстур у движка идёт через AssetPrefetcher / bake / GpuTextureService, а не через «зашедулить всё в WaylithJobs самому» без контракта.
