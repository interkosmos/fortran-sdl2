! gl3d.f90
!
! Example that renders three textured cubes with OpenGL 1.3 (using the legacy
! fixed rendering pipeline).
!
! Author:  Philipp Engel
! Licence: ISC
module util
    use, intrinsic :: iso_fortran_env, only: r8 => real64
    implicit none
    private
    public :: camera_update

    type, public :: vector_type
        real(r8) :: x, y, z
    end type vector_type

    type, public :: camera_type
        type(vector_type) :: pos
        type(vector_type) :: eye
        real(r8)          :: dir
    end type camera_type
contains
    subroutine camera_update(camera, angle)
        real(r8), parameter :: PI = acos(-1.0_r8)

        type(camera_type), intent(inout) :: camera
        real,              intent(in)    :: angle

        camera%dir   = angle * PI / 180
        camera%eye%x = cos(camera%dir)
        camera%eye%z = sin(camera%dir)
    end subroutine camera_update
end module util

program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i1 => int8, i8 => int64, r8 => real64, stderr => error_unit, stdout => output_unit
    use :: sdl2
    use :: sdl2_image
    use :: glu
    use :: util
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 800
    integer, parameter :: SCREEN_HEIGHT = 600

    type(c_ptr)          :: context
    type(c_ptr)          :: window
    type(sdl_event)      :: event
    type(camera_type)    :: camera
    character(32)        :: file_name
    integer(i1), pointer :: keys(:)
    integer              :: textures(3)
    integer              :: i, id, rc

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_EVERYTHING) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    if (img_init(IMG_INIT_PNG) < 0) then
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

    ! Load texture files.
    do i = 1, size(textures)
        write (file_name, '("share/t", i1, ".png")') i
        print '(3a)', 'Loading texture file "', trim(file_name), '" ...'

        if (.not. load_texture(id, trim(file_name))) stop 'Error: texture file not found'
        textures(i) = id
    end do

    ! Initialise OpenGL.
    call gl_init(SCREEN_WIDTH, SCREEN_HEIGHT)

    ! Set camera angle to 90 deg.
    call camera_update(camera, 90.0)

    ! Main loop.
    loop: do
        ! Event handling.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT); exit loop
            end select
        end if

        ! Check keyboard input.
        keys(0:) => sdl_get_keyboard_state()
        if (keys(int(SDL_SCANCODE_ESCAPE, i1)) == 1) exit loop

        ! Render the scene.
        call display(camera, textures)
        call sdl_gl_swap_window(window)
    end do loop

    ! Quit gracefully.
    do i = 1, size(textures)
        call gldeletetextures(1, textures(i))
    end do

    call sdl_gl_delete_context(context)
    call sdl_destroy_window(window)
    call img_quit()
    call sdl_quit()
