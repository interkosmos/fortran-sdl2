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
    use, intrinsic :: iso_c_binding, only: c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer, parameter :: WIDTH  = 640
    integer, parameter :: HEIGHT = 480

    type(c_ptr)        :: window
    type(sdl_surface)  :: surface
    type(sdl_event)    :: event
    integer            :: rc

    logical            :: done   = .false.

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        print *, 'SDL Error: ', sdl_get_error()
        call exit(1)
    end if

    ! Create the SDL window.
    window = sdl_create_window('SDL2 Fortran' // c_null_char, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               WIDTH, &
                               HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        print *, 'SDL Error: ', sdl_get_error()
        call exit(1)
    end if

    ! Get the window surface.
    surface = sdl_get_window_surface(window)
    rc      = sdl_update_window_surface(window)

    do while (.not. done)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (sdl_quit_type)
                    done = .true.
                case (sdl_key_down)
                    print *, 'key down event'
                case (sdl_mouse_motion)
                    print *, 'mouse motion event'
                case (sdl_window)
                    print *, 'window event'
            end select
        end if
    end do

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
