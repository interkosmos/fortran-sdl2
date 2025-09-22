! voxel.f90
!
! Voxel space engine that modifies the pixels of a frame buffer texture. Use
! arrow keys and Q, A for camera movement.
!
! Author:  Philipp Engel
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: i1 => int8, stderr => error_unit, stdout => output_unit
    use :: sdl2
    implicit none

    ! Colour and height map type.
    type :: map_type
        type(sdl_pixel_format), pointer :: pixel_format
        type(sdl_surface),      pointer :: image
        integer(c_int8_t),      pointer :: pixels(:)
    end type map_type

    ! Frame buffer type.
    type :: buffer_type
        integer                         :: access
        integer                         :: format
        integer                         :: pitch
        integer(c_int32_t),     pointer :: pixels(:)
        type(c_ptr)                     :: pixels_ptr
        type(c_ptr)                     :: texture
        type(sdl_pixel_format), pointer :: pixel_format
        type(sdl_rect)                  :: rect
    end type buffer_type

    ! Voxel type.
    type :: voxel_type
        integer            :: elevation
        integer(c_int32_t) :: color
    end type voxel_type

    ! 2D point type.
    type :: point_type
        real :: x
        real :: y
    end type point_type

    ! Camera type.
    type :: camera_type
        real :: x        =  10. !! X position.
        real :: y        =  40. !! Y position.
        real :: z        = 300. !! Z position.
        real :: angle    =   0. !! Viewing direction.
        real :: horizon  = 100. !! Vertical position of horizon.
        real :: distance = 900. !! Draw distance.
    end type camera_type

    character(*), parameter :: COLOR_MAP_FILE  = 'share/top.bmp'
    character(*), parameter :: HEIGHT_MAP_FILE = 'share/dem.bmp'
    integer,      parameter :: MAP_WIDTH       = 1024
    integer,      parameter :: MAP_HEIGHT      = 1024
    integer,      parameter :: SCREEN_WIDTH    = 800
    integer,      parameter :: SCREEN_HEIGHT   = 600

    character(30)                 :: window_title
    integer                       :: fps, t1, rc
    integer(i1), pointer          :: keys(:)
    logical                       :: is_running
    type(buffer_type)             :: buffer
    type(c_ptr)                   :: renderer
    type(c_ptr)                   :: window
    type(camera_type)             :: camera
    type(voxel_type), allocatable :: voxels(:, :)
    type(sdl_event)               :: event

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
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    rc = sdl_show_cursor(SDL_FALSE)

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, SDL_RENDERER_PRESENTVSYNC))

    ! Create frame buffer texture.
    call create_buffer(renderer, window, SCREEN_WIDTH, SCREEN_HEIGHT, buffer)

    ! Load colour and height map.
    allocate (voxels(MAP_WIDTH, MAP_HEIGHT))
    rc = read_voxels(COLOR_MAP_FILE, HEIGHT_MAP_FILE, MAP_WIDTH, MAP_HEIGHT, buffer%pixel_format, voxels)
    if (rc /= 0) stop
    is_running = .true.

    ! Main loop.
    do while (is_running)
        t1 = sdl_get_ticks()

        ! Event handling.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_QUITEVENT); is_running = .false.
            end select
        end if

        keys(0:) => sdl_get_keyboard_state()

        ! Quit on Escape.
        if (is_key(keys, SDL_SCANCODE_ESCAPE)) is_running = .false.

        ! Rotate left.
        if (is_key(keys, SDL_SCANCODE_LEFT)) call rotate_camera(camera, .01)

        ! Rotate right.
        if (is_key(keys, SDL_SCANCODE_RIGHT)) call rotate_camera(camera, -.01)

        ! Move backward.
        if (is_key(keys, SDL_SCANCODE_DOWN)) call move_camera(camera, 1., MAP_WIDTH, MAP_HEIGHT)

        ! Move forward.
        if (is_key(keys, SDL_SCANCODE_UP)) call move_camera(camera, -1., MAP_WIDTH, MAP_HEIGHT)

        ! Move up.
        if (is_key(keys, SDL_SCANCODE_Q)) call lift_camera(camera, 1., 250., 700.)

        ! Move down.
        if (is_key(keys, SDL_SCANCODE_A)) call lift_camera(camera, -1., 250., 700.)

        ! Render to texture and flush to screen.
        call render(buffer, camera, voxels, MAP_WIDTH, MAP_HEIGHT, 120, SCREEN_WIDTH, SCREEN_HEIGHT)
        rc = sdl_render_copy(renderer, buffer%texture, buffer%rect, buffer%rect)
        call sdl_render_present(renderer)

        ! Display frames per second.
        fps = calculate_fps(t1)
        write (window_title, '(a, i2, 2a)') 'Fortran SDL 2.0 (', fps, ' FPS)', c_null_char
        call sdl_set_window_title(window, window_title)
    end do

    ! Quit gracefully.
    rc = sdl_show_cursor(SDL_TRUE)
    call sdl_destroy_texture(buffer%texture)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
