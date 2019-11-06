! sdl2_messagebox.f90
!
! Fortran 2008 interface to SDL_messagebox.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f08sdl2/
! Licence: ISC
module sdl2_messagebox
    use, intrinsic :: iso_c_binding, only: c_char, c_int, c_ptr
    use :: c_util, only: c_uint32_t
    implicit none

    ! SDL_MessageBoxFlags
    integer(kind=c_int), parameter :: SDL_MESSAGEBOX_ERROR       = int(z'00000010')
    integer(kind=c_int), parameter :: SDL_MESSAGEBOX_WARNING     = int(z'00000020')
    integer(kind=c_int), parameter :: SDL_MESSAGEBOX_INFORMATION = int(z'00000040')

    public :: sdl_show_simple_message_box

    interface
        ! int SDL_ShowSimpleMessageBox(Uint32 flags, const char *title, const char *message, SDL_Window *window)
        function sdl_show_simple_message_box(flags, title, message, window) bind(c, name='SDL_ShowSimpleMessageBox')
            import :: c_char, c_int, c_ptr, c_uint32_t
            integer(kind=c_uint32_t), intent(in), value :: flags
            character(kind=c_char),   intent(in)        :: title
            character(kind=c_char),   intent(in)        :: message
            type(c_ptr),              intent(in), value :: window
            integer(kind=c_int)                         :: sdl_show_simple_message_box
        end function sdl_show_simple_message_box
    end interface
end module sdl2_messagebox
