! msgbox.f90
!
! Displays a simple message box.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: C_NULL_CHAR, c_null_ptr, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer,          parameter :: WIDTH     = 320
    integer,          parameter :: HEIGHT    = 240
    character(len=*), parameter :: MSG_TITLE = 'Hello, World!'
    character(len=*), parameter :: MSG_TEXT  = 'Welcome to wherever you are.'

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

    ! Show message box.
    rc = sdl_show_simple_message_box(SDL_MESSAGEBOX_INFORMATION, &
                                     MSG_TITLE // C_NULL_CHAR, &
                                     MSG_TEXT // C_NULL_CHAR, &
                                     c_null_ptr)

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

    surface => sdl_get_window_surface(window)
    rc = sdl_update_window_surface(window)

    do while (.not. done)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    done = .true.
            end select

            rc = sdl_update_window_surface(window)
        end if
    end do

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
