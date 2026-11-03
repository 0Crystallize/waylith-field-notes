# 53 — ModContentPack & assemblies

**Confidence:** observed (`ModContentPack`, `ModAssemblyHandler`)

## Identity

`PackageId` (lowercased), `PackageIdPlayerFacing`, load order, official ProductPackageIDs (Core + DLCs).

Holders: textures (`ModContentHolder<Texture2D>`), `ModAssetBundlesHandler`, `ModAssemblyHandler`, defs list.

## ReloadContent

`ReloadContentInt`: textures → (other content) → assetBundles.  
`ReloadContent` also `assemblies.ReloadAll()`.

## Assemblies

`GetAllFilesForModPreserveOrder(mod, "Assemblies/", *.dll)` — **LoadFolders-aware** order.  
`Assembly.LoadFrom` → `GetTypes()` must succeed (`AssemblyIsUsable`); failure logs ReflectionTypeLoadException loader exceptions and **skips** (stops further loads on LoadFrom exception via break).

`GenTypes.ClearCache()` after each usable assembly.

## After load

`LoadedModManager` → `ModLoadingHooks.RunAfterAssembliesLoaded` (35, 25).

## Practice

- Put 1.7 DLLs under versioned `Assemblies` via LoadFolders (43).
- Target net10 + UnityStubs/Waylith refs; missing deps → ReflectionTypeLoadException at GetTypes.
- One broken DLL can abort remaining assembly loads in that mod (`break` on LoadFrom failure).
