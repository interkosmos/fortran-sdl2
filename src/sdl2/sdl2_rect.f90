! sdl2_rect.f90
!
! Fortran 2008 interfaces to SDL_rect.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_rect
    use sdl2_c_types, only: c_int, c_float
    implicit none
    private

    ! SDL_FPoint
    type, bind(c), public :: sdl_fpoint
        real(kind=c_float) :: x
        real(kind=c_float) :: y
    end type sdl_fpoint

    ! SDL_Point
    type, bind(c), public :: sdl_point
        integer(kind=c_int) :: x
        integer(kind=c_int) :: y
    end type sdl_point

    ! SDL_Rect
    type, bind(c), public :: sdl_rect
        integer(kind=c_int) :: x
        integer(kind=c_int) :: y
        integer(kind=c_int) :: w
        integer(kind=c_int) :: h
    end type sdl_rect
end module sdl2_rect
