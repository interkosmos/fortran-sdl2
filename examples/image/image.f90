! image.f90
!
! Loads an image and displays it in the SDL 2 window.
! Example is taken from:
! http://lazyfoo.net/tutorials/SDL/02_getting_an_image_on_the_screen/index.php
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: WIDTH  = 640
    integer, parameter :: HEIGHT = 480

    type(c_ptr)                :: window
    type(sdl_surface), pointer :: screen
    type(sdl_surface), pointer :: image
    type(sdl_rect)             :: rect
    integer                    :: rc

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('SDL2 Fortran' // c_null_char, &
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
    screen => sdl_get_window_surface(window)

    ! Load the image.
    image  => sdl_load_bmp('examples/image/chess.bmp' // c_null_char)

    rect%w = image%w
    rect%h = image%h
    rect%x = 0
    rect%y = 0

    ! Output to the window.
    rc = sdl_blit_surface(image, rect, screen, rect)
    rc = sdl_update_window_surface(window)

    call sdl_delay(3000)

    ! Quit gracefully.
    call sdl_free_surface(image)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