contains
    function load_texture(id, file_path) result (file_exists)
        !! Loads texture from file and sets the argument`id` to the OpenGL
        !! texture id.
        integer,      intent(out) :: id
        character(*), intent(in)  :: file_path
        logical                   :: file_exists

        integer                    :: textures(1)
        type(sdl_rect)             :: rect
        type(sdl_surface), pointer :: image, buffer

        id = -1
        inquire (file=file_path, exist=file_exists)
        if (.not. file_exists) return

        ! Load image file to surface and create buffer surface in OpenGL format.
        ! Then, copy image to buffer in order to convert the pixel format.
        image  => img_load(file_path // c_null_char)
        buffer => sdl_create_rgb_surface(0, image%w, image%h, 32, &
                                         int(z'000000FF', i8), &
                                         int(z'0000FF00', i8), &
                                         int(z'00FF0000', i8), &
                                         int(z'FF000000', i8))
        rect = sdl_rect(0, 0, image%w, image%h)
        rc   = sdl_blit_surface(image, rect, buffer, rect)

        ! Create new OpenGL texture.
        call glgentextures(1, textures)
        id = textures(1)

        call glbindtexture(GL_TEXTURE_2D, id)
        call gltexparameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
        call gltexparameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
        call glteximage2d(GL_TEXTURE_2D, 0, GL_RGBA, image%w, image%h, 0, GL_RGBA, GL_UNSIGNED_BYTE, buffer%pixels)

        call sdl_free_surface(buffer)
        call sdl_free_surface(image)
    end function load_texture

    subroutine gl_init(screen_width, screen_height)
        !! Initialises OpenGL.
        integer, intent(in) :: screen_width, screen_height

        real(r8) :: aspect

        ! Set drawing region.
        call glviewport(0, 0, screen_width, screen_height)

        ! Set projection matrix.
        call glmatrixmode(GL_PROJECTION)
        call glloadidentity()

        aspect = real(screen_width, r8) / real(screen_height, r8)
        ! Alternatively:
        ! call gl_perspective(45.0_r8, aspect, 0.1_r8, 50.0_r8)
        call gluperspective(45.0_r8, aspect, 0.1_r8, 50.0_r8)

        ! Set model view matrix.
        call glmatrixmode(GL_MODELVIEW)
        call glenable(GL_DEPTH_TEST)
        call glenable(GL_TEXTURE_2D)

        call glcullface(GL_BACK)
        call glenable(GL_CULL_FACE)

        call glloadidentity()
        call glclearcolor(0.0, 0.0, 0.0, 1.0)
    end subroutine gl_init

    subroutine gl_perspective(fovy, aspect, znear, zfar)
        !! Sets perspective, much like `gluPerspective()`, but without the GLU
        !! dependency.
        real(r8), parameter :: PI = acos(-1.0_r8)

        real(r8), intent(in) :: fovy
        real(r8), intent(in) :: aspect
        real(r8), intent(in) :: znear
        real(r8), intent(in) :: zfar

        real(r8) :: fw, fh

        fh = tan(fovy / 360. * PI) * znear
        fw = fh * aspect
        call glfrustum(-fw, fw, -fh, fh, znear, zfar)
    end subroutine gl_perspective

    subroutine display(camera, textures)
        !! The display routine, called every frame.
        type(camera_type), intent(inout) :: camera
        integer,           intent(inout) :: textures(:)

        integer    :: i
        real, save :: angle = 0.0

        call glclear(ior(GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT)) ! Clear the screen and depth buffer.
        call glmatrixmode(GL_MODELVIEW)                             ! Alter model view matrix.
        call glloadidentity()                                       ! Reset current model view matrix.
        call glulookat(camera%eye%x, 0.0_r8, camera%eye%z, &
                       0.0_r8, 0.0_r8, 0.0_r8, &
                       0.0_r8, 1.0_r8, 0.0_r8)

        call glenable(GL_TEXTURE_2D)

        ! Render three textured cubes side by side with different textures.
        do i = -1, 1
            call glbindtexture(GL_TEXTURE_2D, textures(i + 2))

            call glpushmatrix()
                call gltranslatef(0.75 * i, 0.0, -1.25) ! Move cube in X and Z direction.
                call glrotatef(angle, 1.0, 0.0, 0.0)    ! Rotate cube in X.
                call glrotatef(angle, 0.0, 1.0, 0.0)    ! Rotate cube in Y.
                call cube(size=0.4)                     ! Render cube.
            call glpopmatrix()
        end do

        ! Increase rotation angle.
        angle = modulo(angle + 1.0, 360.0)

        call gldisable(GL_TEXTURE_2D)
    end subroutine display

    subroutine square()
        !! Renders a textured square.
        call glbegin(GL_QUADS)
            call glTexCoord2d(0._r8, 1._r8); call glVertex3f(-0.5, -0.5, 0.5)
            call glTexCoord2d(1._r8, 1._r8); call glVertex3f( 0.5, -0.5, 0.5)
            call glTexCoord2d(1._r8, 0._r8); call glVertex3f( 0.5,  0.5, 0.5)
            call glTexCoord2d(0._r8, 0._r8); call glVertex3f(-0.5,  0.5, 0.5)
        call glend()
    end subroutine square

    subroutine cube(size)
        !! Renders a textured cube out of six squares.
        real, intent(in) :: size

        call glpushmatrix() ! Save a copy of the current matrix.
        call glscalef(size, size, size)

        call square()       ! Front face.

        call glpushmatrix()
            call glrotatef(90.0, 0.0, 1.0, 0.0)
            call square()   ! Right face.
        call glpopmatrix()

        call glpushmatrix()
            call glrotatef(-90.0, 1.0, 0.0, 0.0)
            call square()   ! Top face.
        call glpopmatrix()

        call glpushmatrix()
            call glrotatef(180.0, 0.0, 1.0, 0.0)
            call square()   ! Back face.
        call glpopmatrix()

        call glpushmatrix()
            call glrotatef(-90.0, 0.0, 1.0, 0.0)
            call square()   ! Left face.
        call glpopmatrix()

        call glpushmatrix()
            call glrotatef(90.0, 1.0, 0.0, 0.0)
            call square()   ! Bottom face.
        call glpopmatrix()

        call glpopmatrix()  ! Restore matrix to its state before subroutine was called.
    end subroutine cube
end program main
