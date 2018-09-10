! window.f90
!
! Shows an SDL 2 window and fills a rectangle in it, using the
! software renderer. Example is taken from:
! http://lazyfoo.net/tutorials/SDL/01_hello_SDL/index2.php
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer, parameter :: WIDTH  = 640
    integer, parameter :: HEIGHT = 480

    type(c_ptr)                     :: window
    type(sdl_surface),      pointer :: surface
    type(sdl_pixel_format), pointer :: pixel_format
    type(sdl_rect)                  :: rect
    integer                         :: rc
    integer                         :: color

    rect%x = 100
    rect%y = 100
    rect%w = 200
    rect%h = 100

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        print *, 'SDL Error: ', sdl_get_error()
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
        print *, 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Get the window surface.
    surface      => sdl_get_window_surface(window)
    pixel_format => sdl_get_pixel_format(surface)

    ! Set color to red (#FF0000).
    color = sdl_map_rgb(pixel_format, int(255, 2), int(0, 2), int(0, 2))

    ! Draw and update.
    rc = sdl_fill_rect(surface, rect, color)
    rc = sdl_update_window_surface(window)

    call sdl_delay(3000)

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
