! dvd.f90
!
! Loads a PNG file with SDL2_image and lets it bounce on the screen
! using the hardware renderer.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_int, c_int32_t, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: sdl2_image
    implicit none

    type :: color
        integer(kind=2) :: r
        integer(kind=2) :: g
        integer(kind=2) :: b
    end type color

    character(len=*), parameter :: FILE_NAME = 'examples/dvd/logo.png'

    type(c_ptr)              :: window
    type(c_ptr)              :: renderer
    type(c_ptr)              :: texture
    type(color)              :: colors(5)
    type(sdl_rect)           :: src_rect
    type(sdl_rect)           :: dst_rect
    type(sdl_event)          :: event
    integer(kind=1), pointer :: keys(:) => null()
    integer(kind=c_int32_t)  :: texture_format
    integer(kind=c_int)      :: texture_access
    integer                  :: texture_width
    integer                  :: texture_height
    integer                  :: dx = 1
    integer                  :: dy = 1
    integer                  :: rc
    integer                  :: screen_height
    integer                  :: screen_width

    call random_seed()

    ! Fill colour table.
    colors(1)%r = 255; colors(1)%g = 0;   colors(1)%b = 0
    colors(2)%r = 255; colors(2)%g = 0;   colors(2)%b = 255
    colors(3)%r = 255; colors(3)%g = 255; colors(3)%b = 0
    colors(4)%r = 0;   colors(4)%g = 0;   colors(4)%b = 255
    colors(5)%r = 0;   colors(5)%g = 255; colors(5)%b = 255

    ! Initialise SDL and SDL2_image.
    rc = sdl_init(SDL_INIT_VIDEO)
    rc = img_init(IMG_INIT_PNG)

    if (rc < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('SDL2 Fortran' // c_null_char, &
                               0, 0, &
                               800, 600, &
                               ior(SDL_WINDOW_BORDERLESS, &
                                   ior(SDL_WINDOW_FULLSCREEN_DESKTOP, &
                                       ior(SDL_WINDOW_OPENGL, SDL_WINDOW_SHOWN))))

    if (.not. c_associated(window)) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Get real window size.
    call sdl_get_window_size(window, screen_width, screen_height)

    ! Create renderer and load PNG image.
    renderer = sdl_create_renderer(window, -1, 0)
    texture  = img_load_texture(renderer, FILE_NAME // c_null_char)

    ! Get the texture size.
    rc = sdl_query_texture(texture, &
                           texture_format, &
                           texture_access, &
                           texture_width, &
                           texture_height)

    ! Set source and destination rects.
    src_rect%w = texture_width
    src_rect%h = texture_height
    src_rect%x = 0
    src_rect%y = 0

    dst_rect = src_rect

    ! Colourise texture.
    call color_mod(texture, colors)

    loop: do
        ! Poll events.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_KEYDOWN)
                    keys(0:) => sdl_get_keyboard_state()

                    if (keys(SDL_SCANCODE_ESCAPE) == 1) &
                        exit loop

                case (SDL_QUITEVENT)
                    exit loop
            end select
        end if

        ! Bounce horizontally.
        if (dst_rect%x < 0) then
            dst_rect%x = 0
            dx = 1
            call color_mod(texture, colors)
        else if (dst_rect%x + texture_width > screen_width) then
            dst_rect%x = screen_width - texture_width
            dx = -1
            call color_mod(texture, colors)
        end if

        ! Bounce vertically.
        if (dst_rect%y < 0) then
            dst_rect%y = 0
            dy = 1
            call color_mod(texture, colors)
        else if (dst_rect%y + texture_height > screen_height) then
            dst_rect%y = screen_height - texture_height
            dy = -1
            call color_mod(texture, colors)
        end if

        ! Move.
        dst_rect%x = dst_rect%x + dx
        dst_rect%y = dst_rect%y + dy

        ! Render the texture.
        rc = sdl_render_clear(renderer)
        rc = sdl_render_copy(renderer, texture, src_rect, dst_rect)

        call sdl_render_present(renderer)
        call sdl_delay(10)
    end do loop

    ! Quit gracefully.
    call sdl_destroy_texture(texture)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)

    call img_quit()
    call sdl_quit()
contains
    subroutine color_mod(texture, colors)
        type(c_ptr), intent(inout) :: texture
        type(color), intent(inout) :: colors(:)
        integer, save              :: c = 0
        integer                    :: n
        real                       :: r

        n = c

        do while (c == n)
            call random_number(r)
            n = 1 + int(r * size(colors))
        end do

        c = n

        rc = sdl_set_texture_color_mod(texture, colors(c)%r, &
                                                colors(c)%g, &
                                                colors(c)%b)
    end subroutine color_mod
end program main
