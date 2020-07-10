! cyclic.f90
!
! Cyclic cellular automaton, creates trippy colour effects.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module cyclic
    implicit none
    public :: cyclic_init
    public :: cyclic_next
contains
    subroutine cyclic_init(world, buffer, width, height, nstates)
        !! Initialises world array.
        integer, allocatable, intent(inout) :: world(:, :)
        integer, allocatable, intent(inout) :: buffer(:, :)
        integer,              intent(in)    :: width
        integer,              intent(in)    :: height
        integer,              intent(in)    :: nstates
        integer                             :: x, y
        real                                :: r(width, height)

        allocate ( world(width, height))
        allocate (buffer(width, height))

        buffer = 0

        call random_seed()
        call random_number(r)

        do concurrent (y = 1:height)
            do concurrent (x = 1:width)
                world(x, y) = nint((nstates - 1) * r(x, y))
            end do
        end do
    end subroutine cyclic_init

    subroutine cyclic_next(world, buffer, width, height, nstates, threshold, range)
        !! Next iteration of the cellular automaton.
        integer, allocatable, intent(inout) :: world(:, :)
        integer, allocatable, intent(inout) :: buffer(:, :)
        integer,              intent(in)    :: width
        integer,              intent(in)    :: height
        integer,              intent(in)    :: nstates
        integer,              intent(in)    :: threshold
        integer,              intent(in)    :: range
        integer                             :: cell, n
        integer                             :: i, j, nx, ny, x, y

        do concurrent (y = 1:height)
            do concurrent (x = 1:width)
                cell = world(x, y)
                n    = 0

                do concurrent (j = -range:range)
                    do concurrent (i = -range:range)
                        if (i == 0 .and. j == 0) cycle

                        nx = 1 + modulo(x + i - 1, width)
                        ny = 1 + modulo(y + j - 1, height)

                        if (cell == modulo(world(nx, ny) - 1, nstates)) n = n + 1
                    end do
                end do

                if (n >= threshold) then
                    buffer(x, y) = modulo(cell + 1, nstates)
                else
                    buffer(x, y) = cell
                end if
            end do
        end do

        world = buffer
    end subroutine cyclic_next
end module cyclic

program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_int8_t, c_null_char, c_null_ptr, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: cyclic
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 500
    integer, parameter :: SCREEN_HEIGHT = 500
    integer, parameter :: NSTATES       = 16
    integer, parameter :: THRESHOLD     = 1
    integer, parameter :: RANGE         = 1

    type :: frame_buffer_type
        integer                          :: access
        integer                          :: format
        integer                          :: pitch
        integer(kind=c_int32_t), pointer :: pixels(:)
        type(c_ptr)                      :: pixels_ptr
        type(c_ptr)                      :: texture
        type(sdl_pixel_format),  pointer :: pixel_format
        type(sdl_rect)                   :: rect
    end type frame_buffer_type

    type(c_ptr)              :: cursor
    type(c_ptr)              :: window
    type(c_ptr)              :: renderer
    type(frame_buffer_type)  :: frame_buffer
    type(sdl_event)          :: event
    integer(kind=1), pointer :: keys(:) => null()
    integer, allocatable     :: world(:, :)
    integer, allocatable     :: buffer(:, :)
    integer(kind=c_int32_t)  :: palette(0:15)
    integer                  :: rc

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

    ! Set mouse cursor.
    cursor = sdl_create_system_cursor(SDL_SYSTEM_CURSOR_WAIT)
    call sdl_set_cursor(cursor)

    ! Create renderer.
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, &
                                                   SDL_RENDERER_PRESENTVSYNC))

    ! Create frame buffer texture.
    call create_frame_buffer(renderer, window, frame_buffer, SCREEN_WIDTH, SCREEN_HEIGHT)

    ! Set-up the colour palette (Jet palette).
    palette( 0) = sdl_map_rgb(frame_buffer%pixel_format,   0,   0, 191)
    palette( 1) = sdl_map_rgb(frame_buffer%pixel_format,   0,   0, 255)
    palette( 2) = sdl_map_rgb(frame_buffer%pixel_format,   0,  63, 255)
    palette( 3) = sdl_map_rgb(frame_buffer%pixel_format,   0, 127, 255)
    palette( 4) = sdl_map_rgb(frame_buffer%pixel_format,   0, 191, 255)
    palette( 5) = sdl_map_rgb(frame_buffer%pixel_format,   0, 255, 255)
    palette( 6) = sdl_map_rgb(frame_buffer%pixel_format,  63, 255, 191)
    palette( 7) = sdl_map_rgb(frame_buffer%pixel_format, 127, 255, 127)
    palette( 8) = sdl_map_rgb(frame_buffer%pixel_format, 191, 255,  63)
    palette( 9) = sdl_map_rgb(frame_buffer%pixel_format, 255, 255,   0)
    palette(10) = sdl_map_rgb(frame_buffer%pixel_format, 255, 191,   0)
    palette(11) = sdl_map_rgb(frame_buffer%pixel_format, 255, 127,   0)
    palette(12) = sdl_map_rgb(frame_buffer%pixel_format, 255,  63,   0)
    palette(13) = sdl_map_rgb(frame_buffer%pixel_format, 255,   0,   0)
    palette(14) = sdl_map_rgb(frame_buffer%pixel_format, 191,   0,   0)
    palette(15) = sdl_map_rgb(frame_buffer%pixel_format, 127,   0,   0)

    ! Initialise world and buffer.
    call cyclic_init(world, buffer, SCREEN_WIDTH, SCREEN_HEIGHT, NSTATES)

    ! Clear screen.
    rc = sdl_set_render_draw_color(renderer, uint8(0), uint8(0), uint8(0), uint8(SDL_ALPHA_OPAQUE))
    rc = sdl_render_clear(renderer)

    ! Main loop.
    loop: do
        do while (sdl_poll_event(event) > 0)
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit loop

                case (SDL_KEYDOWN)
                    keys(0:) => sdl_get_keyboard_state()
                    if (keys(int(SDL_SCANCODE_ESCAPE, kind=1)) == 1) exit loop
            end select
        end do

        ! Run next iteration of cellular automaton.
        call cyclic_next(world, buffer, SCREEN_WIDTH, SCREEN_HEIGHT, NSTATES, THRESHOLD, RANGE)
        ! Render to frame buffer texture.
        call render(frame_buffer, world, SCREEN_WIDTH, SCREEN_HEIGHT, NSTATES, palette)
        ! Copy frame buffer texture to screen.
        rc = sdl_render_copy(renderer, frame_buffer%texture, frame_buffer%rect, frame_buffer%rect)
        call sdl_render_present(renderer)
    end do loop

    ! Quit gracefully.
    deallocate (buffer)
    deallocate (world)

    frame_buffer%pixels => null()

    call sdl_destroy_texture(frame_buffer%texture)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_free_cursor(cursor)
    call sdl_quit()
