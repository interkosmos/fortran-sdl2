! sdl2_video.f90
!
! Fortran 2008 interface to SDL_video.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f08sdl2/
! Licence: ISC
module sdl2_video
    use, intrinsic :: iso_c_binding
    use :: c_util, only: c_uint32_t
    use :: sdl2_surface, only: sdl_surface
    use :: sdl2_stdinc, only: sdl_bool
    implicit none

    integer(kind=c_int), parameter :: SDL_WINDOWPOS_UNDEFINED_MASK = int(z'1FFF0000')
    integer(kind=c_int), parameter :: SDL_WINDOWPOS_UNDEFINED      = ior(SDL_WINDOWPOS_UNDEFINED_MASK, 0)

    integer(kind=c_int), parameter :: SDL_INIT_TIMER          = int(z'00000001')
    integer(kind=c_int), parameter :: SDL_INIT_AUDIO          = int(z'00000010')
    integer(kind=c_int), parameter :: SDL_INIT_VIDEO          = int(z'00000020')
    integer(kind=c_int), parameter :: SDL_INIT_JOYSTICK       = int(z'00000200')
    integer(kind=c_int), parameter :: SDL_INIT_HAPTIC         = int(z'00001000')
    integer(kind=c_int), parameter :: SDL_INIT_GAMECONTROLLER = int(z'00002000')
    integer(kind=c_int), parameter :: SDL_INIT_EVENTS         = int(z'00004000')
    integer(kind=c_int), parameter :: SDL_INIT_NOPARACHUTE    = int(z'00010000')
    integer(kind=c_int), parameter :: SDL_INIT_EVERYTHING     = ior(SDL_INIT_TIMER, &
                                                                    ior(SDL_INIT_VIDEO, &
                                                                    ior(SDL_INIT_VIDEO, &
                                                                    ior(SDL_INIT_JOYSTICK, &
                                                                    ior(SDL_INIT_HAPTIC, &
                                                                    ior(SDL_INIT_GAMECONTROLLER, &
                                                                    ior(SDL_INIT_EVENTS, SDL_INIT_NOPARACHUTE)))))))

    integer(kind=c_int), parameter :: SDL_WINDOW_FULLSCREEN         = int(z'00000001')
    integer(kind=c_int), parameter :: SDL_WINDOW_OPENGL             = int(z'00000002')
    integer(kind=c_int), parameter :: SDL_WINDOW_SHOWN              = int(z'00000004')
    integer(kind=c_int), parameter :: SDL_WINDOW_HIDDEN             = int(z'00000008')
    integer(kind=c_int), parameter :: SDL_WINDOW_BORDERLESS         = int(z'00000010')
    integer(kind=c_int), parameter :: SDL_WINDOW_RESIZABLE          = int(z'00000020')
    integer(kind=c_int), parameter :: SDL_WINDOW_MINIMIZED          = int(z'00000040')
    integer(kind=c_int), parameter :: SDL_WINDOW_MAXIMIZED          = int(z'00000080')
    integer(kind=c_int), parameter :: SDL_WINDOW_INPUT_GRABBED      = int(z'00000100')
    integer(kind=c_int), parameter :: SDL_WINDOW_INPUT_FOCUS        = int(z'00000200')
    integer(kind=c_int), parameter :: SDL_WINDOW_MOUSE_FOCUS        = int(z'00000400')
    integer(kind=c_int), parameter :: SDL_WINDOW_FULLSCREEN_DESKTOP = ior(SDL_WINDOW_FULLSCREEN, &
                                                                          int(z'00001000'))
    integer(kind=c_int), parameter :: SDL_WINDOW_FOREIGN            = int(z'00000800')
    integer(kind=c_int), parameter :: SDL_WINDOW_ALLOW_HIGHDPI      = int(z'00002000')
    integer(kind=c_int), parameter :: SDL_WINDOW_MOUSE_CAPTURE      = int(z'00004000')
    integer(kind=c_int), parameter :: SDL_WINDOW_ALWAYS_ON_TOP      = int(z'00008000')
    integer(kind=c_int), parameter :: SDL_WINDOW_SKIP_TASKBAR       = int(z'00010000')
    integer(kind=c_int), parameter :: SDL_WINDOW_UTILITY            = int(z'00020000')
    integer(kind=c_int), parameter :: SDL_WINDOW_TOOLTIP            = int(z'00040000')
    integer(kind=c_int), parameter :: SDL_WINDOW_POPUP_MENU         = int(z'00080000')
    integer(kind=c_int), parameter :: SDL_WINDOW_VULKAN             = int(z'10000000')

    ! SDL_WindowEventID
    enum, bind(c)
        enumerator :: SDL_WINDOWEVENT_NONE
        enumerator :: SDL_WINDOWEVENT_SHOWN
        enumerator :: SDL_WINDOWEVENT_HIDDEN
        enumerator :: SDL_WINDOWEVENT_EXPOSED
        enumerator :: SDL_WINDOWEVENT_MOVED
        enumerator :: SDL_WINDOWEVENT_RESIZED
        enumerator :: SDL_WINDOWEVENT_SIZE_CHANGED
        enumerator :: SDL_WINDOWEVENT_MINIMIZED
        enumerator :: SDL_WINDOWEVENT_MAXIMIZED
        enumerator :: SDL_WINDOWEVENT_RESTORED
        enumerator :: SDL_WINDOWEVENT_ENTER
        enumerator :: SDL_WINDOWEVENT_LEAVE
        enumerator :: SDL_WINDOWEVENT_FOCUS_GAINED
        enumerator :: SDL_WINDOWEVENT_FOCUS_LOST
        enumerator :: SDL_WINDOWEVENT_CLOSE
        enumerator :: SDL_WINDOWEVENT_TAKE_FOCUS
        enumerator :: SDL_WINDOWEVENT_HIT_TEST
    end enum

    public :: sdl_create_window
    public :: sdl_destroy_window
    public :: sdl_get_current_video_driver_
    public :: sdl_get_video_driver_
    public :: sdl_get_window_id
    public :: sdl_get_window_maximum_size
    public :: sdl_get_window_minimum_size
    public :: sdl_get_window_pixel_format
    public :: sdl_get_window_position
    public :: sdl_get_window_size
    public :: sdl_get_window_surface_
    public :: sdl_get_window_title_
    public :: sdl_hide_window
    public :: sdl_maximize_window
    public :: sdl_minimize_window
    public :: sdl_raise_window
    public :: sdl_restore_window
    public :: sdl_set_window_bordered
    public :: sdl_set_window_fullscreen
    public :: sdl_set_window_icon
    public :: sdl_set_window_maximum_size
    public :: sdl_set_window_minimum_size
    public :: sdl_set_window_position
    public :: sdl_set_window_resizable
    public :: sdl_set_window_size
    public :: sdl_set_window_title
    public :: sdl_show_window
    public :: sdl_update_window_surface

    interface
        ! SDL_Window *SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags)
        function sdl_create_window(title, x, y, w, h, flags) bind(c, name='SDL_CreateWindow')
            import :: c_char, c_int, c_uint32_t, c_ptr
            character(kind=c_char),   intent(in)        :: title
            integer(kind=c_int),      intent(in), value :: x
            integer(kind=c_int),      intent(in), value :: y
            integer(kind=c_int),      intent(in), value :: w
            integer(kind=c_int),      intent(in), value :: h
            integer(kind=c_uint32_t), intent(in), value :: flags
            type(c_ptr)                                 :: sdl_create_window
        end function sdl_create_window

        ! const char *SDL_GetCurrentVideoDriver(void)
        function sdl_get_current_video_driver_() bind(c, name='SDL_GetCurrentVideoDriver')
            import :: c_ptr
            type(c_ptr) :: sdl_get_current_video_driver_
        end function sdl_get_current_video_driver_

        ! const char *SDL_GetVideoDriver(int index)
        function sdl_get_video_driver_(index) bind(c, name='SDL_GetVideoDriver')
            import :: c_int, c_ptr
            integer(kind=c_int), intent(in) :: index
            type(c_ptr)                     :: sdl_get_video_driver_
        end function sdl_get_video_driver_

        ! Uint32 SDL_GetWindowID(SDL_Window *window)
        function sdl_get_window_id(window) bind(c, name='SDL_GetWindowID')
            import :: c_ptr, c_uint32_t
            type(c_ptr), intent(in), value :: window
            integer(kind=c_uint32_t)       :: sdl_get_window_id
        end function sdl_get_window_id

        ! Uint32 SDL_GetWindowPixelFormat(SDL_Window* window)
        function sdl_get_window_pixel_format(window) bind(c, name='SDL_GetWindowPixelFormat')
            import :: c_ptr, c_uint32_t
            type(c_ptr), intent(in), value :: window
            integer(kind=c_uint32_t)       :: sdl_get_window_pixel_format
        end function sdl_get_window_pixel_format

        ! SDL_Surface *SDL_GetWindowSurface(SDL_Window *window)
        function sdl_get_window_surface_(window) bind(c, name='SDL_GetWindowSurface')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
            type(c_ptr)                    :: sdl_get_window_surface_
        end function sdl_get_window_surface_

        ! const char *SDL_GetWindowTitle(SDL_Window *window)
        function sdl_get_window_title_(window) bind(c, name='SDL_GetWindowTitle')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
            type(c_ptr)                    :: sdl_get_window_title_
        end function sdl_get_window_title_

        ! int SDL_SetWindowFullscreen(SDL_Window *window, Uint32 flags)
        function sdl_set_window_fullscreen(window, flags) bind(c, name='SDL_SetWindowFullscreen')
            import :: c_int, c_ptr, c_uint32_t
            type(c_ptr),              intent(in), value :: window
            integer(kind=c_uint32_t), intent(in), value :: flags
            integer(kind=c_int)                         :: sdl_set_window_fullscreen
        end function sdl_set_window_fullscreen

        ! int SDL_UpdateWindowSurface(SDL_Window *window)
        function sdl_update_window_surface(window) bind(c, name='SDL_UpdateWindowSurface')
            import :: c_int, c_ptr
            type(c_ptr), intent(in), value :: window
            integer(kind=c_int)            :: sdl_update_window_surface
        end function sdl_update_window_surface

        ! void SDL_DestroyWindow(SDL_Window *window)
        subroutine sdl_destroy_window(window) bind(c, name='SDL_DestroyWindow')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_destroy_window

        ! void SDL_GetWindowMaximumSize(SDL_Window *window, int *w, int *h)
        subroutine sdl_get_window_maximum_size(window, w, h) bind(c, name='SDL_GetWindowMaximumSize')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(inout)     :: w
            integer(kind=c_int), intent(inout)     :: h
        end subroutine sdl_get_window_maximum_size

        ! void SDL_GetWindowMinimumSize(SDL_Window *window, int *w, int *h)
        subroutine sdl_get_window_minimum_size(window, w, h) bind(c, name='SDL_GetWindowMinimumSize')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(inout)     :: w
            integer(kind=c_int), intent(inout)     :: h
        end subroutine sdl_get_window_minimum_size

        ! void SDL_GetWindowPosition(SDL_Window *window, int *x, int *y)
        subroutine sdl_get_window_position(window, x, y) bind(c, name='SDL_GetWindowPosition')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(inout)     :: x
            integer(kind=c_int), intent(inout)     :: y
        end subroutine sdl_get_window_position

        ! void SDL_GetWindowSize(SDL_Window *window, int *w, int *h)
        subroutine sdl_get_window_size(window, w, h) bind(c, name='SDL_GetWindowSize')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(inout)     :: w
            integer(kind=c_int), intent(inout)     :: h
        end subroutine sdl_get_window_size

        ! void SDL_HideWindow(SDL_Window *window)
        subroutine sdl_hide_window(window) bind(c, name='SDL_HideWindow')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_hide_window

        ! void SDL_MaximizeWindow(SDL_Window *window)
        subroutine sdl_maximize_window(window) bind(c, name='SDL_MaximizeWindow')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_maximize_window

        ! void SDL_MinimizeWindow(SDL_Window *window)
        subroutine sdl_minimize_window(window) bind(c, name='SDL_MinimizeWindow')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_minimize_window

        ! void SDL_RaiseWindow(SDL_Window *window)
        subroutine sdl_raise_window(window) bind(c, name='SDL_RaiseWindow')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_raise_window

        ! void SDL_RestoreWindow(SDL_Window *window)
        subroutine sdl_restore_window(window) bind(c, name='SDL_RestoreWindow')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_restore_window

        ! void SDL_SetWindowBordered(SDL_Window *window, SDL_bool bordered)
        subroutine sdl_set_window_bordered(window, bordered) bind(c, name='SDL_SetWindowBordered')
            import :: c_ptr, sdl_bool
            type(c_ptr),            intent(in), value :: window
            integer(kind=sdl_bool), intent(in), value :: bordered
        end subroutine sdl_set_window_bordered

        ! void SDL_SetWindowIcon(SDL_Window *window, SDL_Surface *icon)
        subroutine sdl_set_window_icon(window, icon) bind(c, name='SDL_SetWindowIcon')
            import :: c_ptr, sdl_surface
            type(c_ptr),       intent(in), value :: window
            type(sdl_surface), intent(in)        :: icon
        end subroutine sdl_set_window_icon

        ! void SDL_SetWindowMaximumSize(SDL_Window *window, int max_w, int max_h)
        subroutine sdl_set_window_maximum_size(window, max_w, max_h) bind(c, name='SDL_SetWindowMaximumSize')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(in), value :: max_w
            integer(kind=c_int), intent(in), value :: max_h
        end subroutine sdl_set_window_maximum_size

        ! void SDL_SetWindowMinimumSize(SDL_Window *window, int min_w, int min_h)
        subroutine sdl_set_window_minimum_size(window, min_w, min_h) bind(c, name='SDL_SetWindowMinimumSize')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(in), value :: min_w
            integer(kind=c_int), intent(in), value :: min_h
        end subroutine sdl_set_window_minimum_size

        ! void SDL_SetWindowPosition(SDL_Window *window, int x, int y)
        subroutine sdl_set_window_position(window, x, y) bind(c, name='SDL_SetWindowPosition')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(in), value :: x
            integer(kind=c_int), intent(in), value :: y
        end subroutine sdl_set_window_position

        ! void SDL_SetWindowResizable(SDL_Window *window, SDL_bool resizable)
        subroutine sdl_set_window_resizable(window, resizable) bind(c, name='SDL_SetWindowResizable')
            import :: c_ptr, sdl_bool
            type(c_ptr),            intent(in), value :: window
            integer(kind=sdl_bool), intent(in), value :: resizable
        end subroutine sdl_set_window_resizable

        ! void SDL_SetWindowSize(SDL_Window *window, int w, int h)
        subroutine sdl_set_window_size(window, x, y) bind(c, name='SDL_SetWindowSize')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(in), value :: x
            integer(kind=c_int), intent(in), value :: y
        end subroutine sdl_set_window_size

        ! void SDL_SetWindowTitle(SDL_Window *window, const char *title)
        subroutine sdl_set_window_title(window, title) bind(c, name='SDL_SetWindowTitle')
            import :: c_char, c_ptr
            type(c_ptr),            intent(in), value :: window
            character(kind=c_char), intent(in)        :: title
        end subroutine sdl_set_window_title

        ! void SDL_ShowWindow(SDL_Window *window)
        subroutine sdl_show_window(window) bind(c, name='SDL_ShowWindow')
            import :: c_ptr
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_show_window
    end interface
end module sdl2_video
