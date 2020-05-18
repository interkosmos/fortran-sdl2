! sdl2_error.f90
!
! Fortran 2008 interfaces to SDL_error.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_error
    use, intrinsic :: iso_c_binding, only: c_int, c_ptr
    implicit none

    public :: sdl_get_error_

    interface
        ! const char *SDL_GetError(void)
        function sdl_get_error_() bind(c, name='SDL_GetError')
            import :: c_ptr
            type(c_ptr) :: sdl_get_error_
        end function sdl_get_error_
    end interface
end module sdl2_error
