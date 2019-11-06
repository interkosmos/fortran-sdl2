! sdl2_rwops.f90
!
! Fortran 2008 interface to SDL_rwops.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f08sdl2/
! Licence: ISC
module sdl2_rwops
    use, intrinsic :: iso_c_binding, only: c_char, c_ptr
    implicit none

    public :: sdl_rw_from_file

    interface
        ! SDL_RWops *SDL_RWFromFile(const char *file, const char *mode)
        function sdl_rw_from_file(file, mode) bind(c, name='SDL_RWFromFile')
            import :: c_char, c_ptr
            character(kind=c_char), intent(in) :: file
            character(kind=c_char), intent(in) :: mode
            type(c_ptr)                        :: sdl_rw_from_file
        end function sdl_rw_from_file
    end interface
end module sdl2_rwops
