! glsphere.f90
!
! OpenGL example that rotates the camera around GLU spheres.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module camera
    use, intrinsic :: iso_fortran_env, only: r8 => real64
    implicit none
    private

    type, public :: camera_class
        real(kind=r8) :: x, y, z
    contains
        procedure :: init   => camera_init
        procedure :: update => camera_update
    end type camera_class
contains
    subroutine camera_init(this, x, y, z)
        class(camera_class), intent(inout) :: this
        real(kind=r8),       intent(in)    :: x
        real(kind=r8),       intent(in)    :: y
        real(kind=r8),       intent(in)    :: z

        this%x = x
        this%y = y
        this%z = z
    end subroutine camera_init

    subroutine camera_update(this, angle)
        real(kind=r8), parameter :: PI = acos(-1.0_r8)

        class(camera_class), intent(inout) :: this
        real,                intent(in)    :: angle
        real(kind=r8)                      :: dir

        dir = angle * PI / 180
        this%x = cos(dir)
        this%z = sin(dir)
    end subroutine camera_update
end module camera

module sphere
    use :: sdl2
    use :: glu
    implicit none
    private

    type, public :: sphere_class
        real         :: x
        real         :: y
        real         :: z
        real(kind=8) :: radius
        integer      :: slices
        integer      :: stacks
        real         :: ambient(4)
        real         :: diffuse(4)
        real         :: specular(4)
        real         :: emission(4)
        real         :: shininess
        type(c_ptr)  :: quadric
    contains
        procedure :: init    => sphere_init
        procedure :: destroy => sphere_destroy
        procedure :: render  => sphere_render
    end type sphere_class
contains
    subroutine sphere_init(this, x, y, z, radius, diffuse)
        class(sphere_class), intent(inout) :: this
        real,                intent(in)    :: x
        real,                intent(in)    :: y
        real,                intent(in)    :: z
        real(kind=8),        intent(in)    :: radius
        real,                intent(in)    :: diffuse(4)

        this%x = x
        this%y = y
        this%z = z

        this%quadric = glunewquadric()
        this%radius  = radius
        this%slices  = 32
        this%stacks  = 32

        this%diffuse   = diffuse
        this%ambient   = [ 0.0, 0.0, 0.0, 1.0 ]
        this%specular  = [ 1.0, 1.0, 1.0, 1.0 ]
        this%emission  = [ 0.0, 0.0, 0.0, 1.0 ]
        this%shininess = 100
    end subroutine sphere_init

    subroutine sphere_destroy(this)
        class(sphere_class), intent(inout) :: this

        call gludeletequadric(this%quadric)
    end subroutine sphere_destroy

    subroutine sphere_render(this)
        class(sphere_class), intent(inout) :: this

        call glpushmatrix()
            call gltranslatef(this%x, this%y, this%z)
            call glmaterialfv(GL_FRONT, GL_AMBIENT,  this%ambient)
            call glmaterialfv(GL_FRONT, GL_DIFFUSE,  this%diffuse)
            call glmaterialfv(GL_FRONT, GL_SPECULAR, this%specular)
            call glmaterialf(GL_FRONT, GL_SHININESS, this%shininess)
            call glmaterialfv(GL_FRONT, GL_EMISSION, this%emission)
            call glusphere(this%quadric, this%radius, this%slices, this%stacks)
        call glpopmatrix()
    end subroutine sphere_render
end module sphere

