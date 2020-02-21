! sdl2_stdinc.f90
!
! Fortran 2008 interface to SDL_stdinc.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_stdinc
    use, intrinsic :: iso_c_binding, only: c_bool, c_int, c_ptr
    implicit none

    ! Type alias for SDL_bool.
    integer, parameter :: sdl_bool = c_int

    integer(kind=c_int), parameter :: SDL_FALSE = 0
    integer(kind=c_int), parameter :: SDL_TRUE  = 1

    public :: sdl_free

    interface
        ! void free(void *ptr);
        subroutine sdl_free(ptr) bind(c, name='free')
            import :: c_ptr
            type(c_ptr), value, intent(in) :: ptr
        end subroutine sdl_free
    end interface
end module sdl2_stdinc
