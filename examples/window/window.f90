! window.f90
!
! Shows an SDL 2 window and fills two rectangles in it, using the
! software renderer.
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

    type(c_ptr)                     :: window
    type(sdl_surface),      pointer :: surface
    type(sdl_pixel_format), pointer :: pixel_format
    type(sdl_rect)                  :: rects(2)
    integer                         :: rc
    integer                         :: color

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

    ! Get the window surface.
    surface      => sdl_get_window_surface(window)
    pixel_format => sdl_get_pixel_format(surface)

    ! Set color to red (#FF0000).
    color = sdl_map_rgb(pixel_format, 255, 0, 0)

    ! Draw and update.
    rects(1) = sdl_rect(100, 100, 200, 100)
    rects(2) = sdl_rect(150, 150, 200, 100)

    rc = sdl_fill_rects(surface, rects, 2, color)
    rc = sdl_update_window_surface(window)

    call sdl_delay(3000)

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
