# 07 — Frame loop (main ↔ render)

**Confidence:** observed (`EngineApplication.RunLoop`, `RenderThread`, `FrameRenderer`)

## Кто есть кто

| Thread | Роль |
|--------|------|
| **Main / producer** | `RunLoop`: input, game update, residency, `CaptureFrame`, `Enqueue` |
| **RenderThread** | `BlockingCollection<RenderFrame>` → record/submit/present |

`RenderThread.Start()` запоминает **producer thread id = поток, вызвавший Start** (main).  
`RenderThread.IsProducerThread` = «мы на main».  
`GpuTextureService.CanRunResidencyWork` требует producer thread и запрещает работу под `_sync` / mid-retire.

**Вывод:** residency крутится на **main**, не на GPU thread. Flush uploads может дергаться и с map pass (см. MapMainPass).

## Порядок кадра (упрощённо)

```
DrainRenderThreadCallbacks
ThrowIfFaulted
GpuMemoryHistory.Update
TextureResidency.Update          ← watermark / offload / promote
TextureBuildBatch.OnFrameStart
GpuMemoryReport.CheckUsageCap(Options.VramWarnCapBytes)
PollEvents / focus / minimize handling
[optional] WaitUntilIdle + swapchain/rebuild
BeginFrame → Time, NativeAlloc, WaylithJobRuntime
Pump MainThreadSynchronizationContext
OnUpdate (игра)
BeginMainThreadFrame
CaptureFrame                     ← features собирают draw lists / payloads
RenderThread.Enqueue(frame)
EndFrame / throttle
```

При minimize / no-render: `RetireGpuResourcesWithoutRendering()` вместо CaptureFrame.

## CaptureFrame / RecordFrame

`FrameRenderer`:

- features: `AddFeature` / dual list main-thread vs in-flight
- `CaptureFrame` — подготовка `RenderFrame` на main
- `RecordFrame` — на render thread: проход по passes с debug labels

RimWorld вешает `MapRenderFeature`, `WorldRenderFeature`, ImGui, PostFx и т.д.  
`MapMainPass.Record` → `GpuTextureService.FlushPendingTextureCommands()` перед mesh record.

## Wiring при ConfigureGpuServices

На `RenderThreadFrameStarting`:

- `MeshUploads.BeginRenderFrame`
- `GpuTextureService.BeginRenderFrame`
- `ComputeBufferResourceManager.OnRenderFrameStarting`

## Очередь кадров

Ёмкость `_frames` = `FramesInFlight` (обычно 2).  
Backpressure: `Enqueue` блокируется, если render не успевает — main может ждать (**inferred:** вклад в hitch/TDR-ощущение при тяжёлом MapMain + uploads).

## Focus / background

Без фокуса и без `RunInBackground`: цикл `WaitEventsTimeout(0.1)`, **без** CaptureFrame — residency/update в этом режиме не крутятся в том же path (цикл `continue` до BeginFrame). Стоит помнить при «почему VRAM не offload’ится в фоне» (**inferred**).
