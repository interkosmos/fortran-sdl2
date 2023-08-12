! log.f90
!
! Shows how to use SDL logging functionality.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: compiler_version, stdout => output_unit, &
                                             stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 640
    integer, parameter :: SCREEN_HEIGHT = 240

    type(c_ptr) :: window

    ! Initialise SDL.
    if (sdl_init(ior(SDL_INIT_TIMER, SDL_INIT_VIDEO)) < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('Fortran SDL 2.0' // c_null_char, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SCREEN_WIDTH, &
                               SCREEN_HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    call sdl_log_set_all_priority(SDL_LOG_PRIORITY_VERBOSE);

    call sdl_log('generic log message')

    call sdl_log_verbose(SDL_LOG_CATEGORY_TEST, 'verbose message')
    call sdl_log_debug(SDL_LOG_CATEGORY_TEST, 'debug message')
    call sdl_log_info(SDL_LOG_CATEGORY_TEST, 'info message')
    call sdl_log_warn(SDL_LOG_CATEGORY_TEST, 'warning message')
    call sdl_log_error(SDL_LOG_CATEGORY_TEST, 'critical error')
    call sdl_log_critical(SDL_LOG_CATEGORY_TEST, 'critical error')

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
