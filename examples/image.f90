! image.f90
!
! Loads an image and displays it in the SDL 2 window.
! Example is taken from:
! http://lazyfoo.net/tutorials/SDL/02_getting_an_image_on_the_screen/index.php
!
! Author:   Philipp Engel
! Licence:  ISC
program main
    use, intrinsic :: iso_c_binding, only: c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer, parameter :: width  = 640
    integer, parameter :: height = 480

    type(c_ptr)        :: window
    type(sdl_surface)  :: surface
    type(sdl_surface)  :: image
    type(sdl_rect)     :: rect
    integer            :: rc

    rect%w = 640
    rect%h = 480
    rect%x = 0
    rect%y = 0

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
    image   = sdl_load_bmp('examples/chess.bmp' // c_null_char)

    ! Output to the window.
    rc = sdl_blit_surface(image, rect, surface, rect)
    rc = sdl_update_window_surface(window)

    call sdl_delay(3000)

    ! Quit gracefully.
    call sdl_free_surface(image)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
