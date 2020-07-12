! gl3d.f90
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

    rc = sdl_gl_set_attribute(SDL_GL_DEPTH_SIZE,         16)
    rc = sdl_gl_set_attribute(SDL_GL_BUFFER_SIZE,        32)
    rc = sdl_gl_set_attribute(SDL_GL_MULTISAMPLEBUFFERS, 1)
    rc = sdl_gl_set_attribute(SDL_GL_MULTISAMPLESAMPLES, 2)

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

        call glviewport(0, 0, screen_width, screen_height)

        ! Projection matrix.
        call glmatrixmode(GL_PROJECTION)
        call glloadidentity()

        aspect = real(screen_width, kind=8) / real(screen_height, kind=8)
        call gl_perspective(45.0_8, aspect, 0.1_8, 50.0_8)

        ! Model view matrix.
        call glmatrixmode(GL_MODELVIEW)
        call glenable(GL_TEXTURE_2D)
        call glenable(GL_DEPTH_TEST)
        call glloadidentity()
        call glclearcolor(0.0, 0.0, 0.0, 1.0)
    end subroutine gl_init

    subroutine gl_perspective(fov_y, aspect, z_near, z_far)
        !! Sets perspective, like `gluPerspective()`, but without GLU.
        real(kind=8), parameter  :: PI = acos(-1.0_8)
        real(kind=8), intent(in) :: fov_y
        real(kind=8), intent(in) :: aspect
        real(kind=8), intent(in) :: z_near
        real(kind=8), intent(in) :: z_far
        real(kind=8)             :: fw, fh

        fh = tan(fov_y / 360. * PI) * z_near
        fw = fh * aspect
        call glfrustum(-fw, fw, -fh, fh, z_near, z_far)
    end subroutine gl_perspective

    subroutine display()
        !! The display routine, called every frame.
        real, save :: angle = 0

        call glclear(ior(GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT)) ! Clear the screen and depth buffer.
        call glloadidentity()                                       ! Reset current model view matrix.

        call gltranslatef(0.0, 0.0, -2.0)    ! Move in Z direction.

        angle = modulo(angle + 1.0, 360.)
        call glrotatef(angle, 1.0, 0.0, 0.0) ! Rotate in X.
        call glrotatef(angle, 0.0, 1.0, 0.0) ! Rotate in Y.
        call cube(size=0.5)

        call sdl_gl_swap_window(window)
    end subroutine display

    subroutine square(r, g, b)
        !! Renders a square in colour r, g, b.
        real(kind=GLfloat), intent(in) :: r, g, b

        call glcolor3f(r, g, b)

        call glbegin(GL_TRIANGLE_FAN)
            call glvertex3f(-0.5, -0.5, 0.5)
            call glvertex3f( 0.5, -0.5, 0.5)
            call glvertex3f( 0.5,  0.5, 0.5)
            call glvertex3f(-0.5,  0.5, 0.5)
        call glend()
    end subroutine square

    subroutine cube(size)
        !! Renders a cube out of squares.
        real(kind=GLfloat), intent(in) :: size

        ! Save a copy of the current matrix.
        call glpushmatrix()

        call glscalef(size, size, size)
        call square(1.0, 0.0, 0.0) ! red front face

        call glpushmatrix()
        call glrotatef(90.0, 0.0, 1.0, 0.0)
        call square(0.0, 1.0, 0.0) ! green right face
        call glpopmatrix()

        call glpushmatrix()
        call glrotatef(-90.0, 1.0, 0.0, 0.0)
        call square(0.0, 0.0, 1.0) ! blue top face
        call glpopmatrix()

        call glpushmatrix()
        call glrotatef(180.0, 0.0, 1.0, 0.0)
        call square(0.0, 1.0, 1.0) ! cyan back face
        call glpopmatrix()

        call glpushmatrix()
        call glrotatef(-90.0, 0.0, 1.0, 0.0)
        call square(1.0, 0.0, 1.0) ! magenta left face
        call glpopmatrix()

        call glpushmatrix()
        call glrotatef(90.0, 1.0, 0.0, 0.0)
        call square(1.0, 1.0, 0.0) ! yellow bottom face
        call glpopmatrix()

        ! Restore matrix to its state before subroutine was called.
        call glpopmatrix()
    end subroutine cube
end program main
