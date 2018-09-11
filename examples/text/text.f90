! text.f90
!
! Example that shows how to draw some text with SDL_ttf using
! the hardware renderer.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
    use :: sdl2_ttf
    implicit none

    integer,          parameter :: WIDTH  = 320
    integer,          parameter :: HEIGHT = 240
    character(len=*), parameter :: STRING = 'Hello, World!'
    character(len=*), parameter :: PATH   = 'examples/text/font.ttf'

    logical                    :: done = .false.
    type(c_ptr)                :: window
    type(c_ptr)                :: renderer
    type(c_ptr)                :: texture
    type(c_ptr)                :: font
    type(sdl_surface), pointer :: surface
    type(sdl_rect)             :: rect
    type(sdl_event)            :: event
    type(sdl_color)            :: color
    integer                    :: rc

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

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

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, SDL_RENDERER_ACCELERATED)

    ! Load font and set font color.
    font    = ttf_open_font(PATH // c_null_char, 12)
    color%r = 255; color%g = 0; color%b = 0; color%a = 0

    ! Event loop.
    do while (.not. done)
        rc = sdl_wait_event(event)

        if (rc > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    done = .true.
            end select
        end if

        ! Prepare texture.
        surface => ttf_render_text_solid(font, STRING // c_null_char, color)
        texture = sdl_create_texture_from_surface(renderer, surface)

        rect%x = 0
        rect%y = 0
        rect%w = surface%w
        rect%h = surface%h

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
