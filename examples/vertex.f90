! vertex.f90
!
! Examples that demonstrates the geometry renderer of SDL 2.0.18.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 800
    integer, parameter :: SCREEN_HEIGHT = 600

    integer          :: rc
    logical          :: done
    type(c_ptr)      :: window
    type(c_ptr)      :: renderer
    type(sdl_event)  :: event
    type(sdl_vertex) :: vertices(3)

    vertices(1)%position%x = 400
    vertices(1)%position%y = 150
    vertices(1)%color%r = uint8(255)
    vertices(1)%color%g = uint8(0)
    vertices(1)%color%b = uint8(0)
    vertices(1)%color%a = uint8(SDL_ALPHA_OPAQUE)

    vertices(2)%position%x = 200
    vertices(2)%position%y = 450
    vertices(2)%color%r = uint8(0)
    vertices(2)%color%g = uint8(0)
    vertices(2)%color%b = uint8(255)
    vertices(2)%color%a = uint8(SDL_ALPHA_OPAQUE)

    vertices(3)%position%x = 600
    vertices(3)%position%y = 450
    vertices(3)%color%r = uint8(0)
    vertices(3)%color%g = uint8(255)
    vertices(3)%color%b = uint8(0)
    vertices(3)%color%a = uint8(SDL_ALPHA_OPAQUE)

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
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
    done = .false.

    do while (.not. done)
        do while (sdl_poll_event(event) /= 0)
            select case (event%type)
                case (SDL_QUITEVENT); done = .true.
            end select
        end do

        rc = sdl_set_render_draw_color(renderer, uint8(0), uint8(0), uint8(0), uint8(255))
        rc = sdl_render_clear(renderer)
        rc = sdl_render_geometry(renderer, c_null_ptr, vertices, size(vertices), c_null_ptr, 0)
        call sdl_render_present(renderer)
        call sdl_delay(20)
    end do

    ! Quit gracefully.
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