contains
    integer function calculate_fps(t1)
        !! Calculates current frames per seconds.
        integer, intent(in) :: t1   !! First time value.

        integer       :: dt      !! Time delta.
        integer, save :: fc  = 0 !! Frame counter.
        integer, save :: ft  = 0 !! Frame time.
        integer, save :: fps = 0 !! Frames per second.

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

    logical function file_exists(path)
        character(*), intent(in) :: path

        inquire (file=path, exist=file_exists)
    end function file_exists

    logical function is_key(keys, key)
        !! Returns whether a given key has been pressed.
        integer(i1), pointer, intent(in) :: keys(:) !! Keyboard map.
        integer,              intent(in) :: key     !! Key to check.

        is_key = (keys(int(key, i1)) == 1)
    end function

    integer function read_voxels(color_map_path, height_map_path, width, height, pixel_format, voxels)
        character(*),           intent(in)    :: color_map_path
        character(*),           intent(in)    :: height_map_path
        integer,                intent(in)    :: width
        integer,                intent(in)    :: height
        type(sdl_pixel_format), intent(in)    :: pixel_format
        type(voxel_type),       intent(inout) :: voxels(width, height)

        integer(i1)    :: r, g, b
        integer        :: pixel
        integer        :: i, x, y
        type(map_type) :: color_map, height_map

        read_voxels = 1

        if (.not. file_exists(color_map_path)) then
            write (stderr, '(3a)') 'Error: file "', color_map_path, '" not found'
            return
        end if

        if (.not. file_exists(height_map_path)) then
            write (stderr, '(3a)') 'Error: file "', height_map_path, '" not found'
            return
        end if

        ! Load colour map.
        color_map%image => sdl_load_bmp(color_map_path // c_null_char)
        call c_f_pointer(color_map%image%format, color_map%pixel_format)
        call c_f_pointer(color_map%image%pixels, color_map%pixels, shape=[color_map%image%pitch * color_map%image%h])

        ! Load height map.
        height_map%image => sdl_load_bmp(height_map_path // c_null_char)
        call c_f_pointer(height_map%image%format, height_map%pixel_format)
        call c_f_pointer(height_map%image%pixels, height_map%pixels, shape=[height_map%image%pitch * height_map%image%h])

        do y = 1, height
            do x = 1, width
                ! Get RGB colour values. Use some transfer magic to handle unsigned pixel values.
                i = (y - 1) * color_map%image%pitch + x
                pixel = ichar(transfer(color_map%pixels(i), 'a'))
                call sdl_get_rgb(pixel, color_map%pixel_format, r, g, b)
                voxels(x, y)%color = sdl_map_rgb(pixel_format, &
                                                 ichar(transfer(r, 'a')), &
                                                 ichar(transfer(g, 'a')), &
                                                 ichar(transfer(b, 'a')))

                ! Get height value.
                i = (y - 1) * height_map%image%pitch + x
                pixel = ichar(transfer(height_map%pixels(i), 'a'))
                call sdl_get_rgb(pixel, height_map%pixel_format, r, g, b)
                voxels(x, y)%elevation = ichar(transfer(r, 'a'))
            end do
        end do

        color_map%pixels  => null()
        height_map%pixels => null()

        call sdl_free_surface(color_map%image)
        call sdl_free_surface(height_map%image)

        read_voxels = 0
    end function read_voxels

    subroutine create_buffer(renderer, window, width, height, buffer)
        !! Creates buffer texture and fills pixel pointer array `buffer%pixels`.
        type(c_ptr),       intent(in)    :: renderer
        type(c_ptr),       intent(in)    :: window
        integer,           intent(in)    :: width
        integer,           intent(in)    :: height
        type(buffer_type), intent(inout) :: buffer

        ! Create buffer texture.
        buffer%texture = sdl_create_texture(renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, width, height)
        buffer%rect = sdl_rect(0, 0, width, height)
        buffer%format = sdl_get_window_pixel_format(window)
        buffer%pixel_format => sdl_alloc_format(buffer%format)

        ! Get pixel pointers of buffer texture.
        rc = sdl_lock_texture(buffer%texture, buffer%rect, buffer%pixels_ptr, buffer%pitch)
        call c_f_pointer(buffer%pixels_ptr, buffer%pixels, shape=[width * height])
        call sdl_unlock_texture(buffer%texture)
    end subroutine create_buffer

    subroutine lift_camera(camera, z, min_z, max_z)
        !! Moves camera in Z direction.
        type(camera_type), intent(inout) :: camera
        real,              intent(in)    :: z
        real,              intent(in)    :: min_z
        real,              intent(in)    :: max_z

        camera%z = max(min(camera%z + z, max_z), min_z)
    end subroutine lift_camera

    subroutine move_camera(camera, speed, width, height)
        !! Moves camera in X and Y direction.
        type(camera_type), intent(inout) :: camera
        real,              intent(in)    :: speed
        integer,           intent(in)    :: width
        integer,           intent(in)    :: height

        real :: x, y

        x = camera%x + sin(camera%angle) * speed
        y = camera%y + cos(camera%angle) * speed

        camera%x = 1 + modulo(x - 1, real(width))
        camera%y = 1 + modulo(y - 1, real(height))
    end subroutine move_camera

    subroutine render(buffer, camera, voxels, map_width, map_height, scale_height, screen_width, screen_height)
        !! Renders voxel space to screen. Algorithm is taken from:
        !!     https://github.com/s-macke/VoxelSpace
        type(buffer_type), intent(inout) :: buffer
        type(camera_type), intent(inout) :: camera
        integer,           intent(in)    :: map_width
        integer,           intent(in)    :: map_height
        type(voxel_type),  intent(inout) :: voxels(map_width, map_height)
        integer,           intent(in)    :: scale_height
        integer,           intent(in)    :: screen_width
        integer,           intent(in)    :: screen_height

        integer          :: line_y
        integer          :: offset
        integer          :: rc
        integer          :: nx, ny, x
        real             :: cos_phi, sin_phi
        real             :: dx, dy, dz
        real             :: height_on_screen
        real             :: y_buffer(0:screen_width - 1)
        real             :: z
        type(point_type) :: left, right

        sin_phi = sin(camera%angle)
        cos_phi = cos(camera%angle)

        y_buffer(0:) = screen_height

        dz = 1.
        z  = 30.

        rc = sdl_lock_texture(buffer%texture, buffer%rect, buffer%pixels_ptr, buffer%pitch)

        ! Fill frame buffer in light blue.
        buffer%pixels(:) = sdl_map_rgb(buffer%pixel_format, 0, 150, 200)

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
            do concurrent (x = 0:screen_width - 1)
                nx = 1 + modulo(int(left%x) - 1, map_width)
                ny = 1 + modulo(int(left%y) - 1, map_height)

                height_on_screen = (camera%z - voxels(nx, ny)%elevation) / z * scale_height + camera%horizon

                ! Only draw if visible.
                if (height_on_screen < y_buffer(x)) then
                    ! Draw vertical line by setting the pixels of the frame buffer texture.
                    do concurrent (line_y = int(height_on_screen):int(y_buffer(x)))
                        offset = ((line_y - 1) * screen_width) + x
                        buffer%pixels(offset) = voxels(nx, ny)%color
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

    subroutine rotate_camera(camera, a)
        !! Rotates camera by given angle `a` [rad].
        type(camera_type), intent(inout) :: camera
        real,              intent(in)    :: a

        camera%angle = camera%angle + a
    end subroutine rotate_camera
end program main
