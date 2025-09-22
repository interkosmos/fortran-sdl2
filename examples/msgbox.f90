! msgbox.f90
!
! Displays a simple message box.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer,      parameter :: SCREEN_WIDTH  = 320
    integer,      parameter :: SCREEN_HEIGHT = 240
    character(*), parameter :: MSG_TITLE     = 'Hello, World!'
    character(*), parameter :: MSG_TEXT      = 'Welcome to wherever you are.'

    type(c_ptr)                :: window
    type(sdl_surface), pointer :: surface
    type(sdl_event)            :: event
    integer                    :: rc
    logical                    :: done

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Show message box.
    rc = sdl_show_simple_message_box(SDL_MESSAGEBOX_INFORMATION, &
                                     MSG_TITLE // c_null_char, &
                                     MSG_TEXT // c_null_char, &
                                     c_null_ptr)

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

    surface => sdl_get_window_surface(window)
    rc = sdl_update_window_surface(window)
    done = .false.

    do while (.not. done)
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT); done = .true.
            end select

            rc = sdl_update_window_surface(window)
        end if
    end do

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
