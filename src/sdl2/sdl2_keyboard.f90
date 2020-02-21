! sdl2_keyboard.f90
!
! Fortran 2008 interface to SDL_keyboard.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_keyboard
    use, intrinsic :: iso_c_binding, only: c_ptr
    implicit none

    public :: sdl_get_keyboard_state_

    interface
        ! const Uint8 *SDL_GetKeyboardState(int *numkeys)
        function sdl_get_keyboard_state_(numkeys) bind(c, name='SDL_GetKeyboardState')
            import :: c_ptr
            type(c_ptr), intent(in), value :: numkeys
            type(c_ptr)                    :: sdl_get_keyboard_state_
        end function sdl_get_keyboard_state_
    end interface
end module sdl2_keyboard
