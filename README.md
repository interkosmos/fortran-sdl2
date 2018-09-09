# f03sdl2
Interface to [Simple DirectMedia Layer 2](https://www.libsdl.org/) (SDL 2) for
Fortran 2003/2008/2018, using ISO C bindings. Versions tested against:

Library   | Version
----------|--------
SDL       | 2.0.7
SDL_image | 2.0.2
SDL_mixer | 2.0.1_1
SDL_ttf   | 2.0.14_1

The interface compiles with GNU Fortran 7/8 and Flang 5. On Linux, you have to
install BSD make (`bmake`) in order to use the provided Makefile.

## Build SDL2
Use BSD make to build the SDL2 interface:
```
$ make sdl2
```
You can override the default compiler (GNU Fortran 8) by passing the `FC`
argument, for example:
```
$ make sdl2 FC=flang
```
Or just run your favourite Fortran compiler directly:
```
$ flang -c sdl2.f90
```

## Build SDL2_image
Build the SDL2_image interface with:
```
$ make sdl2_image
```
Add `-lSDL2_image` to your `LD_FLAGS` to link SDL2_image.

## Build SDL2_mixer
Build the SDL2_mixer interface with:
```
$ make sdl2_mixer
```
Add `-lSDL2_mixer` to your `LD_FLAGS` to link SDL2_mixer.

## Build SDL2_ttf
Build the SDL2_ttf interface with:
```
$ make sdl2_ttf
```
Add `-lSDL2_ttf` to your `LD_FLAGS` to link SDL2_ttf.

## Examples
Some demo applications are provided in directory `examples`.

* **window** opens a  window and fills a rectangle (software renderer).
* **image** loads and displays an image (software renderer).
* **events** polls SDL events.
* **scaling** displays a scaled image (software renderer).
* **translucence** makes one color of an image translucent (software renderer).
* **bounce** loads a PNG file with SDL_image and lets it bounce on the screen (hardware renderer).
* **music** plays an OGG file with SDL_mixer.
* **text** outputs text with SDL_ttf.
* **draw** draws some shapes (hardware renderer).

Build the examples with:
```
$ make <name>
```

## Known Issues

* The surface returned by `ttf_render_text_solid()` can’t be freed, as it causes a segmentation fault.
* Text rendered by `ttf_render_text_solid()` has wrong colour.

## Coverage
### SDL

Name                                  | Bound |
--------------------------------------|-------|
SDL_AddEventWatch                     |   –   |
SDL_AddHintCallback                   |   –   |
SDL_AddTimer                          |   –   |
SDL_AllocFormat                       |   –   |
SDL_AllocPalette                      |   –   |
SDL_AllocRW                           |   –   |
SDL_AndroidGetActivity                |   –   |
SDL_AndroidGetExternalStoragePath     |   –   |
SDL_AndroidGetExternalStorageState    |   –   |
SDL_AndroidGetInternalStoragePath     |   –   |
SDL_AndroidGetJNIEnv                  |   –   |
SDL_AtomicAdd                         |   –   |
SDL_AtomicCAS                         |   –   |
SDL_AtomicCASPtr                      |   –   |
SDL_AtomicDecRef                      |   –   |
SDL_AtomicGet                         |   –   |
SDL_AtomicGetPtr                      |   –   |
SDL_AtomicIncRef                      |   –   |
SDL_AtomicLock                        |   –   |
SDL_AtomicSet                         |   –   |
SDL_AtomicSetPtr                      |   –   |
SDL_AtomicTryLock                     |   –   |
SDL_AtomicUnlock                      |   –   |
SDL_AudioInit                         |   –   |
SDL_AudioQuit                         |   –   |
SDL_BlitScaled                        |   ✓   |
SDL_BlitSurface                       |   ✓   |
SDL_BuildAudioCVT                     |   –   |
SDL_COMPILEDVERSION                   |   –   |
SDL_CalculateGammaRamp                |   –   |
SDL_CaptureMouse                      |   –   |
SDL_ClearError                        |   –   |
SDL_ClearHints                        |   –   |
SDL_ClearQueuedAudio                  |   –   |
SDL_CloseAudio                        |   –   |
SDL_CloseAudioDevice                  |   –   |
SDL_CompilerBarrier                   |   –   |
SDL_CondBroadcast                     |   –   |
SDL_CondSignal                        |   –   |
SDL_CondWait                          |   –   |
SDL_CondWaitTimeout                   |   –   |
SDL_ConvertAudio                      |   –   |
SDL_ConvertPixels                     |   –   |
SDL_ConvertSurface                    |   ✓   |
SDL_ConvertSurfaceFormat              |   –   |
SDL_CreateColorCursor                 |   –   |
SDL_CreateCond                        |   –   |
SDL_CreateCursor                      |   –   |
SDL_CreateMutex                       |   –   |
SDL_CreateRGBSurface                  |   –   |
SDL_CreateRGBSurfaceFrom              |   –   |
SDL_CreateRenderer                    |   ✓   |
SDL_CreateSemaphore                   |   –   |
SDL_CreateSoftwareRenderer            |   –   |
SDL_CreateSystemCursor                |   –   |
SDL_CreateTexture                     |   –   |
SDL_CreateTextureFromSurface          |   ✓   |
SDL_CreateThread                      |   –   |
SDL_CreateWindow                      |   ✓   |
SDL_CreateWindowAndRenderer           |   –   |
SDL_CreateWindowFrom                  |   –   |
SDL_DXGIGetOutputInfo                 |   –   |
SDL_DelEventWatch                     |   –   |
SDL_DelHintCallback                   |   –   |
SDL_Delay                             |   ✓   |
SDL_DestroyCond                       |   –   |
SDL_DestroyMutex                      |   –   |
SDL_DestroyRenderer                   |   ✓   |
SDL_DestroySemaphore                  |   –   |
SDL_DestroyTexture                    |   ✓   |
SDL_DestroyWindow                     |   ✓   |
SDL_DetachThread                      |   –   |
SDL_Direct3D9GetAdapterIndex          |   –   |
SDL_DisableScreenSaver                |   –   |
SDL_EnableScreenSaver                 |   –   |
SDL_EnclosePoints                     |   –   |
SDL_EventState                        |   –   |
SDL_FillRect                          |   ✓   |
SDL_FillRects                         |   –   |
SDL_FilterEvents                      |   –   |
SDL_FlushEvent                        |   –   |
SDL_FlushEvents                       |   –   |
SDL_FreeCursor                        |   –   |
SDL_FreeFormat                        |   –   |
SDL_FreePalette                       |   –   |
SDL_FreeRW                            |   –   |
SDL_FreeSurface                       |   ✓   |
SDL_FreeWAV                           |   –   |
SDL_GL_BindTexture                    |   –   |
SDL_GL_CreateContext                  |   –   |
SDL_GL_DeleteContext                  |   –   |
SDL_GL_ExtensionSupported             |   –   |
SDL_GL_GetAttribute                   |   –   |
SDL_GL_GetCurrentContext              |   –   |
SDL_GL_GetCurrentWindow               |   –   |
SDL_GL_GetDrawableSize                |   –   |
SDL_GL_GetProcAddress                 |   –   |
SDL_GL_GetSwapInterval                |   –   |
SDL_GL_LoadLibrary                    |   –   |
SDL_GL_MakeCurrent                    |   –   |
SDL_GL_ResetAttributes                |   –   |
SDL_GL_SetAttribute                   |   –   |
SDL_GL_SetSwapInterval                |   –   |
SDL_GL_SwapWindow                     |   –   |
SDL_GL_UnbindTexture                  |   –   |
SDL_GL_UnloadLibrary                  |   –   |
SDL_GameControllerAddMapping          |   –   |
SDL_GameControllerAddMappingsFromFile |   –   |
SDL_GameControllerAddMappingsFromRW   |   –   |
SDL_GameControllerClose               |   –   |
SDL_GameControllerEventState          |   –   |
SDL_GameControllerGetAttached         |   –   |
SDL_GameControllerGetAxis             |   –   |
SDL_GameControllerGetAxisFromString   |   –   |
SDL_GameControllerGetBindForAxis      |   –   |
SDL_GameControllerGetBindForButton    |   –   |
SDL_GameControllerGetButton           |   –   |
SDL_GameControllerGetButtonFromString |   –   |
SDL_GameControllerGetJoystick         |   –   |
SDL_GameControllerGetStringForAxis    |   –   |
SDL_GameControllerGetStringForButton  |   –   |
SDL_GameControllerMapping             |   –   |
SDL_GameControllerMappingForGUID      |   –   |
SDL_GameControllerName                |   –   |
SDL_GameControllerNameForIndex        |   –   |
SDL_GameControllerOpen                |   –   |
SDL_GameControllerUpdate              |   –   |
SDL_GetAssertionHandler               |   –   |
SDL_GetAssertionReport                |   –   |
SDL_GetAudioDeviceName                |   –   |
SDL_GetAudioDeviceStatus              |   –   |
SDL_GetAudioDriver                    |   –   |
SDL_GetAudioStatus                    |   –   |
SDL_GetBasePath                       |   –   |
SDL_GetCPUCacheLineSize               |   –   |
SDL_GetCPUCount                       |   ✓   |
SDL_GetClipRect                       |   –   |
SDL_GetClipboardText                  |   –   |
SDL_GetClosestDisplayMode             |   –   |
SDL_GetColorKey                       |   –   |
SDL_GetCurrentAudioDriver             |   –   |
SDL_GetCurrentDisplayMode             |   –   |
SDL_GetCurrentVideoDriver             |   –   |
SDL_GetCursor                         |   –   |
SDL_GetDefaultAssertionHandler        |   –   |
SDL_GetDefaultCursor                  |   –   |
SDL_GetDesktopDisplayMode             |   –   |
SDL_GetDisplayBounds                  |   –   |
SDL_GetDisplayMode                    |   –   |
SDL_GetDisplayName                    |   –   |
SDL_GetError                          |   ✓   |
SDL_GetEventFilter                    |   –   |
SDL_GetGlobalMouseState               |   –   |
SDL_GetHint                           |   ✓   |
SDL_GetKeyFromName                    |   –   |
SDL_GetKeyFromScancode                |   –   |
SDL_GetKeyName                        |   –   |
SDL_GetKeyboardFocus                  |   –   |
SDL_GetKeyboardState                  |   ✓   |
SDL_GetModState                       |   –   |
SDL_GetMouseFocus                     |   –   |
SDL_GetMouseState                     |   –   |
SDL_GetNumAudioDevices                |   –   |
SDL_GetNumAudioDrivers                |   –   |
SDL_GetNumDisplayModes                |   –   |
SDL_GetNumRenderDrivers               |   –   |
SDL_GetNumTouchDevices                |   –   |
SDL_GetNumTouchFingers                |   –   |
SDL_GetNumVideoDisplays               |   –   |
SDL_GetNumVideoDrivers                |   –   |
SDL_GetPerformanceCounter             |   –   |
SDL_GetPerformanceFrequency           |   –   |
SDL_GetPixelFormatName                |   –   |
SDL_GetPlatform                       |   –   |
SDL_GetPowerInfo                      |   –   |
SDL_GetPrefPath                       |   –   |
SDL_GetQueuedAudioSize                |   –   |
SDL_GetRGB                            |   –   |
SDL_GetRGBA                           |   –   |
SDL_GetRelativeMouseMode              |   –   |
SDL_GetRelativeMouseState             |   –   |
SDL_GetRenderDrawBlendMode            |   –   |
SDL_GetRenderDrawColor                |   –   |
SDL_GetRenderDriverInfo               |   –   |
SDL_GetRenderTarget                   |   ✓   |
SDL_GetRenderer                       |   –   |
SDL_GetRendererInfo                   |   –   |
SDL_GetRendererOutputSize             |   –   |
SDL_GetRevision                       |   –   |
SDL_GetRevisionNumber                 |   –   |
SDL_GetScancodeFromKey                |   –   |
SDL_GetScancodeFromName               |   –   |
SDL_GetScancodeName                   |   –   |
SDL_GetSurfaceAlphaMod                |   –   |
SDL_GetSurfaceBlendMode               |   –   |
SDL_GetSurfaceColorMod                |   –   |
SDL_GetSystemRAM                      |   ✓   |
SDL_GetTextureAlphaMod                |   –   |
SDL_GetTextureBlendMode               |   –   |
SDL_GetTextureColorMod                |   –   |
SDL_GetThreadID                       |   –   |
SDL_GetThreadName                     |   –   |
SDL_GetTicks                          |   ✓   |
SDL_GetTouchDevice                    |   –   |
SDL_GetTouchFinger                    |   –   |
SDL_GetVersion                        |   ✓   |
SDL_GetVideoDriver                    |   –   |
SDL_GetWindowBrightness               |   –   |
SDL_GetWindowData                     |   –   |
SDL_GetWindowDisplayIndex             |   –   |
SDL_GetWindowDisplayMode              |   –   |
SDL_GetWindowFlags                    |   –   |
SDL_GetWindowFromID                   |   –   |
SDL_GetWindowGammaRamp                |   –   |
SDL_GetWindowGrab                     |   –   |
SDL_GetWindowID                       |   –   |
SDL_GetWindowMaximumSize              |   –   |
SDL_GetWindowMinimumSize              |   –   |
SDL_GetWindowPixelFormat              |   –   |
SDL_GetWindowPosition                 |   –   |
SDL_GetWindowSize                     |   –   |
SDL_GetWindowSurface                  |   ✓   |
SDL_GetWindowTitle                    |   –   |
SDL_GetWindowWMInfo                   |   –   |
SDL_HapticClose                       |   –   |
SDL_HapticDestroyEffect               |   –   |
SDL_HapticEffectSupported             |   –   |
SDL_HapticGetEffectStatus             |   –   |
SDL_HapticIndex                       |   –   |
SDL_HapticName                        |   –   |
SDL_HapticNewEffect                   |   –   |
SDL_HapticNumAxes                     |   –   |
SDL_HapticNumEffects                  |   –   |
SDL_HapticNumEffectsPlaying           |   –   |
SDL_HapticOpen                        |   –   |
SDL_HapticOpenFromJoystick            |   –   |
SDL_HapticOpenFromMouse               |   –   |
SDL_HapticOpened                      |   –   |
SDL_HapticPause                       |   –   |
SDL_HapticQuery                       |   –   |
SDL_HapticRumbleInit                  |   –   |
SDL_HapticRumblePlay                  |   –   |
SDL_HapticRumbleStop                  |   –   |
SDL_HapticRumbleSupported             |   –   |
SDL_HapticRunEffect                   |   –   |
SDL_HapticSetAutocenter               |   –   |
SDL_HapticSetGain                     |   –   |
SDL_HapticStopAll                     |   –   |
SDL_HapticStopEffect                  |   –   |
SDL_HapticUnpause                     |   –   |
SDL_HapticUpdateEffect                |   –   |
SDL_Has3DNow                          |   ✓   |
SDL_HasAVX                            |   ✓   |
SDL_HasAVX2                           |   ✓   |
SDL_HasAltiVec                        |   ✓   |
SDL_HasClipboardText                  |   –   |
SDL_HasEvent                          |   –   |
SDL_HasEvents                         |   –   |
SDL_HasIntersection                   |   –   |
SDL_HasMMX                            |   ✓   |
SDL_HasRDTSC                          |   ✓   |
SDL_HasSSE                            |   ✓   |
SDL_HasSSE2                           |   ✓   |
SDL_HasSSE3                           |   ✓   |
SDL_HasSSE41                          |   ✓   |
SDL_HasSSE42                          |   ✓   |
SDL_HasScreenKeyboardSupport          |   –   |
SDL_HideWindow                        |   –   |
SDL_Init                              |   ✓   |
SDL_InitSubSystem                     |   –   |
SDL_IntersectRect                     |   –   |
SDL_IntersectRectAndLine              |   –   |
SDL_IsGameController                  |   –   |
SDL_IsScreenKeyboardShown             |   –   |
SDL_IsScreenSaverEnabled              |   –   |
SDL_IsTextInputActive                 |   –   |
SDL_JoystickClose                     |   –   |
SDL_JoystickEventState                |   –   |
SDL_JoystickFromInstanceID            |   –   |
SDL_JoystickGetAttached               |   –   |
SDL_JoystickGetAxis                   |   –   |
SDL_JoystickGetBall                   |   –   |
SDL_JoystickGetButton                 |   –   |
SDL_JoystickGetDeviceGUID             |   –   |
SDL_JoystickGetGUID                   |   –   |
SDL_JoystickGetGUIDFromString         |   –   |
SDL_JoystickGetGUIDString             |   –   |
SDL_JoystickGetHat                    |   –   |
SDL_JoystickInstanceID                |   –   |
SDL_JoystickIsHaptic                  |   –   |
SDL_JoystickName                      |   –   |
SDL_JoystickNameForIndex              |   –   |
SDL_JoystickNumAxes                   |   –   |
SDL_JoystickNumBalls                  |   –   |
SDL_JoystickNumButtons                |   –   |
SDL_JoystickNumHats                   |   –   |
SDL_JoystickOpen                      |   –   |
SDL_JoystickUpdate                    |   –   |
SDL_LoadBMP                           |   ✓   |
SDL_LoadBMP_RW                        |   ✓   |
SDL_LoadDollarTemplates               |   –   |
SDL_LoadFunction                      |   –   |
SDL_LoadObject                        |   –   |
SDL_LoadWAV                           |   –   |
SDL_LoadWAV_RW                        |   –   |
SDL_LockAudio                         |   –   |
SDL_LockAudioDevice                   |   –   |
SDL_LockMutex                         |   –   |
SDL_LockSurface                       |   –   |
SDL_LockTexture                       |   –   |
SDL_Log                               |   –   |
SDL_LogCritical                       |   –   |
SDL_LogDebug                          |   –   |
SDL_LogError                          |   –   |
SDL_LogGetOutputFunction              |   –   |
SDL_LogGetPriority                    |   –   |
SDL_LogInfo                           |   –   |
SDL_LogMessage                        |   –   |
SDL_LogMessageV                       |   –   |
SDL_LogResetPriorities                |   –   |
SDL_LogSetAllPriority                 |   –   |
SDL_LogSetOutputFunction              |   –   |
SDL_LogSetPriority                    |   –   |
SDL_LogVerbose                        |   –   |
SDL_LogWarn                           |   –   |
SDL_LowerBlit                         |   –   |
SDL_LowerBlitScaled                   |   –   |
SDL_MUSTLOCK                          |   –   |
SDL_MapRGB                            |   ✓   |
SDL_MapRGBA                           |   –   |
SDL_MasksToPixelFormatEnum            |   –   |
SDL_MaximizeWindow                    |   –   |
SDL_MinimizeWindow                    |   –   |
SDL_MixAudio                          |   –   |
SDL_MixAudioFormat                    |   –   |
SDL_MostSignificantBitIndex32         |   –   |
SDL_MouseIsHaptic                     |   –   |
SDL_NumHaptics                        |   –   |
SDL_NumJoysticks                      |   –   |
SDL_OpenAudio                         |   –   |
SDL_OpenAudioDevice                   |   –   |
SDL_PauseAudio                        |   –   |
SDL_PauseAudioDevice                  |   –   |
SDL_PeepEvents                        |   –   |
SDL_PixelFormatEnumToMasks            |   –   |
SDL_PointInRect                       |   –   |
SDL_PollEvent                         |   ✓   |
SDL_PumpEvents                        |   ✓   |
SDL_PushEvent                         |   –   |
SDL_QueryTexture                      |   –   |
SDL_QueueAudio                        |   –   |
SDL_Quit                              |   ✓   |
SDL_QuitRequested                     |   –   |
SDL_QuitSubSystem                     |   –   |
SDL_REVISION                          |   –   |
SDL_RWFromConstMem                    |   –   |
SDL_RWFromFP                          |   –   |
SDL_RWFromFile                        |   ✓   |
SDL_RWFromMem                         |   –   |
SDL_RWclose                           |   –   |
SDL_RWread                            |   –   |
SDL_RWseek                            |   –   |
SDL_RWsize                            |   –   |
SDL_RWtell                            |   –   |
SDL_RWwrite                           |   –   |
SDL_RaiseWindow                       |   –   |
SDL_ReadBE16                          |   –   |
SDL_ReadBE32                          |   –   |
SDL_ReadBE64                          |   –   |
SDL_ReadLE16                          |   –   |
SDL_ReadLE32                          |   –   |
SDL_ReadLE64                          |   –   |
SDL_ReadU8                            |   –   |
SDL_RecordGesture                     |   –   |
SDL_RectEmpty                         |   –   |
SDL_RectEquals                        |   –   |
SDL_RegisterEvents                    |   –   |
SDL_RemoveTimer                       |   –   |
SDL_RenderClear                       |   ✓   |
SDL_RenderCopy                        |   ✓   |
SDL_RenderCopyEx                      |   –   |
SDL_RenderDrawLine                    |   ✓   |
SDL_RenderDrawLines                   |   –   |
SDL_RenderDrawPoint                   |   ✓   |
SDL_RenderDrawPoints                  |   –   |
SDL_RenderDrawRect                    |   ✓   |
SDL_RenderDrawRects                   |   –   |
SDL_RenderFillRect                    |   ✓   |
SDL_RenderFillRects                   |   –   |
SDL_RenderGetClipRect                 |   –   |
SDL_RenderGetD3D9Device               |   –   |
SDL_RenderGetLogicalSize              |   –   |
SDL_RenderGetScale                    |   –   |
SDL_RenderGetViewport                 |   –   |
SDL_RenderIsClipEnabled               |   –   |
SDL_RenderPresent                     |   ✓   |
SDL_RenderReadPixels                  |   –   |
SDL_RenderSetClipRect                 |   –   |
SDL_RenderSetLogicalSize              |   –   |
SDL_RenderSetScale                    |   –   |
SDL_RenderSetViewport                 |   –   |
SDL_RenderTargetSupported             |   –   |
SDL_ResetAssertionReport              |   –   |
SDL_RestoreWindow                     |   –   |
SDL_SaveAllDollarTemplates            |   –   |
SDL_SaveBMP                           |   –   |
SDL_SaveBMP_RW                        |   –   |
SDL_SaveDollarTemplate                |   –   |
SDL_SemPost                           |   –   |
SDL_SemTryWait                        |   –   |
SDL_SemValue                          |   –   |
SDL_SemWait                           |   –   |
SDL_SemWaitTimeout                    |   –   |
SDL_SetAssertionHandler               |   –   |
SDL_SetClipRect                       |   –   |
SDL_SetClipboardText                  |   –   |
SDL_SetColorKey                       |   ✓   |
SDL_SetCursor                         |   –   |
SDL_SetError                          |   –   |
SDL_SetEventFilter                    |   –   |
SDL_SetHint                           |   ✓   |
SDL_SetHintWithPriority               |   –   |
SDL_SetMainReady                      |   –   |
SDL_SetModState                       |   –   |
SDL_SetPaletteColors                  |   –   |
SDL_SetPixelFormatPalette             |   –   |
SDL_SetRelativeMouseMode              |   –   |
SDL_SetRenderDrawBlendMode            |   ✓   |
SDL_SetRenderDrawColor                |   ✓   |
SDL_SetRenderTarget                   |   ✓   |
SDL_SetSurfaceAlphaMod                |   –   |
SDL_SetSurfaceBlendMode               |   –   |
SDL_SetSurfaceColorMod                |   –   |
SDL_SetSurfacePalette                 |   –   |
SDL_SetSurfaceRLE                     |   –   |
SDL_SetTextInputRect                  |   –   |
SDL_SetTextureAlphaMod                |   –   |
SDL_SetTextureBlendMode               |   –   |
SDL_SetTextureColorMod                |   ✓   |
SDL_SetThreadPriority                 |   –   |
SDL_SetWindowBordered                 |   –   |
SDL_SetWindowBrightness               |   –   |
SDL_SetWindowData                     |   –   |
SDL_SetWindowDisplayMode              |   –   |
SDL_SetWindowFullscreen               |   –   |
SDL_SetWindowGammaRamp                |   –   |
SDL_SetWindowGrab                     |   –   |
SDL_SetWindowHitTest                  |   –   |
SDL_SetWindowIcon                     |   –   |
SDL_SetWindowMaximumSize              |   –   |
SDL_SetWindowMinimumSize              |   –   |
SDL_SetWindowPosition                 |   –   |
SDL_SetWindowSize                     |   –   |
SDL_SetWindowTitle                    |   –   |
SDL_ShowCursor                        |   –   |
SDL_ShowMessageBox                    |   –   |
SDL_ShowSimpleMessageBox              |   –   |
SDL_ShowWindow                        |   –   |
SDL_StartTextInput                    |   –   |
SDL_StopTextInput                     |   –   |
SDL_Swap16                            |   –   |
SDL_Swap32                            |   –   |
SDL_Swap64                            |   –   |
SDL_SwapBE16                          |   –   |
SDL_SwapBE32                          |   –   |
SDL_SwapBE64                          |   –   |
SDL_SwapFloat                         |   –   |
SDL_SwapFloatBE                       |   –   |
SDL_SwapFloatLE                       |   –   |
SDL_SwapLE16                          |   –   |
SDL_SwapLE32                          |   –   |
SDL_SwapLE64                          |   –   |
SDL_TICKS_PASSED                      |   –   |
SDL_TLSCreate                         |   –   |
SDL_TLSGet                            |   –   |
SDL_TLSSet                            |   –   |
SDL_ThreadID                          |   –   |
SDL_TriggerBreakpoint                 |   –   |
SDL_TryLockMutex                      |   –   |
SDL_UnionRect                         |   –   |
SDL_UnloadObject                      |   –   |
SDL_UnlockAudio                       |   –   |
SDL_UnlockAudioDevice                 |   –   |
SDL_UnlockMutex                       |   –   |
SDL_UnlockSurface                     |   –   |
SDL_UnlockTexture                     |   –   |
SDL_UpdateTexture                     |   –   |
SDL_UpdateWindowSurface               |   ✓   |
SDL_UpdateWindowSurfaceRects          |   –   |
SDL_UpdateYUVTexture                  |   –   |
SDL_UpperBlit                         |   ✓   |
SDL_UpperBlitScaled                   |   ✓   |
SDL_VERSION                           |   –   |
SDL_VERSIONNUM                        |   –   |
SDL_VERSION_ATLEAST                   |   –   |
SDL_VideoInit                         |   –   |
SDL_VideoQuit                         |   –   |
SDL_WaitEvent                         |   ✓   |
SDL_WaitEventTimeout                  |   –   |
SDL_WaitThread                        |   –   |
SDL_WarpMouseGlobal                   |   –   |
SDL_WarpMouseInWindow                 |   –   |
SDL_WasInit                           |   –   |
SDL_WinRTGetFSPathUNICODE             |   –   |
SDL_WinRTGetFSPathUTF8                |   –   |
SDL_WinRTRunApp                       |   –   |
SDL_WriteBE16                         |   –   |
SDL_WriteBE32                         |   –   |
SDL_WriteBE64                         |   –   |
SDL_WriteLE16                         |   –   |
SDL_WriteLE32                         |   –   |
SDL_WriteLE64                         |   –   |
SDL_acos                              |   –   |
SDL_assert                            |   –   |
SDL_assert_paranoid                   |   –   |
SDL_assert_release                    |   –   |

### SDL_image

Name                                  | Bound |
--------------------------------------|-------|
IMG_GetError                          |   –   |
IMG_Init                              |   ✓   |
IMG_Linked_Version                    |   –   |
IMG_Load                              |   ✓   |
IMG_LoadBMP_RW                        |   –   |
IMG_LoadCUR_RW                        |   –   |
IMG_LoadGIF_RW                        |   –   |
IMG_LoadICO_RW                        |   –   |
IMG_LoadJPG_RW                        |   –   |
IMG_LoadLBM_RW                        |   –   |
IMG_LoadPCX_RW                        |   –   |
IMG_LoadPNG_RW                        |   –   |
IMG_LoadPNM_RW                        |   –   |
IMG_LoadTGA_RW                        |   –   |
IMG_LoadTIF_RW                        |   –   |
IMG_LoadTexture                       |   ✓   |
IMG_LoadTextureTyped_RW               |   –   |
IMG_LoadTexture_RW                    |   –   |
IMG_LoadTyped_RW                      |   –   |
IMG_LoadXCF_RW                        |   –   |
IMG_LoadXPM_RW                        |   –   |
IMG_LoadXV_RW                         |   –   |
IMG_Load_RW                           |   –   |
IMG_Quit                              |   ✓   |
IMG_ReadXPMFromArray                  |   –   |
IMG_SavePNG                           |   –   |
IMG_SavePNG_RW                        |   –   |
IMG_SetError                          |   –   |
IMG_isBMP                             |   –   |
IMG_isCUR                             |   –   |
IMG_isGIF                             |   –   |
IMG_isICO                             |   –   |
IMG_isJPG                             |   –   |
IMG_isLBM                             |   –   |
IMG_isPCX                             |   –   |
IMG_isPNG                             |   –   |
IMG_isPNM                             |   –   |
IMG_isTIF                             |   –   |
IMG_isXCF                             |   –   |
IMG_isXPM                             |   –   |
IMG_isXV                              |   –   |

### SDL_mixer

Name                                  | Bound |
--------------------------------------|-------|
Mix_AllocateChannels                  |   ✓   |
Mix_ChannelFinished                   |   –   |
Mix_CloseAudio                        |   ✓   |
Mix_ExpireChannel                     |   –   |
Mix_FadeInChannel                     |   –   |
Mix_FadeInChannelTimed                |   –   |
Mix_FadeInMusic                       |   –   |
Mix_FadeInMusicPos                    |   –   |
Mix_FadeOutChannel                    |   –   |
Mix_FadeOutGroup                      |   –   |
Mix_FadeOutMusic                      |   –   |
Mix_FadingChannel                     |   –   |
Mix_FadingMusic                       |   –   |
Mix_FreeChunk                         |   ✓   |
Mix_FreeMusic                         |   ✓   |
Mix_GetChunk                          |   –   |
Mix_GetChunkDecoder                   |   –   |
Mix_GetError                          |   –   |
Mix_GetMusicDecoder                   |   –   |
Mix_GetMusicHookData                  |   –   |
Mix_GetMusicType                      |   –   |
Mix_GetNumChunkDecoders               |   –   |
Mix_GetNumMusicDecoders               |   –   |
Mix_GroupAvailable                    |   –   |
Mix_GroupChannel                      |   –   |
Mix_GroupChannels                     |   –   |
Mix_GroupCount                        |   –   |
Mix_GroupNewer                        |   –   |
Mix_GroupOldest                       |   –   |
Mix_HaltChannel                       |   –   |
Mix_HaltGroup                         |   –   |
Mix_HaltMusic                         |   –   |
Mix_HookMusic                         |   –   |
Mix_HookMusicFinished                 |   –   |
Mix_Init                              |   –   |
Mix_Linked_Version                    |   –   |
Mix_LoadMUS                           |   ✓   |
Mix_LoadWAV                           |   ✓   |
Mix_LoadWAV_RW                        |   ✓   |
Mix_OpenAudio                         |   ✓   |
Mix_Pause                             |   –   |
Mix_PauseMusic                        |   –   |
Mix_Paused                            |   –   |
Mix_PausedMusic                       |   –   |
Mix_PlayChannel                       |   ✓   |
Mix_PlayChannelTimed                  |   ✓   |
Mix_PlayMusic                         |   ✓   |
Mix_Playing                           |   ✓   |
Mix_PlayingMusic                      |   ✓   |
Mix_QuerySpec                         |   –   |
Mix_QuickLoad_RAW                     |   –   |
Mix_QuickLoad_WAV                     |   –   |
Mix_Quit                              |   ✓   |
Mix_RegisterEffect                    |   –   |
Mix_ReserveChannels                   |   –   |
Mix_Resume                            |   –   |
Mix_ResumeMusic                       |   –   |
Mix_RewindMusic                       |   –   |
Mix_SetDistance                       |   –   |
Mix_SetError                          |   –   |
Mix_SetMusicCMD                       |   –   |
Mix_SetMusicPosition                  |   –   |
Mix_SetPanning                        |   –   |
Mix_SetPosition                       |   –   |
Mix_SetPostMix                        |   –   |
Mix_SetReverseStereo                  |   –   |
Mix_UnregisterAllEffects              |   –   |
Mix_UnregisterEffect                  |   –   |
Mix_Volume                            |   –   |
Mix_VolumeChunk                       |   ✓   |
Mix_VolumeMusic                       |   ✓   |

### SDL_ttf

Name                                  | Bound |
--------------------------------------|-------|
SDL_TTF_MAJOR_VERSION                 |   –   |
SDL_TTF_MINOR_VERSION                 |   –   |
SDL_TTF_PATCHLEVEL                    |   –   |
TTF_ByteSwappedUNICODE                |   –   |
TTF_CloseFont                         |   ✓   |
TTF_FontAscent                        |   –   |
TTF_FontDescent                       |   –   |
TTF_FontFaceFamilyName                |   –   |
TTF_FontFaceIsFixedWidth              |   –   |
TTF_FontFaceStyleName                 |   –   |
TTF_FontFaces                         |   –   |
TTF_FontHeight                        |   –   |
TTF_FontLineSkip                      |   –   |
TTF_GetError                          |   –   |
TTF_GetFontHinting                    |   –   |
TTF_GetFontKerning                    |   –   |
TTF_GetFontOutline                    |   –   |
TTF_GetFontStyle                      |   –   |
TTF_GlyphIsProvided                   |   –   |
TTF_GlyphMetrics                      |   –   |
TTF_Init                              |   ✓   |
TTF_Linked_Version                    |   –   |
TTF_OpenFont                          |   ✓   |
TTF_OpenFontIndex                     |   –   |
TTF_OpenFontIndexRW                   |   –   |
TTF_OpenFontRW                        |   –   |
TTF_Quit                              |   ✓   |
TTF_RenderGlyph_Blended               |   –   |
TTF_RenderGlyph_Shaded                |   –   |
TTF_RenderGlyph_Solid                 |   –   |
TTF_RenderText_Blended                |   –   |
TTF_RenderText_Shaded                 |   –   |
TTF_RenderText_Solid                  |   ✓   |
TTF_RenderUNICODE_Blended             |   –   |
TTF_RenderUNICODE_Shaded              |   –   |
TTF_RenderUNICODE_Solid               |   –   |
TTF_RenderUTF8_Blended                |   –   |
TTF_RenderUTF8_Shaded                 |   –   |
TTF_RenderUTF8_Solid                  |   –   |
TTF_SetError                          |   –   |
TTF_SetFontHinting                    |   –   |
TTF_SetFontKerning                    |   –   |
TTF_SetFontOutline                    |   –   |
TTF_SetFontStyle                      |   –   |
TTF_SizeText                          |   –   |
TTF_SizeUNICODE                       |   –   |
TTF_SizeUTF8                          |   –   |
TTF_WasInit                           |   –   |

## Licence
ISC
