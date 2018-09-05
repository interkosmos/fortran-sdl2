! translucence.f90
!
! Makes one color of an image translucent.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    implicit none

    integer,          parameter :: WIDTH     = 640
    integer,          parameter :: HEIGHT    = 240
    character(len=*), parameter :: FILE_NAME = 'examples/translucence/fortran.bmp'

    type(c_ptr)            :: window
    type(sdl_surface)      :: window_surface
    type(sdl_surface)      :: image_loaded
    type(sdl_surface)      :: image_optimised
    type(sdl_pixel_format) :: pixel_format
    type(sdl_rect)         :: window_rect
    type(sdl_rect)         :: image_rect
    type(sdl_event)        :: event
    integer                :: color
    integer                :: rc
    logical                :: done = .false.

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        print *, 'SDL Error: ', sdl_get_error()
        call exit(1)
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
        call exit(1)
    end if

    window_surface  = sdl_get_window_surface(window)                                    ! Get surface of window.
    image_loaded    = sdl_load_bmp(FILE_NAME // c_null_char)                            ! Load BMP file.
    pixel_format    = sdl_get_pixel_format(window_surface)                              ! Get pixel format of window.
    image_optimised = sdl_convert_surface(image_loaded, pixel_format, 0)                ! Optimise pixel format of image.
    color           = sdl_map_rgb(pixel_format, int(255, 2), int(0, 2), int(255, 2))    ! Get translucent colour (#FF00FF).
    rc              = sdl_set_color_key(image_optimised, 1, color)                      ! Set translucent colour.

    window_rect%w = WIDTH
    window_rect%h = HEIGHT
    window_rect%x = 25
    window_rect%y = 25

    image_rect%w = image_optimised%w
    image_rect%h = image_optimised%h
    image_rect%x = 0
    image_rect%y = 0

    do while (.not. done)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (sdl_quit_type)
                    done = .true.
            end select
        end if

        ! Draw the image and update the window surface.
        rc = sdl_blit_surface(image_optimised, image_rect, window_surface, window_rect)
        rc = sdl_update_window_surface(window)
    end do

    ! Quit gracefully.
    call sdl_free_surface(image_optimised)
    call sdl_free_surface(image_loaded)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main