program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stderr => error_unit, stdout => output_unit
    use :: sdl2
    use :: glu
    use :: camera
    use :: sphere
    implicit none

    character(len=*), parameter :: WINDOW_TITLE  = 'Fortran SDL 2.0'
    integer,          parameter :: SCREEN_WIDTH  = 1024
    integer,          parameter :: SCREEN_HEIGHT = 768

    character(len=32)        :: title
    type(c_ptr)              :: context
    type(c_ptr)              :: window
    type(sdl_event)          :: event
    type(camera_class)       :: eye
    type(sphere_class)       :: spheres(2)
    integer(kind=1), pointer :: keys(:)
    integer                  :: fc, fps, i, t1

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_EVERYTHING) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window(WINDOW_TITLE // c_null_char, &
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

    ! Enable VSync.
    if (sdl_gl_set_swap_interval(1) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
    end if

    ! Initialise OpenGL.
    call gl_init(SCREEN_WIDTH, SCREEN_HEIGHT)

    ! Initialise camera.
    call eye%init(1.0_8, 1.0_8, 1.0_8)
    call eye%update(90.0)

    ! Initialise spheres.
    call spheres(1)%init(0.0, 0.0, 0.0, 0.2_8, [ 0.1, 0.5, 0.8, 1.0 ])
    call spheres(2)%init(0.2, 0.2, 0.3, 0.1_8, [ 0.8, 0.0, 0.2, 1.0 ])

    ! Main loop.
    loop: do
        t1 = sdl_get_ticks()

        ! Event handling.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit loop
            end select
        end if

        ! Check keyboard input.
        keys(0:) => sdl_get_keyboard_state()
        if (keys(int(SDL_SCANCODE_ESCAPE, kind=1)) == 1) exit loop

        ! Render the scene.
        call render(eye, spheres)
        call sdl_gl_swap_window(window)

        ! Show frames per second.
        fps = current_fps(t1)
        fc  = fc + 1

        if (fc >= fps) then
            fc = 0
            write (title, '(2a, i2, 2a)') WINDOW_TITLE, ' (', fps, ' FPS)', c_null_char
            call sdl_set_window_title(window, title)
        end if
    end do loop

    do i = 1, size(spheres)
        call spheres(i)%destroy()
    end do

    call sdl_gl_delete_context(context)
    call sdl_destroy_window(window)
    call sdl_quit()
contains
    function current_fps(t1)
        !! Calculates current frames per seconds.
        integer, intent(in) :: t1           !! First time value.
        integer             :: current_fps  !! Result.
        integer             :: dt           !! Time delta.
        integer, save       :: fc           !! Frame counter.
        integer, save       :: ft           !! Frame time.
        integer, save       :: fps          !! Frames per second.

        dt = sdl_get_ticks() - t1

        if (ft >= 1000) then
            fps = fc
            fc  = 0
            ft  = 0
        else
            fc = fc + 1
            ft = ft + dt
        end if

        current_fps = fps
    end function current_fps

    subroutine gl_init(screen_width, screen_height)
        !! Initialises OpenGL.
        integer, intent(in) :: screen_width, screen_height
        real(kind=8)        :: aspect

        ! Set drawing region.
        call glviewport(0, 0, screen_width, screen_height)

        ! Set projection matrix.
        call glmatrixmode(GL_PROJECTION)
        call glloadidentity()
        aspect = real(screen_width, kind=8) / real(screen_height, kind=8)
        call gluperspective(45.0_8, aspect, 0.1_8, 50.0_8)

        ! Set model view matrix.
        call glmatrixmode(GL_MODELVIEW)
        call glenable(GL_DEPTH_TEST)
        call glcullface(GL_BACK)
        call glenable(GL_CULL_FACE)

        ! Set lighting.
        call gllightmodelfv(GL_LIGHT_MODEL_AMBIENT, [ 0.2, 0.2, 0.2 ])
        call gllightmodeli(GL_LIGHT_MODEL_LOCAL_VIEWER, 0)
        call gllightmodeli(GL_LIGHT_MODEL_TWO_SIDE, 1)
        call glenable(GL_LIGHT0)
        call glenable(GL_LIGHTING)

        call glloadidentity()
        call glclearcolor(0.0, 0.0, 0.0, 1.0)
    end subroutine gl_init

    subroutine render(eye, spheres)
        !! The display routine, called every frame.
        type(camera_class), intent(inout) :: eye
        type(sphere_class), intent(inout) :: spheres(:)
        integer                           :: i
        real, save                        :: angle

        angle = modulo(angle + 0.25, 360.0)
        call eye%update(angle)

        call glclear(ior(GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT)) ! Clear the screen and depth buffer.
        call glmatrixmode(GL_MODELVIEW)                             ! Alter model view matrix.
        call glloadidentity()                                       ! Reset current model view matrix.
        call glulookat(eye%x, eye%y, eye%z, &
                       0.0_8, 0.0_8, 0.0_8, &
                       0.0_8, 1.0_8, 0.0_8)

        do i = 1, size(spheres)
            call spheres(i)%render()
        end do
    end subroutine render
end program main
