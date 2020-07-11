! opengl.f90
!
! Example that shows how to draw a triangle with OpenGL 1.1.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stderr => error_unit, stdout => output_unit
    use :: sdl2
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 640
    integer, parameter :: SCREEN_HEIGHT = 400

    type(c_ptr)     :: context
    type(c_ptr)     :: window
    type(sdl_event) :: event

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
                               ior(SDL_WINDOW_OPENGL, SDL_WINDOW_SHOWN))

    if (.not. c_associated(window)) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    context = sdl_gl_create_context(window)

    ! Main loop.
    loop: do
        ! Event handling.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit loop
            end select
        end if

        call glviewport(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        call glclearcolor(0.0, 0.0, 0.0, 1.0)
        call glclear(GL_COLOR_BUFFER_BIT)

        call glbegin(gl_triangles)
            call glcolor3f(1.0, 0.0, 0.0) ! red
            call glvertex2f(-0.8, -0.8)

            call glcolor3f(0.0, 1.0, 0.0) ! green
            call glvertex2f(0.8, -0.8)

            call glcolor3f(0.0, 0.0, 1.0) ! blue
            call glvertex2f(0.0, 0.9)
        call glend()

        call sdl_gl_swap_window(window)
    end do loop

    ! Quit gracefully.
    call sdl_gl_delete_context(context)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
