# 04 — Logging / stack capture

**Confidence:** observed + **khatum**

## FileLog

`Waylith.Logging.FileLog`:

- файл: `Logs/Player.log` (+ `Player-prev.log`)
- `CaptureStackTraces` **default = true**
- backlog до старта: 5000 строк
- flush timer 1s

## WaylithLogFormatter

`EnableStackTraces` **default = false**, но:

```text
StackTrace берётся если EnableStackTraces || FileLog.IsCapturingStacks || LogStream.HasListeners
```

И дальше в файл уходит stack, если `FileLog.CaptureStackTraces`.

Стек: `new StackTrace(7, fNeedFileInfo: true)` — дорогой путь с file info.

## Официальные свитчи (observed в `RimWorldWaylith.Program`)

- `-NoFileLogCallstacks` → `FileLog.CaptureStackTraces = false`
- `-DisableLogStackTraces` → `WaylithLogFormatter.EnableStackTraces = false`
- `-NoFileLog` → `FileLog.Disabled = true`

## Khatum

На thin LongEvent-воркере массовый `Log.Message` + capture стеков давал native abort / SO (**khatum**). PackFixes глушил те же флаги в ctor.

Предпочтение: официальный CLI, когда экспериментируем без PackFixes. Метка в `LOCAL_FIXES` про early mute — пересмотреть относительно `-NoFileLogCallstacks` + fat load stack.
