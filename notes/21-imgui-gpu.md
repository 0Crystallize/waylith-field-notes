# 21 — ImGui GPU memory

**Confidence:** observed (`ImGuiGpuMemory`, `ImGuiVulkanRenderer`)

## Учёт

Tracker label: `"UI/ImGui"`.

| Resource | Category |
|----------|----------|
| Vertex/Index host buffers | `DynamicDraw` (PreferCpu / HostVisible\|Coherent) |
| Font atlas image | `UITexture` |
| Font atlas upload staging | `Staging` |

`UITexture` / `DynamicDraw` **не** входят в `TextureResidency.IsOffloadable` (только GameTexture/Atlas). UI не уедет в system offload тем же механизмом.

## Font atlas

`WantCreate`: allocate `ImGui.FontAtlas` R8G8B8A8, sampled+transferDst, track UITexture.  
Updates: host staging buffer → one-time cmd buffer → copy → sampled layout.  
Destroy: remove tracker + free.

User textures: dictionary `GpuTextureAllocation → UserTexture`, idle list + release.

## Масштаб

ImGui обычно меньше, чем мод-текстуры мира, но:

- богатые TMP/font atlases + частые resize vertex buffers  
- видно в `GpuMemoryReport` под UI/ImGui  

Не главный рычаг TDR пака, но не «ноль» в отчётах.
