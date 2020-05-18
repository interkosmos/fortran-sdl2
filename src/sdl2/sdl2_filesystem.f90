! sdl2_filesystem.f90
!
! Fortran 2008 interfaces to SDL_filesystem.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_filesystem
    use, intrinsic :: iso_c_binding, only: c_ptr
    implicit none

    public :: sdl_get_base_path_

    interface
        ! char *SDL_GetBasePath(void)
        function sdl_get_base_path_() bind(c, name='SDL_GetBasePath')
            import :: c_ptr
            type(c_ptr) :: sdl_get_base_path_
        end function sdl_get_base_path_
    end interface
end module sdl2_filesystem
