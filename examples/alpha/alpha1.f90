! alpha1.f90
!
! Makes one color of an image transparent.
! using an embedded image
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC

! generate the object file to be embedded using the following
! objcopy --input binary --output elf64-x86-64 --binary-architecture i386 --redefine-sym _binary_fortran_bmp_start=img_start --redefine-sym _binary_fortran_bmp_end=img_end --redefine-sym _binary_fortran_bmp_size=img_size fortran.bmp fortran.o
! the size of this file is 61610, hard coded below
module data
use iso_c_binding
implicit none
! character(kind=c_char), target, bind(c) :: img_start
! character(61610), pointer :: bmp
character(kind=c_char), target, bind(c) :: img_start
character(61610), pointer :: bmp
end module data

program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr, c_f_pointer, c_loc
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: data
    implicit none

    integer,          parameter :: WIDTH     = 640
    integer,          parameter :: HEIGHT    = 240
    ! character(len=*), parameter :: FILE_NAME = 'fortran.bmp'

    type(c_ptr)                     :: window
    type(sdl_surface),      pointer :: window_surface
    type(sdl_surface),      pointer :: image_loaded
    type(sdl_surface),      pointer :: image_optimised
    type(sdl_pixel_format), pointer :: pixel_format
    type(sdl_rect)                  :: window_rect
    type(sdl_rect)                  :: image_rect
    type(sdl_event)                 :: event
    integer                         :: color
    integer                         :: rc
    logical                         :: done = .false.
    type(c_ptr)                     :: ptr

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('Fortran SDL 2.0' // c_null_char, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               WIDTH, &
                               HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    window_surface  => sdl_get_window_surface(window)                     ! Get surface of window.

    !
    call c_f_pointer(c_loc(img_start), bmp)
    ptr = sdl_load_bmp_rw(sdl_rw_from_const_mem(bmp, 61610), 1) ! Load embedded BMP.
    call c_f_pointer(ptr, image_loaded)

    pixel_format    => sdl_get_pixel_format(window_surface)               ! Get pixel format of window.
    image_optimised => sdl_convert_surface(image_loaded, pixel_format, 0) ! Optimise pixel format of image.
    color           = sdl_map_rgb(pixel_format, 255, 0, 255)              ! Get translucent color (#FF00FF).
    rc              = sdl_set_color_key(image_optimised, 1, color)        ! Set translucent color.

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
                case (SDL_QUITEVENT)
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
