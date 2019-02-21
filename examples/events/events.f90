! events.f90
!
! Runs an event loop and quits if SDL_QUIT event is received.
! Example is taken from:
! http://lazyfoo.net/tutorials/SDL/03_event_driven_programming/index.php
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: C_NULL_CHAR, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer, parameter :: WIDTH  = 640
    integer, parameter :: HEIGHT = 480

    type(c_ptr)                :: window
    type(sdl_surface), pointer :: surface
    type(sdl_event)            :: event
    integer                    :: rc
    logical                    :: done = .false.

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('SDL2 Fortran' // C_NULL_CHAR, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               WIDTH, &
                               HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Get the window surface.
    surface => sdl_get_window_surface(window)
    rc = sdl_update_window_surface(window)

    do while (.not. done)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    done = .true.
                case (SDL_KEYDOWN)
                    print *, 'key down event'
                case (SDL_MOUSEMOTION)
                    print *, 'mouse motion event'
                case (SDL_WINDOWEVENT)
                    print *, 'window event'
                case (SDL_MOUSEBUTTONDOWN)
                    print *, 'mouse button down event'

                    if (event%button%button == SDL_BUTTON_LEFT ) &
                        print *, 'left mouse button clicked'
            end select
        end if
    end do

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
