! window.f90
!
! Shows an SDL 2 window and fills a rectangle in it.
! Example is taken from:
! http://lazyfoo.net/tutorials/SDL/01_hello_SDL/index2.php
!
! Author:   Philipp Engel
! Licence:  ISC
program main
    use, intrinsic :: iso_c_binding, only: c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer, parameter     :: width  = 640
    integer, parameter     :: height = 480

    type(c_ptr)            :: window
    type(sdl_surface)      :: surface
    type(sdl_pixel_format) :: pixel_format
    type(sdl_rect)         :: rect
    integer                :: rc
    integer                :: color

    rect%x = 100
    rect%y = 100
    rect%w = 200
    rect%h = 100

    ! Initialise SDL.
    rc = sdl_init(sdl_init_video)

    if (rc < 0) then
        print *, 'SDL Error: ', sdl_get_error()
        call exit(1)
    end if

    ! Create the SDL window.
    window = sdl_create_window('SDL2 Fortran' // c_null_char, &
                               sdl_windowpos_undefined, &
                               sdl_windowpos_undefined, &
                               width, &
                               height, &
                               sdl_window_shown)

    if (.not. c_associated(window)) then
        print *, 'SDL Error: ', sdl_get_error()
        call exit(1)
    end if

    ! Get the window surface.
    surface = sdl_get_window_surface(window)
    pixel_format = sdl_get_pixel_format(surface)

    color = sdl_map_rgb(pixel_format, 15, 15, 15)

    ! Draw and update.
    rc = sdl_fill_rect(surface, rect, 16000)
    rc = sdl_update_window_surface(window)

    call sdl_delay(3000)

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
