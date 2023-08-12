! text.f90
!
! Example that shows how to draw some text with SDL_ttf using
! the hardware renderer.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: sdl2_ttf
    implicit none

    integer,          parameter :: SCREEN_WIDTH  = 320
    integer,          parameter :: SCREEN_HEIGHT = 240
    character(len=*), parameter :: STRING        = 'Hello, World!'
    character(len=*), parameter :: FONT_PATH     = 'share/font.ttf'

    type(c_ptr)                :: window
    type(c_ptr)                :: renderer
    type(c_ptr)                :: texture
    type(c_ptr)                :: font
    type(sdl_surface), pointer :: surface
    type(sdl_rect)             :: rect
    type(sdl_event)            :: event
    type(sdl_color)            :: color
    integer                    :: rc
    logical                    :: done = .false.

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Initialise SDL_ttf.
    if (ttf_init() < 0) then
        write (stderr, *) 'TTF Error: ', sdl_get_error()
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

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, SDL_RENDERER_ACCELERATED)

    ! Load font and set font colour.
    font = ttf_open_font(FONT_PATH // c_null_char, 12)

    ! Set font colour.
    color = sdl_color(uint8(255),  uint8(0), uint8(0), uint8(SDL_ALPHA_OPAQUE))

    ! Event loop.
    do while (.not. done)
        if (sdl_wait_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    done = .true.
            end select
        end if

        ! Prepare texture.
        surface => ttf_render_text_solid(font, STRING // c_null_char, color)
        texture = sdl_create_texture_from_surface(renderer, surface)
        rect    = sdl_rect(0, 0, surface%w, surface%h)

        ! Render text.
        rc = sdl_render_clear(renderer)
        rc = sdl_render_copy(renderer, texture, rect, rect)

        call sdl_render_present(renderer)

        call sdl_destroy_texture(texture)
        call sdl_free_surface(surface)

        call sdl_delay(50)
    end do

    ! Quit gracefully.
    call ttf_close_font(font)
    call ttf_quit()

    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
