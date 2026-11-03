# 32 — Profiling & crash surfaces

**Confidence:** observed

## FrameProfiler

Used heavily in `EngineApplication.RunLoop` scopes (`TextureResidency`, `CaptureFrame`, `GameUpdate`, …).  
`CurrentTickProvider` set from `Current.Game.tickManager` in Bootstrap.  
`IgnoreThrottle` interacts with FPS cap path.

Dev menu: Frame Profiler action (Primer/wiki).

## ProcessMemoryReport

CLI `MemoryReportAfterBoot`; also callable.  
Useful alongside `GpuMemoryReport` for “RAM vs VRAM” splits.

## GpuCrashDiagnostics / FileLog crash

On DEVICE_LOST / native GPU death, diagnostics + crash dialog (`NoCrashDialog` to suppress).  
Always attach newest crash report + Player.log when filing upstream.

## Modding practice

- Profile **first map frame** separately from steady state (uploads + MapMain + residency).
- Log categories `TextureResidency`, `GraphicsDevice`, `GpuProbe` are high-signal for GPU issues.
- Harmony: never patch emit/validate mid-flight on Waylith (abort class) — see LongEvent/Harmony notes.
