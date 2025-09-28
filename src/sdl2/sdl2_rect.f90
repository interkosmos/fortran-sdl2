! sdl2_rect.f90
!
! Fortran 2008 interfaces to SDL_rect.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_rect
    use :: sdl2_c_types, only: c_float, c_int
    implicit none
    private

    ! SDL_FPoint
    type, bind(c), public :: sdl_fpoint
        real(kind=c_float) :: x = 0.0
        real(kind=c_float) :: y = 0.0
    end type sdl_fpoint

    ! SDL_Point
    type, bind(c), public :: sdl_point
        integer(kind=c_int) :: x = 0
        integer(kind=c_int) :: y = 0
    end type sdl_point

    ! SDL_Rect
    type, bind(c), public :: sdl_rect
        integer(kind=c_int) :: x = 0
        integer(kind=c_int) :: y = 0
        integer(kind=c_int) :: w = 0
        integer(kind=c_int) :: h = 0
    end type sdl_rect
end module sdl2_rect
