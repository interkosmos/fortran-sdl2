! sdl2_stdinc.f90
!
! Fortran 2008 interfaces to SDL_stdinc.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_stdinc
    use :: sdl2_c_types, only: c_int, c_ptr, c_size_t
    implicit none
    private

    ! Type alias for SDL_bool.
    integer, parameter, public :: sdl_bool = c_int

    integer(kind=c_int), parameter, public :: SDL_FALSE = 0
    integer(kind=c_int), parameter, public :: SDL_TRUE  = 1

    public :: sdl_free
    public :: c_strlen

    ! Foreign function interfaces to libc.
    interface
        ! void free(void *ptr);
        subroutine sdl_free(ptr) bind(c, name='free')
            import :: c_ptr
            type(c_ptr), value, intent(in) :: ptr
        end subroutine sdl_free
    end interface

    interface
        function c_strlen(str) bind(c, name='strlen')
            import :: c_ptr, c_size_t
            type(c_ptr), intent(in), value :: str
            integer(kind=c_size_t)         :: c_strlen
        end function c_strlen
    end interface
end module sdl2_stdinc
