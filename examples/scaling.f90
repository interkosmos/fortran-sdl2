! scaling.f90
!
! Loads an image and scales it before drawing it on the window.
! Example is taken from:
! http://lazyfoo.net/tutorials/SDL/05_optimized_surface_loading_and_soft_stretching/index.php
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer,          parameter :: SCREEN_WIDTH  = 640
    integer,          parameter :: SCREEN_HEIGHT = 480
    character(len=*), parameter :: FILE_NAME     = 'share/wall.bmp'

    type(c_ptr)                     :: window
    type(sdl_surface),      pointer :: window_surface
    type(sdl_surface),      pointer :: image_loaded
    type(sdl_surface),      pointer :: image_optimised
    type(sdl_pixel_format), pointer :: pixel_format
    type(sdl_rect)                  :: window_rect
    type(sdl_rect)                  :: image_rect
    type(sdl_event)                 :: event
    integer                         :: rc
    logical                         :: done = .false.

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

    window_surface  => sdl_get_window_surface(window)
    image_loaded    => sdl_load_bmp(FILE_NAME // c_null_char)
    pixel_format    => sdl_get_pixel_format(window_surface)
    image_optimised => sdl_convert_surface(image_loaded, pixel_format, 0)

    image_rect  = sdl_rect(0, 0, image_optimised%w, image_optimised%h)
    window_rect = sdl_rect(0, 0, 256, 256)

    do while (.not. done)
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
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
