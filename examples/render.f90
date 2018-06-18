! render.f90
!
! Loads a PNG file with SDL2_image and paints it to screen
! using the hardware renderer.
!
! Author:   Philipp Engel
! Licence:  ISC
program main
    use, intrinsic :: iso_c_binding, only: c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    use :: sdl2_image
    implicit none

    integer,          parameter :: width     = 320
    integer,          parameter :: height    = 240
    character(len=*), parameter :: file_name = 'examples/fortran.png'

    type(c_ptr)     :: window
    type(c_ptr)     :: renderer
    type(c_ptr)     :: texture
    type(sdl_rect)  :: rect
    type(sdl_event) :: event
    integer         :: rc

    ! Initialise SDL and SDL2_image.
    rc = sdl_init(sdl_init_video)
    rc = img_init(img_init_png)

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

    ! Create renderer and load PNG image.
    renderer = sdl_create_renderer(window, -1, 0)
    texture  = img_load_texture(renderer, file_name // c_null_char)

    rect%w = 304
    rect%h = 31
    rect%x = 0
    rect%y = 0

    do while (.true.)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (sdl_quit_type)
                    exit
            end select

            rc = sdl_render_clear(renderer)
            rc = sdl_render_copy(renderer, texture, rect, rect)
            call sdl_render_present(renderer)
        end if

        call sdl_delay(100)
    end do

    ! Quit gracefully.
    call sdl_destroy_texture(texture)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)

    call img_quit()
    call sdl_quit()
end program main
