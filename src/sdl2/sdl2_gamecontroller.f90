! sdl2_joystick.f90
!
! Fortran 2008 interfaces to SDL_gamecontroller.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_gamecontroller
    use sdl2_c_types, only: c_ptr, c_int
    use :: sdl2_stdinc, only: sdl_bool
    implicit none
    private

    public :: sdl_game_controller_close
    public :: sdl_game_controller_open
    public :: sdl_is_game_controller

    interface
        ! SDL_*SDL_GameControllerOpen(int joystick_index)
        function sdl_game_controller_open(joystick_index) bind(c, name='SDL_GameControllerOpen')
            import :: c_int, c_ptr
            integer(kind=c_int), intent(in), value :: joystick_index
            type(c_ptr)                            :: sdl_game_controller_open
        end function sdl_game_controller_open

        ! SDL_bool SDL_IsGameController(int joystick_index)
        function sdl_is_game_controller(joystick_index) bind(c, name='SDL_IsGameController')
            import :: c_int, sdl_bool
            integer(kind=c_int), intent(in), value :: joystick_index
            integer(kind=sdl_bool)                 :: sdl_is_game_controller
        end function sdl_is_game_controller

        ! void SDL_GameControllerClose(SDL_GameController *gamecontroller)
        subroutine sdl_game_controller_close(game_controller) bind(c, name='SDL_GameControllerClose')
            import :: c_ptr
            type(c_ptr), intent(in), value :: game_controller
        end subroutine sdl_game_controller_close
    end interface
end module sdl2_gamecontroller
