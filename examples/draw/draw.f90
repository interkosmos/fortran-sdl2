! draw.f90
!
! Drawing on the window, using the hardware renderer.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use :: sdl2
    use :: sdl2_consts
    use :: sdl2_types
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
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        print *, 'SDL Error: ', sdl_get_error()
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

    ! Rectangles.
    rect1%x = 50
    rect1%y = 50
    rect1%w = 250
    rect1%h = 250

    rect2%x = 75
    rect2%y = 75
    rect2%w = 250
    rect2%h = 250

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, 0)

    do while (.true.)
        rc = sdl_poll_event(event)

        if (rc > 0) then
            select case (event%type)
                case (SDL_QUIT_TYPE)
                    exit
            end select
        end if

        ! Clear screen.
        rc = sdl_set_render_draw_color(renderer, 0, 0, 0, 255)
        rc = sdl_render_clear(renderer)

        ! Draw lines.
        rc = sdl_set_render_draw_color(renderer, 255, 0, 127, 255)
        rc = sdl_render_draw_line(renderer, 10, 10, 400, 100)
        rc = sdl_render_draw_line(renderer, 80, 400, 525, 300)

        ! Fill a rectangle.
        rc = sdl_set_render_draw_color(renderer, 127, 255, 0, 255)
        rc = sdl_render_fill_rect(renderer, rect1)

        ! Draw a rectangle.
        rc = sdl_set_render_draw_color(renderer, 127, 0, 255, 255)
        rc = sdl_render_draw_rect(renderer, rect2)

        ! Draw some points.
        rc = sdl_set_render_draw_color(renderer, 255, 255, 255, 255)

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
