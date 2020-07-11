! pixel.f90
!
! Example that reads in a BMP file and then copies the image pixel by pixel to
! the screen, by accessing pixels of SDL_Surface and SDL_Texture directly.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stderr => error_unit, stdout => output_unit
    use :: sdl2
    implicit none

    character(len=*), parameter :: IMAGE_FILE    = 'lena.bmp'
    integer,          parameter :: SCREEN_WIDTH  = 320
    integer,          parameter :: SCREEN_HEIGHT = 200

    type :: texture_type
        integer                          :: access              ! Texture access.
        integer                          :: format              ! Texture format.
        integer                          :: pitch               ! Texture pitch.
        integer                          :: width               ! Texture width.
        integer                          :: height              ! Texture height.
        integer(kind=c_int8_t),  pointer :: surface_pixels(:)   ! SDL_Surface pixels pointer.
        integer(kind=c_int32_t), pointer :: texture_pixels(:)   ! SDL_Texture pixels pointer.
        type(c_ptr)                      :: pixels_ptr          ! C pointer to texture pixels.
        type(c_ptr)                      :: texture             ! C pointer to SDL_Texture.
        type(sdl_pixel_format),  pointer :: pixel_format        ! SDL_PixelFormat of SDL_Texture.
        type(sdl_surface),       pointer :: surface             ! SDL_Surface pointer.
    end type texture_type

    type(texture_type)      :: buffer
    type(texture_type)      :: image
    type(c_ptr)             :: renderer
    type(c_ptr)             :: window
    type(sdl_event)         :: event
    type(sdl_rect)          :: rect
    integer(kind=c_int32_t) :: pixel
    integer                 :: rc
    integer                 :: x, y
    integer(kind=2)         :: r, g, b

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
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
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, &
                                                   SDL_RENDERER_PRESENTVSYNC))

    ! Load image file into texture.
    image%surface => sdl_load_bmp(IMAGE_FILE // c_null_char)
    image%texture = sdl_create_texture_from_surface(renderer, image%surface)

    ! Get texture size.
    rc = sdl_query_texture(image%texture, image%format, image%access, image%width, image%height)

    ! Get SDL_PixelFormat.
    image%pixel_format => sdl_get_pixel_format(image%surface)

    ! Create frame buffer texture.
    buffer%texture = sdl_create_texture(renderer, &
                                        SDL_PIXELFORMAT_ARGB8888, &
                                        SDL_TEXTUREACCESS_STREAMING, &
                                        image%width, &
                                        image%height)
    buffer%format = sdl_get_window_pixel_format(window)
    buffer%pixel_format => sdl_alloc_format(buffer%format)

    ! Set texture size.
    buffer%width  = image%width
    buffer%height = image%height

    ! Set rectangle.
    rect = sdl_rect(0, 0, image%width, image%height)

    ! Lock buffer texture for direct pixel access.
    if (sdl_lock_texture(buffer%texture, rect, buffer%pixels_ptr, buffer%pitch) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Convert C pointer to Fortran pointer.
    call c_f_pointer(buffer%pixels_ptr, buffer%texture_pixels, shape=[buffer%width * buffer%height])
    call c_f_pointer(image%surface%pixels, image%surface_pixels, shape=[image%surface%pitch * image%surface%h])

    ! Copy pixels from SDL_Surface to SDL_Texture.
    do y = 1, image%height
        do x = 1, image%width
            ! Get pixel value from SDL_Surface.
            pixel = ichar(transfer(image%surface_pixels((y - 1) * image%surface%pitch + x), 'a'))
            ! Convert pixel value to RGB.
            call sdl_get_rgb(pixel, image%pixel_format, r, g, b)
            ! Set pixel in SDL_Texture.
            buffer%texture_pixels(((y - 1) * image%width) + x) = sdl_map_rgb(buffer%pixel_format, &
                                                                             int(r, kind=4), &
                                                                             int(g, kind=4), &
                                                                             int(b, kind=4))
        end do
    end do

    call sdl_unlock_texture(buffer%texture)

    ! Main loop.
    loop: do
        ! Event handling.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit loop
            end select
        end if

        ! Copy buffer texture to screen.
        rc = sdl_render_copy(renderer, buffer%texture, rect, rect)
        call sdl_render_present(renderer)
    end do loop

    ! Quit gracefully.
    call sdl_destroy_texture(buffer%texture)
    call sdl_destroy_texture(image%texture)
    call sdl_free_surface(image%surface)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
