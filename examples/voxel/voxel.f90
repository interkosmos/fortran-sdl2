! voxel.f90
!
! Slow voxel space engine that modifies pixels of a frame buffer texture.
! Use arrow keys for camera movement.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_int8_t, c_int32_t, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stderr => error_unit, stdout => output_unit
    use :: sdl2
    implicit none

    ! Colour and height map type.
    type :: map_type
        type(sdl_pixel_format), pointer :: pixel_format
        type(sdl_surface),      pointer :: image
        integer(kind=c_int8_t), pointer :: pixels(:)
    end type map_type

    ! Frame buffer type.
    type :: buffer_type
        integer                          :: access
        integer                          :: format
        integer                          :: pitch
        integer(kind=c_int32_t), pointer :: pixels(:)
        type(c_ptr)                      :: pixels_ptr
        type(c_ptr)                      :: texture
        type(sdl_pixel_format),  pointer :: pixel_format
        type(sdl_rect)                   :: rect
    end type buffer_type

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
        real :: x        = 100. !! X position.
        real :: y        = 400. !! Y position.
        real :: height   = 250. !! Z position.
        real :: angle    =   0. !! Viewing direction.
        real :: horizon  =  70. !! Vertical position of horizon.
        real :: distance = 500. !! Draw distance.
    end type camera_type

    character(len=*), parameter :: COLOR_MAP_FILE  = 'examples/voxel/top.bmp'
    character(len=*), parameter :: HEIGHT_MAP_FILE = 'examples/voxel/dem.bmp'
    integer,          parameter :: MAP_WIDTH       = 1024
    integer,          parameter :: MAP_HEIGHT      = 1024
    integer,          parameter :: SCREEN_WIDTH    = 640
    integer,          parameter :: SCREEN_HEIGHT   = 400

    character(len=30)        :: window_title
    integer                  :: fps, t1, rc
    integer(kind=1), pointer :: keys(:)            => null()
    logical                  :: has_moved          = .true.
    type(buffer_type)        :: buffer
    type(c_ptr)              :: renderer
    type(c_ptr)              :: window
    type(camera_type)        :: camera
    type(map_type)           :: color_map
    type(map_type)           :: height_map
    type(sdl_event)          :: event

    ! Initialise SDL.
    rc = sdl_init(SDL_INIT_VIDEO)

    if (rc < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

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

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, &
                                                   SDL_RENDERER_PRESENTVSYNC)) 
    ! Create frame buffer texture.
    buffer%texture = sdl_create_texture(renderer, &
                                        SDL_PIXELFORMAT_ARGB8888, &
                                        SDL_TEXTUREACCESS_STREAMING, &
                                        SCREEN_WIDTH, &
                                        SCREEN_HEIGHT)

    ! Set frame buffer rectangle.
    buffer%rect%x = 0;            buffer%rect%y = 0
    buffer%rect%w = SCREEN_WIDTH; buffer%rect%h = SCREEN_HEIGHT

    ! Set frame buffer pixel format.
    buffer%format = sdl_get_window_pixel_format(window)
    buffer%pixel_format => sdl_alloc_format(buffer%format)

    ! Load colour map and height map.
    color_map%image  => sdl_load_bmp(COLOR_MAP_FILE // c_null_char)
    height_map%image => sdl_load_bmp(HEIGHT_MAP_FILE // c_null_char)

    ! Get SDL_PixelFormat of colour map and height map.
    call c_f_pointer(color_map%image%format, color_map%pixel_format)
    call c_f_pointer(height_map%image%format, height_map%pixel_format)

    ! Convert C pointer to Fortran pointer array.
    call c_f_pointer(color_map%image%pixels, &
                     color_map%pixels, &
                     shape=[color_map%image%pitch * color_map%image%h])
    call c_f_pointer(height_map%image%pixels, &
                     height_map%pixels, &
                     shape=[height_map%image%pitch * height_map%image%h])

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
                    if (is_key(keys, SDL_SCANCODE_ESCAPE)) &
                        exit loop

                    ! Move left.
                    if (is_key(keys, SDL_SCANCODE_LEFT)) then
                        call rotate_camera(.01)
                        has_moved = .true.
                    end if

                    ! Move right.
                    if (is_key(keys, SDL_SCANCODE_RIGHT)) then
                        call rotate_camera(-.01)
                        has_moved = .true.
                    end if

                    ! Move down.
                    if (is_key(keys, SDL_SCANCODE_DOWN)) then
                        call move_camera(0., 1.)
                        has_moved = .true.
                    end if

                    ! Move up.
                    if (is_key(keys, SDL_SCANCODE_UP)) then
                        call move_camera(0., -1.)
                        has_moved = .true.
                    end if
            end select
        end do

        if (has_moved) then
            ! Only render if camera has moved.
            call render(buffer, camera, 120, SCREEN_WIDTH, SCREEN_HEIGHT)
            rc = sdl_render_copy(renderer, buffer%texture, buffer%rect, buffer%rect)
            has_moved = .false.
        end if

        ! Flush to screen.
        call sdl_render_present(renderer)

        ! Display frames per second.
        fps = calculate_fps(t1)
        write (window_title, '(a, i2, 2a)') 'SDL2 Fortran (', fps, ' FPS)', c_null_char
        call sdl_set_window_title(window, window_title)
    end do loop

    ! Quit gracefully.
    buffer%pixels     => null()
    color_map%pixels  => null()
    height_map%pixels => null()

    call sdl_free_format(buffer%pixel_format)
    call sdl_destroy_texture(buffer%texture)

    call sdl_free_surface(color_map%image)
    call sdl_free_surface(height_map%image)

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

    logical function is_key(keys, key)
        !! Returns whether a given key has been pressed.
        integer(kind=1), pointer, intent(in) :: keys(:) !! Keyboard map.
        integer,                  intent(in) :: key     !! Key to check.

        if (keys(int(key, kind=1)) == 1) then
            is_key = .true.
        else
            is_key = .false.
        end if
    end function

    type(rgb_type) function get_color(x, y)
        !! Returns colour of given coordinates in color map.
        real, intent(in) :: x
        real, intent(in) :: y
        integer          :: norm_x
        integer          :: norm_y
        integer          :: pixel

        ! Normalise coordinates.
        norm_x = 1 + modulo(int(x), MAP_WIDTH - 1)
        norm_y = 1 + modulo(int(y), MAP_HEIGHT - 1)

        ! Return colour as RGB. Use some transfer magic to handle unsigned pixel values.
        pixel = ichar(transfer(color_map%pixels(norm_y * color_map%image%pitch + norm_x), 'a'))
        call sdl_get_rgb(pixel, color_map%pixel_format, get_color%r, get_color%g, get_color%b)
    end function get_color

    integer function get_height(x, y)
        !! Returns height of given coordinates in height map.
        real, intent(in) :: x
        real, intent(in) :: y
        integer          :: norm_x
        integer          :: norm_y
        integer(kind=2)  :: r, g, b
        integer          :: pixel

        ! Normalise coordinates.
        norm_x = 1 + modulo(int(x), MAP_WIDTH - 1)
        norm_y = 1 + modulo(int(y), MAP_HEIGHT - 1)

        ! Return height. Use some transfer magic to handle unsigned pixel values.
        pixel = ichar(transfer(height_map%pixels(norm_y * height_map%image%pitch + norm_x), 'a'))
        call sdl_get_rgb(pixel, height_map%pixel_format, r, g, b)

        get_height = r
    end function get_height

    subroutine move_camera(x, y)
        !! Moves camera in X and Y direction.
        real, intent(in) :: x
        real, intent(in) :: y

        camera%x = modulo(camera%x + x, real(MAP_WIDTH))
        camera%y = modulo(camera%y + y, real(MAP_WIDTH))
    end subroutine move_camera

    subroutine render(buffer, camera, scale_height, screen_width, screen_height)
        !! Renders voxel space to screen. Algorithm is taken from:
        !!     https://github.com/s-macke/VoxelSpace
        type(buffer_type), intent(inout) :: buffer
        type(camera_type), intent(in)    :: camera
        integer,           intent(in)    :: scale_height
        integer,           intent(in)    :: screen_width
        integer,           intent(in)    :: screen_height
        integer                          :: i
        integer                          :: offset
        integer                          :: rc
        integer                          :: x, y
        real                             :: cos_phi, sin_phi
        real                             :: dx, dy, dz
        real                             :: height_on_screen
        real                             :: y_buffer(screen_width)
        real                             :: z
        type(point_type)                 :: left, right
        type(rgb_type)                   :: color

        sin_phi = sin(camera%angle)
        cos_phi = cos(camera%angle)

        y_buffer(0:) = screen_height

        dz = 1.
        z  = 30.

        ! Lock frame buffer texture.
        rc = sdl_lock_texture(buffer%texture, buffer%rect, buffer%pixels_ptr, buffer%pitch)

        ! Convert C pointer to Fortran pointer.
        call c_f_pointer(buffer%pixels_ptr, buffer%pixels, shape=[SCREEN_WIDTH * SCREEN_HEIGHT])

        ! Fill frame buffer.
        do y = 1, screen_height
            do x = 1, screen_width
                offset = (y * screen_width) + x
                buffer%pixels(offset) = sdl_map_rgb(buffer%pixel_format, 0, 150, 200)
            end do
        end do

        do while (z < camera%distance)
            ! Find line on map. This calculation corresponds to a field of view of 90°.
            left%x  = (-cos_phi * z - sin_phi * z) + camera%x
            left%y  = ( sin_phi * z - cos_phi * z) + camera%y
            right%x = ( cos_phi * z - sin_phi * z) + camera%x
            right%y = (-sin_phi * z - cos_phi * z) + camera%y

            ! Segment the line.
            dx = (right%x - left%x) / screen_width
            dy = (right%y - left%y) / screen_width

            ! Raster line and draw a vertical line for each segment.
            do x = 0, screen_width
                height_on_screen = (camera%height - get_height(left%x, left%y)) / z * scale_height + camera%horizon

                ! Only draw if visible.
                if (height_on_screen < y_buffer(x)) then
                    color = get_color(left%x, left%y)

                    ! Draw vertical line.
                    do i = int(height_on_screen), int(y_buffer(x))
                        offset = (i * SCREEN_WIDTH) + x
                        buffer%pixels(offset) = sdl_map_rgb(buffer%pixel_format, &
                                                            int(color%r, kind=4), &
                                                            int(color%g, kind=4), &
                                                            int(color%b, kind=4))
                    end do

                    y_buffer(x) = height_on_screen
                end if

                left%x = left%x + dx
                left%y = left%y + dy
            end do

            ! Increase step-size in Z direction.
            z  = z + dz
            dz = dz + .01
        end do

        call sdl_unlock_texture(buffer%texture)
    end subroutine render

    subroutine rotate_camera(a)
        !! Rotates camera by given angle a [rad].
        real, intent(in) :: a

        camera%angle = camera%angle + a
    end subroutine rotate_camera
end program main
