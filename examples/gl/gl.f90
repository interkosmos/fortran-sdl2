! gl.f90
!
! Example that shows how to render a triangle with OpenGL 1.3.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stderr => error_unit, stdout => output_unit
    use :: sdl2
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 800
    integer, parameter :: SCREEN_HEIGHT = 600

    type(c_ptr)     :: context
    type(c_ptr)     :: window
    type(sdl_event) :: event
    integer         :: rc

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_EVERYTHING) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Enable multisampling for anti-aliasing.
    rc = sdl_gl_set_attribute(SDL_GL_MULTISAMPLEBUFFERS, 1)
    rc = sdl_gl_set_attribute(SDL_GL_MULTISAMPLESAMPLES, 8)

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

    ! Create OpenGL context.
    context = sdl_gl_create_context(window)
    call gl_init(SCREEN_WIDTH, SCREEN_HEIGHT)

    ! Main loop.
    loop: do
        ! Event handling.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit loop
            end select
        end if

        call display()
    end do loop

    ! Quit gracefully.
    call sdl_gl_delete_context(context)
    call sdl_destroy_window(window)
    call sdl_quit()
contains
    subroutine gl_init(screen_width, screen_height)
        ! Initialises OpenGL.
        integer, intent(in) :: screen_width, screen_height
        real(kind=8)        :: aspect

        call glmatrixmode(GL_PROJECTION)
        ! Set aspect ratio of 2D orthographic projection.
        aspect = real(screen_width, kind=8) / real(screen_height, kind=8)
        call glortho(-aspect, aspect, -1.0_8, 1.0_8, -1.0_8, 1.0_8)

        call glmatrixmode(GL_MODELVIEW)
        call glenable(GL_DEPTH_TEST)
        call glclearcolor(0.0, 0.0, 0.0, 1.0)
    end subroutine gl_init

    subroutine display()
        !! The display routine, called every frame.
        call glclear(ior(GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT)) ! Clear the screen and depth buffer.
        call glloadidentity()                                       ! Reset current model view matrix.

        ! Render a coloured triangle.
        call glbegin(gl_triangles)
            call glcolor3f(1.0, 0.0, 0.0) ! red
            call glvertex2f(-0.8, -0.8)

            call glcolor3f(0.0, 1.0, 0.0) ! green
            call glvertex2f(0.8, -0.8)

            call glcolor3f(0.0, 0.0, 1.0) ! blue
            call glvertex2f(0.0, 0.9)
        call glend()

        call sdl_gl_swap_window(window)
    end subroutine display
end program main
