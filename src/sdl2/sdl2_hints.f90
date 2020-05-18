! sdl2_hints.f90
!
! Fortran 2008 interfaces to SDL_hints.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_hints
    use, intrinsic :: iso_c_binding, only: c_char, c_ptr
    use :: sdl2_stdinc, only: sdl_bool
    implicit none

    character(kind=c_char, len=*), parameter :: SDL_HINT_FRAMEBUFFER_ACCELERATION       = 'SDL_FRAMEBUFFER_ACCELERATION'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RENDER_DRIVER                  = 'SDL_RENDER_DRIVER'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RENDER_OPENGL_SHADERS          = 'SDL_RENDER_OPENGL_SHADERS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RENDER_DIRECT3D_THREADSAFE     = 'SDL_RENDER_DIRECT3D_THREADSAFE'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RENDER_DIRECT3D11_DEBUG        = 'SDL_RENDER_DIRECT3D11_DEBUG'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RENDER_LOGICAL_SIZE_MODE       = 'SDL_RENDER_LOGICAL_SIZE_MODE'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RENDER_SCALE_QUALITY           = 'SDL_RENDER_SCALE_QUALITY'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RENDER_VSYNC                   = 'SDL_RENDER_VSYNC'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_ALLOW_SCREENSAVER        = 'SDL_VIDEO_ALLOW_SCREENSAVER'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_X11_XVIDMODE             = 'SDL_VIDEO_X11_XVIDMODE'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_X11_XINERAMA             = 'SDL_VIDEO_X11_XINERAMA'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_X11_XRANDR               = 'SDL_VIDEO_X11_XRANDR'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_X11_NET_WM_PING          = 'SDL_VIDEO_X11_NET_WM_PING'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN = &
        'SDL_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINDOWS_INTRESOURCE_ICON       = 'SDL_WINDOWS_INTRESOURCE_ICON'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINDOWS_INTRESOURCE_ICON_SMALL = 'SDL_WINDOWS_INTRESOURCE_ICON_SMALL'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINDOWS_ENABLE_MESSAGELOOP     = 'SDL_WINDOWS_ENABLE_MESSAGELOOP'
    character(kind=c_char, len=*), parameter :: SDL_HINT_GRAB_KEYBOARD                  = 'SDL_GRAB_KEYBOARD'
    character(kind=c_char, len=*), parameter :: SDL_HINT_MOUSE_NORMAL_SPEED_SCALE       = 'SDL_MOUSE_NORMAL_SPEED_SCALE'
    character(kind=c_char, len=*), parameter :: SDL_HINT_MOUSE_RELATIVE_SPEED_SCALE     = 'SDL_MOUSE_RELATIVE_SPEED_SCALE'
    character(kind=c_char, len=*), parameter :: SDL_HINT_MOUSE_RELATIVE_MODE_WARP       = 'SDL_MOUSE_RELATIVE_MODE_WARP'
    character(kind=c_char, len=*), parameter :: SDL_HINT_MOUSE_FOCUS_CLICKTHROUGH       = 'SDL_MOUSE_FOCUS_CLICKTHROUGH'
    character(kind=c_char, len=*), parameter :: SDL_HINT_TOUCH_MOUSE_EVENTS             = 'SDL_TOUCH_MOUSE_EVENTS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS   = 'SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_IDLE_TIMER_DISABLED            = 'SDL_IOS_IDLE_TIMER_DISABLED'
    character(kind=c_char, len=*), parameter :: SDL_HINT_ORIENTATIONS                   = 'SDL_IOS_ORIENTATIONS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_APPLE_TV_CONTROLLER_UI_EVENTS  = 'SDL_APPLE_TV_CONTROLLER_UI_EVENTS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_APPLE_TV_REMOTE_ALLOW_ROTATION = 'SDL_APPLE_TV_REMOTE_ALLOW_ROTATION'
    character(kind=c_char, len=*), parameter :: SDL_HINT_ACCELEROMETER_AS_JOYSTICK      = 'SDL_ACCELEROMETER_AS_JOYSTICK'
    character(kind=c_char, len=*), parameter :: SDL_HINT_XINPUT_ENABLED                 = 'SDL_XINPUT_ENABLED'
    character(kind=c_char, len=*), parameter :: SDL_HINT_XINPUT_USE_OLD_JOYSTICK_MAPPING = &
        'SDL_XINPUT_USE_OLD_JOYSTICK_MAPPING'
    character(kind=c_char, len=*), parameter :: SDL_HINT_GAMECONTROLLERCONFIG           = 'SDL_GAMECONTROLLERCONFIG'
    character(kind=c_char, len=*), parameter :: SDL_HINT_GAMECONTROLLER_IGNORE_DEVICES  = 'SDL_GAMECONTROLLER_IGNORE_DEVICES'
    character(kind=c_char, len=*), parameter :: SDL_HINT_GAMECONTROLLER_IGNORE_DEVICES_EXCEPT = &
        'SDL_GAMECONTROLLER_IGNORE_DEVICES_EXCEPT'
    character(kind=c_char, len=*), parameter :: SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS = &
        'SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_ALLOW_TOPMOST                  = 'SDL_ALLOW_TOPMOST'
    character(kind=c_char, len=*), parameter :: SDL_HINT_TIMER_RESOLUTION               = 'SDL_TIMER_RESOLUTION'
    character(kind=c_char, len=*), parameter :: SDL_HINT_QTWAYLAND_CONTENT_ORIENTATION  = 'SDL_QTWAYLAND_CONTENT_ORIENTATION'
    character(kind=c_char, len=*), parameter :: SDL_HINT_QTWAYLAND_WINDOW_FLAGS         = 'SDL_QTWAYLAND_WINDOW_FLAGS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_THREAD_STACK_SIZE              = 'SDL_THREAD_STACK_SIZE'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_HIGHDPI_DISABLED         = 'SDL_VIDEO_HIGHDPI_DISABLED'
    character(kind=c_char, len=*), parameter :: SDL_HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK = &
        'SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_WIN_D3DCOMPILER          = 'SDL_VIDEO_WIN_D3DCOMPILER'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT = &
        'SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINRT_PRIVACY_POLICY_URL       = 'SDL_WINRT_PRIVACY_POLICY_URL'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINRT_PRIVACY_POLICY_LABEL     = 'SDL_WINRT_PRIVACY_POLICY_LABEL'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINRT_HANDLE_BACK_BUTTON       = 'SDL_WINRT_HANDLE_BACK_BUTTON'
    character(kind=c_char, len=*), parameter :: SDL_HINT_VIDEO_MAC_FULLSCREEN_SPACES    = 'SDL_VIDEO_MAC_FULLSCREEN_SPACES'
    character(kind=c_char, len=*), parameter :: SDL_HINT_MAC_BACKGROUND_APP             = 'SDL_MAC_BACKGROUND_APP'
    character(kind=c_char, len=*), parameter :: SDL_HINT_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION = &
        'SDL_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION'
    character(kind=c_char, len=*), parameter :: SDL_HINT_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION = &
        'SDL_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION'
    character(kind=c_char, len=*), parameter :: SDL_HINT_IME_INTERNAL_EDITING           = 'SDL_IME_INTERNAL_EDITING'
    character(kind=c_char, len=*), parameter :: SDL_HINT_ANDROID_SEPARATE_MOUSE_AND_TOUCH = &
        'SDL_ANDROID_SEPARATE_MOUSE_AND_TOUCH'
    character(kind=c_char, len=*), parameter :: SDL_HINT_EMSCRIPTEN_KEYBOARD_ELEMENT    = 'SDL_EMSCRIPTEN_KEYBOARD_ELEMENT'
    character(kind=c_char, len=*), parameter :: SDL_HINT_NO_SIGNAL_HANDLERS             = 'SDL_NO_SIGNAL_HANDLERS'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4     = 'SDL_WINDOWS_NO_CLOSE_ON_ALT_F4'
    character(kind=c_char, len=*), parameter :: SDL_HINT_BMP_SAVE_LEGACY_FORMAT         = 'SDL_BMP_SAVE_LEGACY_FORMAT'
    character(kind=c_char, len=*), parameter :: SDL_HINT_WINDOWS_DISABLE_THREAD_NAMING  = 'SDL_WINDOWS_DISABLE_THREAD_NAMING'
    character(kind=c_char, len=*), parameter :: SDL_HINT_RPI_VIDEO_LAYER                = 'SDL_RPI_VIDEO_LAYER'
    character(kind=c_char, len=*), parameter :: SDL_HINT_OPENGL_ES_DRIVER               = 'SDL_OPENGL_ES_DRIVER'
    character(kind=c_char, len=*), parameter :: SDL_HINT_AUDIO_RESAMPLING_MODE          = 'SDL_AUDIO_RESAMPLING_MODE'
    character(kind=c_char, len=*), parameter :: SDL_HINT_AUDIO_CATEGORY                 = 'SDL_AUDIO_CATEGORY'

    ! SDL_HintPriority
    enum, bind(c)
        enumerator :: SDL_HINT_DEFAULT
        enumerator :: SDL_HINT_NORMAL
        enumerator :: SDL_HINT_OVERRIDE
    end enum

    public :: sdl_get_hint_
    public :: sdl_set_hint_

    interface
        ! const char *SDL_GetHint(const char *name)
        function sdl_get_hint_(name) bind(c, name='SDL_GetHint')
            import :: c_char, c_ptr
            character(kind=c_char), intent(in) :: name
            type(c_ptr)                        :: sdl_get_hint_
        end function sdl_get_hint_

        ! SDL_bool SDL_SetHint(const char *name, const char *value)
        function sdl_set_hint_(name, value) bind(c, name='SDL_SetHint')
            import :: c_char, sdl_bool
            character(kind=c_char), intent(in) :: name
            character(kind=c_char), intent(in) :: value
            integer(kind=sdl_bool)             :: sdl_set_hint_
        end function sdl_set_hint_
    end interface
end module sdl2_hints