contains
    subroutine create_frame_buffer(renderer, window, frame_buffer, width, height)
        !! Creates frame buffer texture and fills pixel pointer array
        !! `frame_buffer%pixels`.
        type(c_ptr),             intent(in)  :: renderer
        type(c_ptr),             intent(in)  :: window
        type(frame_buffer_type), intent(out) :: frame_buffer
        integer,                 intent(in)  :: width
        integer,                 intent(in)  :: height

        ! Create frame buffer texture.
        frame_buffer%texture = sdl_create_texture(renderer, &
                                                  SDL_PIXELFORMAT_ARGB8888, &
                                                  SDL_TEXTUREACCESS_STREAMING, &
                                                  width, &
                                                  height)
        frame_buffer%rect = sdl_rect(0, 0, width, height)
        frame_buffer%format = sdl_get_window_pixel_format(window)
        frame_buffer%pixel_format => sdl_alloc_format(frame_buffer%format)

        ! Get pixel pointers of buffer texture.
        rc = sdl_lock_texture(frame_buffer%texture, &
                              frame_buffer%rect, &
                              frame_buffer%pixels_ptr, &
                              frame_buffer%pitch)
        call c_f_pointer(frame_buffer%pixels_ptr, &
                         frame_buffer%pixels, &
                         shape=[width * height])
        call sdl_unlock_texture(frame_buffer%texture)
    end subroutine create_frame_buffer

    subroutine render(frame_buffer, world, width, height, ncolors, palette)
        !! Renders world to frame buffer texture.
        type(frame_buffer_type), intent(inout) :: frame_buffer
        integer, allocatable,    intent(inout) :: world(:, :)
        integer,                 intent(in)    :: width
        integer,                 intent(in)    :: height
        integer,                 intent(in)    :: ncolors
        integer(kind=c_int32_t), intent(inout) :: palette(0:ncolors - 1)
        integer                                :: offset, rc
        integer                                :: x, y

        rc = sdl_lock_texture(frame_buffer%texture, &
                              frame_buffer%rect, &
                              frame_buffer%pixels_ptr, &
                              frame_buffer%pitch)

        do concurrent (y = 1:height)
            do concurrent (x = 1:width)
                offset = ((y - 1) * width) + x
                frame_buffer%pixels(offset) = palette(world(x, y))
            end do
        end do

        call sdl_unlock_texture(frame_buffer%texture)
    end subroutine render
end program main
