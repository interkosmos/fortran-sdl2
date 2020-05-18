! sdl2_mouse.f90
!
! Fortran 2008 interfaces to SDL_mouse.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_mouse
    use, intrinsic :: iso_c_binding, only: c_int, c_ptr
    use :: c_util, only: c_uint32_t
    use :: sdl2_stdinc, only: sdl_bool
    implicit none

    integer(kind=c_int), parameter :: SDL_BUTTON_LEFT   = 1
    integer(kind=c_int), parameter :: SDL_BUTTON_MIDDLE = 2
    integer(kind=c_int), parameter :: SDL_BUTTON_RIGHT  = 3
    integer(kind=c_int), parameter :: SDL_BUTTON_X1     = 4
    integer(kind=c_int), parameter :: SDL_BUTTON_X2     = 5
    integer(kind=c_int), parameter :: SDL_BUTTON_LMASK  = ishft(1, SDL_BUTTON_LEFT - 1)
    integer(kind=c_int), parameter :: SDL_BUTTON_MMASK  = ishft(1, SDL_BUTTON_MIDDLE - 1)
    integer(kind=c_int), parameter :: SDL_BUTTON_RMASK  = ishft(1, SDL_BUTTON_RIGHT - 1)
    integer(kind=c_int), parameter :: SDL_BUTTON_X1MASK = ishft(1, SDL_BUTTON_X1 - 1)
    integer(kind=c_int), parameter :: SDL_BUTTON_X2MASK = ishft(1, SDL_BUTTON_X2 - 1)

    public :: sdl_get_mouse_state
    public :: sdl_set_relative_mouse_mode
    public :: sdl_show_cursor
    public :: sdl_warp_mouse_global
    public :: sdl_warp_mouse_in_window

    interface
        ! Uint32 SDL_GetMouseState(int *x, int *y)
        function sdl_get_mouse_state(x, y) bind(c, name='SDL_GetMouseState')
            import :: c_int, c_uint32_t
            integer(kind=c_int), intent(in) :: x
            integer(kind=c_int), intent(in) :: y
            integer(kind=c_uint32_t)        :: sdl_get_mouse_state
        end function sdl_get_mouse_state

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
