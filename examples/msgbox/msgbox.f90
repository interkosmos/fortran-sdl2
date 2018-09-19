! msgbox.f90
!
! Displays a simple message box.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_null_ptr, c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer,          parameter :: WIDTH  = 320
    integer,          parameter :: HEIGHT = 240
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
        print *, 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Show message box.
    rc = sdl_show_simple_message_box(SDL_MESSAGEBOX_INFORMATION, &
                                     MSG_TITLE // c_null_char, &
                                     MSG_TEXT // c_null_char, &
                                     window)

    ! Create the SDL window.
    window = sdl_create_window('SDL2 Fortran' // c_null_char, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               WIDTH, &
                               HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        print *, 'SDL Error: ', sdl_get_error()
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
