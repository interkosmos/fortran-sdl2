! sdl2_joystick.f90
!
! Fortran 2008 interfaces to SDL_joystick.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_joystick
    use, intrinsic :: iso_c_binding, only: c_int
    implicit none
    private

    public :: sdl_num_joysticks

    interface
        ! int SDL_NumJoysticks()
        function sdl_num_joysticks() bind(c, name='SDL_NumJoysticks')
            import :: c_int
            integer(kind=c_int) :: sdl_num_joysticks
        end function sdl_num_joysticks
    end interface
end module sdl2_joystick
