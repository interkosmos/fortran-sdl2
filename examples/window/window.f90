! window.f90
!
! Shows an SDL 2 window and fills two rectangles in it, using the
! software renderer.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: WIDTH  = 640
    integer, parameter :: HEIGHT = 480

    type(c_ptr)                     :: window
    type(sdl_surface),      pointer :: surface
    type(sdl_pixel_format), pointer :: pixel_format
    type(sdl_rect)                  :: rects(2)
    integer                         :: rc
    integer                         :: color

    rects(1)%x = 100
    rects(1)%y = 100
    rects(1)%w = 200
    rects(1)%h = 100

    rects(2)%x = 150
    rects(2)%y = 150
    rects(2)%w = 200
    rects(2)%h = 100

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
    surface      => sdl_get_window_surface(window)
    pixel_format => sdl_get_pixel_format(surface)

    ! Set color to red (#FF0000).
    color = sdl_map_rgb(pixel_format, 255, 0, 0)

    ! Draw and update.
    rc = sdl_fill_rects(surface, rects, 2, color)
    rc = sdl_update_window_surface(window)

    call sdl_delay(3000)

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
