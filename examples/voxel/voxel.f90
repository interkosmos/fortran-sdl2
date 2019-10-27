! voxel.f90
!
! Slow voxel space engine. Use keys W, A, S, D for camera movement.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stderr => error_unit, stdout => output_unit
    use :: sdl2
    implicit none

    ! RGB type.
    type :: rgb_type
        integer(kind=2) :: r = 0
        integer(kind=2) :: g = 0
        integer(kind=2) :: b = 0
    end type rgb_type

    ! 2D point type.
    type :: point_type
        real :: x = 0.
        real :: y = 0.
    end type point_type

    ! Camera type.
    type :: camera_type
        real :: x        = 300. !! X position.
        real :: y        = 300. !! Y position.
        real :: height   = 200. !! Z position.
        real :: angle    =   0. !! Viewing direction.
        real :: horizon  =  80. !! Vertical position of horizon.
        real :: distance = 500. !! Draw distance.
    end type camera_type

    character(len=*), parameter :: COLOR_MAP_FILE  = 'examples/voxel/top.bmp'
    character(len=*), parameter :: HEIGHT_MAP_FILE = 'examples/voxel/dem.bmp'
    integer,          parameter :: SCREEN_WIDTH    = 640
    integer,          parameter :: SCREEN_HEIGHT   = 480
    integer,          parameter :: MAP_WIDTH       = 1024
    integer,          parameter :: MAP_HEIGHT      = 1024

    character(len=30)           :: window_title
    integer                     :: fps, t1, rc
    integer(kind=1), pointer    :: keys(:) => null()
    type(c_ptr)                 :: renderer
    type(c_ptr)                 :: window
    type(camera_type)           :: camera
    type(rgb_type)              :: black
    type(rgb_type)              :: blue
    type(rgb_type), allocatable :: color_map(:, :)
    type(rgb_type), allocatable :: height_map(:, :)
    type(sdl_event)             :: event

    ! Set colours.
    black%r = 0; black%g =   0; black%b =   0
    blue%r  = 0; blue%g  = 150; blue%b  = 200

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Set hints.
    rc = sdl_set_hint(SDL_HINT_FRAMEBUFFER_ACCELERATION, '1')
    rc = sdl_set_hint(SDL_HINT_RENDER_DRIVER,            'opengl')
    rc = sdl_set_hint(SDL_HINT_RENDER_SCALE_QUALITY,     '0')

    ! Create the SDL window.
    window = sdl_create_window('SDL2 Fortran' // c_null_char, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SCREEN_WIDTH, &
                               SCREEN_HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create colour and height map.
    call map_rgb(COLOR_MAP_FILE, color_map)
    call map_rgb(HEIGHT_MAP_FILE, height_map)

    ! Get renderer and window surface.
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, SDL_RENDERER_PRESENTVSYNC))

    ! Main loop.
    loop: do
        t1 = sdl_get_ticks()

        ! Event handling.
        do while (sdl_poll_event(event) > 0)
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit loop

                case (SDL_KEYDOWN)
                    keys(0:) => sdl_get_keyboard_state()

                    ! Quit on Escape.
                    if (keys(int(SDL_SCANCODE_ESCAPE, kind=1)) == 1) &
                        exit loop

                    if (keys(int(SDL_SCANCODE_A, kind=1)) == 1) &
                        call rotate_camera(.01)

                    if (keys(int(SDL_SCANCODE_D, kind=1)) == 1) &
                        call rotate_camera(-.01)

                    if (keys(int(SDL_SCANCODE_S, kind=1)) == 1) &
                        call move_camera(0., 1.)

                    if (keys(int(SDL_SCANCODE_W, kind=1)) == 1) &
                        call move_camera(0., -1.)
            end select
        end do

        ! Clear screen.
        rc = sdl_set_render_draw_color(renderer, blue%r, blue%g, blue%b, int(SDL_ALPHA_OPAQUE, kind=2))
        rc = sdl_render_clear(renderer)

        ! Render voxel space.
        call render(renderer, &
                    camera%x, &
                    camera%y, &
                    camera%angle, &
                    camera%height, &
                    camera%horizon, &
                    120, &
                    camera%distance, &
                    SCREEN_WIDTH, &
                    SCREEN_HEIGHT)

        ! Flush to screen.
        call sdl_render_present(renderer)

        ! Turn camera.

        ! Display frames per second.
        fps = calculate_fps(t1)
        write (window_title, '(a, i3, 2a)') 'SDL2 Fortran (', fps, ' FPS)', c_null_char
        call sdl_set_window_title(window, window_title)
    end do loop

    ! Quit gracefully.
    if (allocated(color_map)) &
        deallocate (color_map)

    if (allocated(height_map)) &
        deallocate (height_map)

    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
