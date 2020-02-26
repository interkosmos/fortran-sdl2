! image.f90
!
! Loads an image and displays it in the SDL 2 window.
!
! Example is taken from:
! http://lazyfoo.net/tutorials/SDL/02_getting_an_image_on_the_screen/index.php
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 640
    integer, parameter :: SCREEN_HEIGHT = 480

    type(c_ptr)                :: window
    type(sdl_surface), pointer :: screen
    type(sdl_surface), pointer :: image
    type(sdl_rect)             :: rect
    integer                    :: rc

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
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

    screen => sdl_get_window_surface(window)
    image  => sdl_load_bmp('chess.bmp' // c_null_char)

    rect = sdl_rect(0, 0, image%w, image%h)

    ! Output to the window.
    rc = sdl_blit_surface(image, rect, screen, rect)
    rc = sdl_update_window_surface(window)
    call sdl_delay(3000)

    ! Quit gracefully.
    call sdl_free_surface(image)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
