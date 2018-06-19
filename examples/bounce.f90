! bounce.f90
!
! Loads a PNG file with SDL2_image and lets it bounce on the screen
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

    integer,          parameter :: width     = 640
    integer,          parameter :: height    = 480
    character(len=*), parameter :: file_name = 'examples/fortran.png'

    type(c_ptr)             :: window
    type(c_ptr)             :: renderer
    type(c_ptr)             :: texture
    type(sdl_rect)          :: src_rect
    type(sdl_rect)          :: dst_rect
    type(sdl_event)         :: event
    integer(kind=c_int32_t) :: texture_format
    integer(kind=c_int)     :: texture_access
    integer                 :: texture_width
    integer                 :: texture_height
    integer                 :: dx = 1
    integer                 :: dy = 1
    integer                 :: rc

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

    rc = sdl_query_texture(texture, &
                           texture_format, &
                           texture_access, &
                           texture_width, &
                           texture_height)

    src_rect%w = texture_width
    src_rect%h = texture_height
    src_rect%x = 0
    src_rect%y = 0

    dst_rect = src_rect

    do while (.true.)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (sdl_quit_type)
                    exit
            end select
        end if

        if (dst_rect%x < 0) then
            dst_rect%x = 0
            dx = 1
        elseif (dst_rect%x + texture_width > width) then
            dst_rect%x = width - texture_width
            dx = -1
        endif

       if (dst_rect%y < 0) then
            dst_rect%y = 0
            dy = 1
        elseif (dst_rect%y + texture_height > height) then
            dst_rect%y = height - texture_height
            dy = -1
        endif

        dst_rect%x = dst_rect%x + dx
        dst_rect%y = dst_rect%y + dy

        rc = sdl_render_clear(renderer)
        rc = sdl_render_copy(renderer, texture, src_rect, dst_rect)
        call sdl_render_present(renderer)

        call sdl_delay(20)
    end do

    ! Quit gracefully.
    call sdl_destroy_texture(texture)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)

    call img_quit()
    call sdl_quit()
end program main
