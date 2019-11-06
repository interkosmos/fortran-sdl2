! sdl2_rect.f90
!
! Fortran 2008 interface to SDL_rect.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f08sdl2/
! Licence: ISC
module sdl2_rect
    use, intrinsic :: iso_c_binding
    implicit none

    ! SDL_Point
    type, bind(c) :: sdl_point
        integer(kind=c_int) :: x
        integer(kind=c_int) :: y
    end type sdl_point

    ! SDL_Rect
    type, bind(c) :: sdl_rect
        integer(kind=c_int) :: x
        integer(kind=c_int) :: y
        integer(kind=c_int) :: w
        integer(kind=c_int) :: h
    end type sdl_rect
end module sdl2_rect
