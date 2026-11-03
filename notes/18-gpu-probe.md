# 18 — GPU probe / HardwareProfile

**Confidence:** observed (`HardwareProfile`, `GpuProbe`, `GpuPerformanceProfile`)

## Когда

`Bootstrap.ConfigureTextureRuntime` → `HardwareProfile.BeginProbe(graphicsDevice)` (фон/async job).

## Что меряет

`GpuProbe.Run` (budget ~1500 ms wall):

- HLSL compute: `AluProbeCS`, `BandwidthProbeCS` (`Compute/GpuProbe.comp.hlsl`)
- device-local buffers (bandwidth probe input до 256 MiB)
- timestamps или wall clock fallback
- результат кэшируется (`GpuPerformanceProfileStore`) per device key

## Профиль

```text
AluGFlopsPerSecond
MemoryBandwidthGBPerSecond
AluSaturationThreads
Measured

ComputeScore  = ALU / 1036
BandwidthScore = BW / 71.6
OverallScore = sqrt(Compute * Bandwidth)

Tier: Low < 6.5 ≤ Medium < 12 ≤ High
```

`Conservative` = zeros, Measured=false → Low tier.

## Зачем нам

Это **compute/bandwidth tier**, не прямой VRAM budget.  
Residency watermark’и завязаны на DXGI/VMA heap + `WAYLITH_VRAM_BUDGET_MB`, не на OverallScore (**observed** раздельность).

Probe полезен понимать логи «GPU probe: … High/Medium/Low» и кэш профиля; не ждать от него лечения TDR от текстур.
