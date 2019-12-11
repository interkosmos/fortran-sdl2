! draw.f90
!
! Example that draws on the window using the hardware renderer.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f08sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_int8_t, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: WIDTH  = 640
    integer, parameter :: HEIGHT = 480
    real,    parameter :: RAD    = acos(-1.0) / 180

    type(c_ptr)     :: window
    type(c_ptr)     :: renderer
    type(sdl_event) :: event
    type(sdl_rect)  :: rect1, rect2
    integer         :: i, rc, x, y

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
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
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Rectangles.
    rect1 = sdl_rect(50, 50, 250, 250)
    rect2 = sdl_rect(75, 75, 250, 250)

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, 0)

    do while (.true.)
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit
            end select
        end if

        ! Clear screen.
        rc = sdl_set_render_draw_color(renderer, uint8(0), uint8(0), uint8(0), uint8(SDL_ALPHA_OPAQUE))
        rc = sdl_render_clear(renderer)

        ! Draw lines.
        rc = sdl_set_render_draw_color(renderer, uint8(255), uint8(0), uint8(127), uint8(SDL_ALPHA_OPAQUE))
        rc = sdl_render_draw_line(renderer, 10, 10, 400, 100)
        rc = sdl_render_draw_line(renderer, 80, 400, 525, 300)

        ! Fill a rectangle.
        rc = sdl_set_render_draw_color(renderer, uint8(127), uint8(0), uint8(255), uint8(SDL_ALPHA_OPAQUE))
        rc = sdl_render_fill_rect(renderer, rect1)

        ! Draw a rectangle.
        rc = sdl_set_render_draw_color(renderer, uint8(255), uint8(127), uint8(255), uint8(SDL_ALPHA_OPAQUE))
        rc = sdl_render_draw_rect(renderer, rect2)

        ! Draw some points.
        rc = sdl_set_render_draw_color(renderer, uint8(255), uint8(255), uint8(255), uint8(SDL_ALPHA_OPAQUE))

        do i = 0, 345, 15
            x  = int(100.0 * cos(i * RAD))
            y  = int(100.0 * sin(i * RAD))
            rc = sdl_render_draw_point(renderer, 450 + x, 300 + y)
        end do

        ! Render to window.
        call sdl_render_present(renderer)
        call sdl_delay(20)
    end do

    ! Quit gracefully.
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
