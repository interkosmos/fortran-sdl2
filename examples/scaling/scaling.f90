! scaling.f90
!
! Loads an image and scales it before drawing it on the window.
! Example is taken from:
! http://lazyfoo.net/tutorials/SDL/05_optimized_surface_loading_and_soft_stretching/index.php
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

    integer,          parameter :: WIDTH     = 640
    integer,          parameter :: HEIGHT    = 480
    character(len=*), parameter :: FILE_NAME = 'examples/scaling/wall.bmp'

    type(c_ptr)            :: window
    type(sdl_surface)      :: window_surface
    type(sdl_surface)      :: image_loaded
    type(sdl_surface)      :: image_optimised
    type(sdl_pixel_format) :: pixel_format
    type(sdl_rect)         :: window_rect
    type(sdl_rect)         :: image_rect
    type(sdl_event)        :: event
    integer                :: rc
    logical                :: done = .false.

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

    window_surface  = sdl_get_window_surface(window)
    image_loaded    = sdl_load_bmp(FILE_NAME // c_null_char)
    pixel_format    = sdl_get_pixel_format(window_surface)
    image_optimised = sdl_convert_surface(image_loaded, pixel_format, 0)

    image_rect%w    = image_optimised%w
    image_rect%h    = image_optimised%h
    image_rect%x    = 0
    image_rect%y    = 0

    window_rect%w   = 256
    window_rect%h   = 256
    window_rect%x   = 0
    window_rect%y   = 0

    do while (.not. done)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (sdl_quit_type)
                    done = .true.
            end select
        end if

        rc = sdl_blit_scaled(image_optimised, image_rect, window_surface, window_rect)
        rc = sdl_update_window_surface(window)
    end do

    ! Quit gracefully.
    call sdl_free_surface(image_optimised)
    call sdl_free_surface(image_loaded)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
