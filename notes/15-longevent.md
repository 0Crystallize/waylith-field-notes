# 15 — LongEventHandler (load worker)

**Confidence:** observed (`Verse.LongEventHandler`) + **khatum**

## Модель

Очередь `QueuedLongEvent`:

- sync enumerator / sync action на main
- **async**: `doAsynchronously` → `UpdateCurrentAsynchronousEvent` → `new Thread(ThreadStart)` **без явного stack size**

```csharp
eventThread = new Thread((ThreadStart)obj); // default stack
eventThread.Start();
```

`RunEventFromAnotherThread`: EnsureEnglish + invoke action + exceptionHandler.

Также: `ExecuteWhenFinished` list; scene load async через `SceneManager.LoadSceneAsync`.

## Почему это больно на Waylith

Default managed thread stack (~1 MiB) + глубокий XML/Harmony + optional `FileLog` stack capture с file info → **khatum** abort/`0xc00000fd`.

Крупные паки иногда патчат **этот** `new Thread` на fat stack — это не `WaylithJobRuntime` workers.

## Официальные рычаги рядом

- `-NoFileLogCallstacks` уменьшает давление на стек при Log
- Fat stack — всё ещё наш слой, пока upstream не поднимет stack async LongEvent

## Boot gating

`Bootstrap.RaiseBootCompleteOnce` ждёт `!LongEventHandler.AnyEventNowOrWaiting` — load events блокируют BootCompleted / after-boot switches.
