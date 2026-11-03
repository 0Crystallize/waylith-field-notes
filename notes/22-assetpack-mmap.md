# 22 — AssetPack mmap / DropResidentPages

**Confidence:** observed (`AssetPack`, `ContentPack`)

## Open

`AssetPack.TryOpen`: file handle + `MemoryMappedFile` view (read).  
Entries/aliases dictionary; codecs (Store / Lz4 / …).  
`MappedBytes` = length of mapped region.

## DropResidentPages

После play-data load (и при recovery path):

```text
Windows: VirtualUnlock(base, length)
Unix:    madvise(base, length, MADV_DONTNEED)  // advice=4
```

Страницы OS могут быть вытеснены; последующий read page-fault’нет снова.  
Цель — не держать **весь** `Assets.zip` residency в RAM после того, как нужные ассеты уже в Texture2D / texture cache.

Не путать с GPU texture residency: это **CPU/OS** working set пака.
