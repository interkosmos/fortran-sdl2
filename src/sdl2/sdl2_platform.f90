! sdl2_platform.f90
!
! Fortran 2008 interface to SDL_platform.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f08sdl2/
! Licence: ISC
module sdl2_platform
    use, intrinsic :: iso_c_binding, only: c_ptr
    implicit none

    public :: sdl_get_platform_

    interface
        ! const char *SDL_GetPlatform(void)
        function sdl_get_platform_() bind(c, name='SDL_GetPlatform')
            import :: c_ptr
            type(c_ptr) :: sdl_get_platform_
        end function sdl_get_platform_
    end interface
end module sdl2_platform
