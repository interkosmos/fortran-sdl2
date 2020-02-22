! opera.f90
!
! Plays an OGG file using SDL2_mixer and outputs some text on a background image
! with SDL2_ttf (software renderer).
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: sdl2_mixer
    use :: sdl2_ttf
    implicit none

    integer,          parameter :: WIN_WIDTH  = 320
    integer,          parameter :: WIN_HEIGHT = 240
    character(len=*), parameter :: FILE_NAME  = 'italy.bmp'
    character(len=*), parameter :: OGG_PATH   = 'opera.ogg'
    character(len=*), parameter :: TTF_PATH   = 'font.ttf'
    character(len=*), parameter :: MESSAGE    = 'Playing ' // OGG_PATH // ' ...'

    integer     :: rc
    logical     :: done = .false.
    type(c_ptr) :: font
    type(c_ptr) :: music
    type(c_ptr) :: window

    type(sdl_color)                 :: color
    type(sdl_event)                 :: event
    type(sdl_pixel_format), pointer :: pixel_format
    type(sdl_rect)                  :: rect_image
    type(sdl_rect)                  :: rect_text
    type(sdl_surface),      pointer :: image_loaded
    type(sdl_surface),      pointer :: image_opt
    type(sdl_surface),      pointer :: text
    type(sdl_surface),      pointer :: window_surface

    ! Initialise SDL.
    rc = sdl_init(ior(SDL_INIT_VIDEO, SDL_INIT_AUDIO))

    if (rc < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Initialise SDL_ttf.
    rc = ttf_init()

    if (rc < 0) then
        write (stderr, *) 'TTF Error: ', sdl_get_error()
        stop
    end if

    ! Set font colour. We need some `transfer()` magic to cast
    ! from Fortran integer to C `Uint8`.
    color%r = transfer([255, 0], 1_c_int8_t)
    color%g = transfer([165, 0], 1_c_int8_t)
    color%b = transfer([  0, 0], 1_c_int8_t)
    color%a = transfer([255, 0], 1_c_int8_t)

    ! Open font and draw to surface.
    font = ttf_open_font(TTF_PATH // c_null_char, 12)
    text => ttf_render_text_solid(font, MESSAGE // c_null_char, color)

    rect_text%x = 0
    rect_text%y = 0
    rect_text%w = text%w
    rect_text%h = text%h

    ! Initialise SDL_mixer.
    rc = mix_open_audio(MIX_DEFAULT_FREQUENCY, &
                        AUDIO_S16LSB, &
                        MIX_DEFAULT_CHANNELS, &
                        4096)

    if (rc < 0) then
        write (stderr, *) 'MIX Error: ', sdl_get_error()
        stop
    end if

    ! Play music.
    music = mix_load_mus(OGG_PATH // c_null_char)
    rc    = mix_play_music(music, -1)

    if (rc < 0) then
        write (stderr, *) 'MIX Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('Fortran SDL 2.0' // c_null_char, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               WIN_WIDTH, &
                               WIN_HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    window_surface => sdl_get_window_surface(window)                     ! Get surface of window.
    image_loaded   => sdl_load_bmp(FILE_NAME // c_null_char)             ! Load BMP file.
    pixel_format   => sdl_get_pixel_format(window_surface)               ! Get pixel format of window.
    image_opt      => sdl_convert_surface(image_loaded, pixel_format, 0) ! Optimise pixel format of image.

    rect_image%x = 0
    rect_image%y = 0
    rect_image%w = WIN_WIDTH
    rect_image%h = WIN_HEIGHT

    rc = sdl_update_window_surface(window)

    ! Event loop.
    do while (.not. done)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    done = .true.
            end select

            rc = sdl_blit_surface(image_opt, rect_image, window_surface, rect_image)
            rc = sdl_blit_surface(text, rect_text, window_surface, rect_text)
            rc = sdl_update_window_surface(window)
        else
            call sdl_delay(50)
        end if
    end do

    ! Quit gracefully.
    call mix_free_music(music)
    call mix_close_audio()

    call ttf_close_font(font)
    call ttf_quit()

    call sdl_free_surface(text)
    call sdl_free_surface(image_opt)
    call sdl_free_surface(image_loaded)

    call sdl_destroy_window(window)
    call sdl_quit()
end program main
