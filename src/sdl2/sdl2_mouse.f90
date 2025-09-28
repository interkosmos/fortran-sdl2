! sdl2_mouse.f90
!
! Fortran 2008 interfaces to SDL_mouse.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_mouse
    use :: sdl2_c_types, only: c_int, c_ptr, c_uint32_t
    use :: sdl2_stdinc,  only: sdl_bool
    implicit none
    private

    integer(kind=c_int), parameter, public :: SDL_BUTTON_LEFT   = 1
    integer(kind=c_int), parameter, public :: SDL_BUTTON_MIDDLE = 2
    integer(kind=c_int), parameter, public :: SDL_BUTTON_RIGHT  = 3
    integer(kind=c_int), parameter, public :: SDL_BUTTON_X1     = 4
    integer(kind=c_int), parameter, public :: SDL_BUTTON_X2     = 5
    integer(kind=c_int), parameter, public :: SDL_BUTTON_LMASK  = ishft(1, SDL_BUTTON_LEFT - 1)
    integer(kind=c_int), parameter, public :: SDL_BUTTON_MMASK  = ishft(1, SDL_BUTTON_MIDDLE - 1)
    integer(kind=c_int), parameter, public :: SDL_BUTTON_RMASK  = ishft(1, SDL_BUTTON_RIGHT - 1)
    integer(kind=c_int), parameter, public :: SDL_BUTTON_X1MASK = ishft(1, SDL_BUTTON_X1 - 1)
    integer(kind=c_int), parameter, public :: SDL_BUTTON_X2MASK = ishft(1, SDL_BUTTON_X2 - 1)

    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_ARROW     = 0  ! Arrow.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_IBEAM     = 1  ! I-beam.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_WAIT      = 2  ! Wait.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_CROSSHAIR = 3  ! Crosshair.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_WAITARROW = 4  ! Small wait cursor (or Wait if not available).
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_SIZENWSE  = 5  ! Double arrow pointing northwest and southeast.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_SIZENESW  = 6  ! Double arrow pointing northeast and southwest.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_SIZEWE    = 7  ! Double arrow pointing west and east.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_SIZENS    = 8  ! Double arrow pointing north and south.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_SIZEALL   = 9  ! Four pointed arrow pointing north, south, east, and west.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_NO        = 10 ! Slashed circle or crossbones.
    integer(kind=c_int), parameter, public :: SDL_SYSTEM_CURSOR_HAND      = 11 ! Hand.
    integer(kind=c_int), parameter, public :: SDL_NUM_SYSTEM_CURSORS      = 12

    public :: sdl_create_system_cursor
    public :: sdl_free_cursor
    public :: sdl_get_default_cursor
    public :: sdl_get_global_mouse_state
    public :: sdl_get_mouse_state
    public :: sdl_get_relative_mouse_state
    public :: sdl_set_cursor
    public :: sdl_set_relative_mouse_mode
    public :: sdl_show_cursor
    public :: sdl_warp_mouse_global
    public :: sdl_warp_mouse_in_window

    interface
        ! SDL_Cursor *SDL_CreateSystemCursor(SDL_SystemCursor id)
        function sdl_create_system_cursor(id) bind(c, name='SDL_CreateSystemCursor')
            import :: c_ptr, c_int
            integer(kind=c_int), intent(in), value :: id
            type(c_ptr)                            :: sdl_create_system_cursor
        end function sdl_create_system_cursor

        ! SDL_Cursor *SDL_GetDefaultCursor(void)
        function sdl_get_default_cursor() bind(c, name='SDL_GetDefaultCursor')
            import :: c_ptr
            type(c_ptr) :: sdl_get_default_cursor
        end function sdl_get_default_cursor

        ! Uint32 SDLCALL SDL_GetGlobalMouseState(int *x, int *y)
        function sdl_get_global_mouse_state(x, y) bind(c, name='SDL_GetGlobalMouseState')
            import :: c_int, c_uint32_t
            integer(kind=c_int), intent(in) :: x
            integer(kind=c_int), intent(in) :: y
            integer(kind=c_uint32_t)        :: sdl_get_global_mouse_state
        end function sdl_get_global_mouse_state

        ! Uint32 SDL_GetMouseState(int *x, int *y)
        function sdl_get_mouse_state(x, y) bind(c, name='SDL_GetMouseState')
            import :: c_int, c_uint32_t
            integer(kind=c_int), intent(in) :: x
            integer(kind=c_int), intent(in) :: y
            integer(kind=c_uint32_t)        :: sdl_get_mouse_state
        end function sdl_get_mouse_state

        ! Uint32 SDLCALL SDL_GetRelativeMouseState(int *x, int *y)
        function sdl_get_relative_mouse_state(x, y) bind(c, name='SDL_GetRelativeMouseState')
            import :: c_int, c_uint32_t
            integer(kind=c_int), intent(in) :: x
            integer(kind=c_int), intent(in) :: y
            integer(kind=c_uint32_t)        :: sdl_get_relative_mouse_state
        end function sdl_get_relative_mouse_state

        ! int SDL_SetRelativeMouseMode(SDL_bool enabled)
        function sdl_set_relative_mouse_mode(enabled) bind(c, name='SDL_SetRelativeMouseMode')
            import :: c_int, sdl_bool
            integer(kind=c_int), intent(in), value :: enabled
            integer(kind=sdl_bool)                 :: sdl_set_relative_mouse_mode
        end function sdl_set_relative_mouse_mode

        ! int SDL_ShowCursor(int toggle)
        function sdl_show_cursor(toggle) bind(c, name='SDL_ShowCursor')
            import :: c_int
            integer(kind=c_int), intent(in), value :: toggle
            integer(kind=c_int)                    :: sdl_show_cursor
        end function sdl_show_cursor

        ! void SDL_FreeCursor(SDL_Cursor *cursor)
        subroutine sdl_free_cursor(cursor) bind(c, name='SDL_FreeCursor')
            import :: c_ptr
            type(c_ptr), intent(in), value :: cursor
        end subroutine sdl_free_cursor

        ! void SDL_SetCursor(SDL_Cursor *cursor)
        subroutine sdl_set_cursor(cursor) bind(c, name='SDL_SetCursor')
            import :: c_ptr
            type(c_ptr), intent(in), value :: cursor
        end subroutine sdl_set_cursor

        ! void SDL_WarpMouseInWindow(SDL_Window *window, int x, int y)
        subroutine sdl_warp_mouse_in_window(window, x, y) bind(c, name='SDL_WarpMouseInWindow')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: window
            integer(kind=c_int), intent(in), value :: x
            integer(kind=c_int), intent(in), value :: y
        end subroutine sdl_warp_mouse_in_window

        ! void SDL_WarpMouseGlobal(int x, int y)
        subroutine sdl_warp_mouse_global(x, y) bind(c, name='SDL_WarpMouseGlobal')
            import :: c_int
            integer(kind=c_int), intent(in), value :: x
            integer(kind=c_int), intent(in), value :: y
        end subroutine sdl_warp_mouse_global
    end interface
end module sdl2_mouse
