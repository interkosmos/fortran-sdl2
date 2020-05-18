! sdl2_version.f90
!
! Fortran 2008 interfaces to SDL_version.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_version
    use, intrinsic :: iso_c_binding
    use :: c_util, only: c_uint8_t
    implicit none

    ! SDL_version
    type, bind(c) :: sdl_version
        integer(kind=c_uint8_t) :: major
        integer(kind=c_uint8_t) :: minor
        integer(kind=c_uint8_t) :: patch
    end type sdl_version

    public :: sdl_get_version

    interface
        ! void SDL_GetVersion(SDL_version *ver)
        subroutine sdl_get_version(ver) bind(c, name='SDL_GetVersion')
            import :: sdl_version
            type(sdl_version), intent(inout) :: ver
        end subroutine sdl_get_version
    end interface
end module sdl2_version