contains
    integer function calculate_fps(t1)
        !! Calculates current frames per seconds.
        use :: sdl2
        integer, intent(in) :: t1   !! First time value.
        integer             :: dt   !! Time delta.
        integer, save       :: fc   !! Frame counter.
        integer, save       :: ft   !! Frame time.
        integer, save       :: fps  !! Frames per second.

        dt = sdl_get_ticks() - t1
        fc = fc + 1
        ft = ft + dt

        if (ft >= 1000) then
            fps = fc
            fc  = 0
            ft  = 0
        end if

        calculate_fps = fps
    end function calculate_fps

    logical function file_exists(file_path)
        !! Returns whether the given file exists.
        character(len=*), intent(in) :: file_path

        inquire (file=file_path, exist=file_exists)
    end function file_exists

    type(rgb_type) function get_color(x, y)
        !! Returns colour of given coordinates in color map.
        real, intent(in) :: x
        real, intent(in) :: y
        integer          :: norm_x
        integer          :: norm_y

        ! Normalise and limit coordinates.
        norm_x = max(1, 1 + modulo(int(x), MAP_WIDTH - 1))
        norm_y = max(1, 1 + modulo(int(y), MAP_HEIGHT - 1))

        get_color = color_map(norm_y, norm_x)
    end function get_color

    integer function get_height(x, y)
        !! Returns height of given coordinates in height map.
        real, intent(in) :: x
        real, intent(in) :: y
        integer          :: norm_x
        integer          :: norm_y

        ! Normalise and limit coordinates.
        norm_x = max(1, 1 + modulo(int(x), MAP_WIDTH - 1))
        norm_y = max(1, 1 + modulo(int(y), MAP_HEIGHT - 1))

        get_height = height_map(norm_y, norm_x)%r
    end function get_height

    subroutine map_rgb(file_path, map)
        !! Reads an image file from the given file path and stores the RGB
        !! values of all pixels in a 2D array of derived type `rgb_type`.
        use, intrinsic :: iso_c_binding, only: c_int8_t, c_int32_t, c_null_char
        character(len=*),            intent(in)    :: file_path
        type(rgb_type), allocatable, intent(inout) :: map(:, :)
        type(sdl_surface),           pointer       :: image
        integer(kind=c_int8_t),      pointer       :: pixels(:)
        integer(kind=c_int32_t)                    :: pixel
        integer                                    :: rc
        integer                                    :: x, y

        if (.not. file_exists(file_path)) then
            write (stderr, '(3a)') 'Error: File "', file_path, '" not found'
            return
        end if

        ! Load image file.
        image => sdl_load_bmp(file_path // c_null_char)

        ! Convert C pointer to Fortran pointer.
        call c_f_pointer(image%pixels, pixels, shape=[image%pitch * image%h])

        ! Allocate color map.
        if (allocated(map)) &
            deallocate (map)

        allocate (map(image%h, image%w), stat=rc)

        ! Get RGB value of each pixel.
        do y = 1, image%h
            do x = 1, image%w
                ! Doing some transfer magic here to handle unsigned values.
                pixel = ichar(transfer(pixels(y * image%pitch + x), 'a'))
                call sdl_get_rgb(pixel, image%format, map(y, x)%r, map(y, x)%g, map(y, x)%b)
            end do
        end do

        ! Clean up.
        call sdl_free_surface(image)
    end subroutine map_rgb

    subroutine move_camera(x, y)
        !! Moves camera in X and Y direction.
        real, intent(in) :: x
        real, intent(in) :: y

        camera%x = modulo(camera%x + x, real(MAP_WIDTH))
        camera%y = modulo(camera%y + y, real(MAP_WIDTH))
    end subroutine move_camera

    subroutine render(renderer, camera_x, camera_y, phi, height, horizon, scale_height, distance, &
            screen_width, screen_height)
        !! Renders voxel space to screen. Algorithm is taken from:
        !!     https://github.com/s-macke/VoxelSpace
        type(c_ptr), intent(in) :: renderer
        real,        intent(in) :: camera_x
        real,        intent(in) :: camera_y
        real,        intent(in) :: phi
        real,        intent(in) :: height
        real,        intent(in) :: horizon
        integer,     intent(in) :: scale_height
        real,        intent(in) :: distance
        integer,     intent(in) :: screen_width
        integer,     intent(in) :: screen_height
        integer                 :: rc
        integer                 :: x
        real                    :: cos_phi, sin_phi
        real                    :: dx, dy, dz
        real                    :: height_on_screen
        real                    :: y_buffer(screen_width)
        real                    :: z
        type(point_type)        :: left, right
        type(rgb_type)          :: color

        sin_phi = sin(phi)
        cos_phi = cos(phi)

        y_buffer(0:) = screen_height

        dz = 1.
        z  = 1.

        do while (z < distance)
            ! Find line on map. This calculation corresponds to a field of view of 90°.
            left%x  = (-cos_phi * z - sin_phi * z) + camera_x
            left%y  = ( sin_phi * z - cos_phi * z) + camera_y
            right%x = ( cos_phi * z - sin_phi * z) + camera_x
            right%y = (-sin_phi * z - cos_phi * z) + camera_y

            ! Segment the line.
            dx = (right%x - left%x) / screen_width
            dy = (right%y - left%y) / screen_width

            ! Raster line and draw a vertical line for each segment.
            do x = 0, screen_width
                height_on_screen = (height - get_height(left%x, left%y)) / z * scale_height + horizon

                ! Only draw if visible.
                if (height_on_screen < y_buffer(x)) then
                    color = get_color(left%x, left%y)

                    rc = sdl_set_render_draw_color(renderer, color%r, color%g, color%b, int(SDL_ALPHA_OPAQUE, kind=2))
                    rc = sdl_render_draw_line(renderer, x, int(y_buffer(x)), x, int(height_on_screen))

                    y_buffer(x) = height_on_screen
                end if

                left%x = left%x + dx
                left%y = left%y + dy
            end do

            ! Increase step-size in Z direction.
            z  = z + dz
            dz = dz + .005
        end do
    end subroutine render

    subroutine rotate_camera(a)
        !! Rotates camera by given angle a [rad].
        real, intent(in) :: a

        camera%angle = camera%angle + a
    end subroutine rotate_camera
end program main
