! music.f90
!
! Plays an OGG file using SDL2_mixer and outputs some text
! with SDL2_ttf (software renderer).
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    use :: sdl2_mixer
    use :: sdl2_ttf
    implicit none

    integer,          parameter :: WIDTH    = 320
    integer,          parameter :: HEIGHT   = 240
    character(len=*), parameter :: OGG_PATH = 'examples/music/music.ogg'
    character(len=*), parameter :: TTF_PATH = 'examples/music/font.ttf'
    character(len=*), parameter :: MESSAGE  = 'Playing ' // OGG_PATH // ' ...'

    logical                    :: done = .false.
    type(c_ptr)                :: window
    type(sdl_surface), pointer :: screen
    type(sdl_surface), pointer :: text
    type(sdl_rect)             :: rect
    type(sdl_event)            :: event
    type(sdl_color)            :: color
    type(c_ptr)                :: font
    type(c_ptr)                :: music
    integer                    :: rc

    ! Initialise SDL.
    rc = sdl_init(ior(SDL_INIT_VIDEO, SDL_INIT_AUDIO))

    if (rc < 0) then
        print *, 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Initialise SDL_ttf.
    rc = ttf_init()

    if (rc < 0) then
        print *, 'TTF Error: ', sdl_get_error()
        stop
    end if

    ! Open font and draw to surface.
    color%r = 255; color%g = 165; color%b = 0; color%a = 255
    font    = ttf_open_font(TTF_PATH // c_null_char, 12)
    text    => ttf_render_text_solid(font, MESSAGE // c_null_char, color)

    rect%x = 0
    rect%y = 0
    rect%w = text%w
    rect%h = text%h

    ! Initialise SDL_mixer.
    rc = mix_open_audio(MIX_DEFAULT_FREQUENCY, &
                        AUDIO_S16LSB, &
                        MIX_DEFAULT_CHANNELS, &
                        4096)

    if (rc < 0) then
        print *, 'MIX Error: ', sdl_get_error()
        stop
    end if

    ! Play music.
    music = mix_load_mus(OGG_PATH // c_null_char)
    rc    = mix_play_music(music, -1)

    if (rc < 0) then
        print *, 'MIX Error: ', sdl_get_error()
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

    ! Get the window surface.
    screen => sdl_get_window_surface(window)
    rc = sdl_update_window_surface(window)

    ! Event loop.
    do while (.not. done)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (SDL_QUIT_TYPE)
                    done = .true.
            end select

            ! Copy text surface to screen.
            rc = sdl_blit_surface(text, rect, screen, rect)
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
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
