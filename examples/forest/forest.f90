! forest.f90
!
! Basic cellular automaton, based on the forest-fire model. For more
! information, see: https://rosettacode.org/wiki/Forest_fire
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module forest
    implicit none

    integer(kind=1), parameter, public :: TILE_NONE = 1
    integer(kind=1), parameter, public :: TILE_TREE = 2
    integer(kind=1), parameter, public :: TILE_FIRE = 3

    public :: forest_init
    public :: forest_next
contains
    subroutine forest_init(world, buffer, width, height, p)
        !! Initialises world and buffer arrays.
        integer(kind=1), allocatable, intent(inout) :: world(:, :)
        integer(kind=1), allocatable, intent(inout) :: buffer(:, :)
        integer,                      intent(in)    :: width
        integer,                      intent(in)    :: height
        real,                         intent(in)    :: p
        integer                                     :: x, y
        real                                        :: r(width, height)

        allocate (world(width, height))
        allocate (buffer(width, height))

        world  = TILE_NONE
        buffer = TILE_NONE

        call random_seed()
        call random_number(r)

        do concurrent (y = 1:height)
            do concurrent (x = 1:width)
                if (r(x, y) <= p) &
                    world(x, y) = TILE_TREE
            end do
        end do
    end subroutine forest_init

    subroutine forest_next(world, buffer, width, height, p, f)
        !! Next iteration of the cellular automaton.
        integer(kind=1), allocatable, intent(inout) :: world(:, :)
        integer(kind=1), allocatable, intent(inout) :: buffer(:, :)
        integer,                      intent(in)    :: width
        integer,                      intent(in)    :: height
        real,                         intent(in)    :: p
        real,                         intent(in)    :: f
        integer                                     :: i, j, nx, ny, x, y
        logical                                     :: has_fire
        real                                        :: r(width, height)

        call random_seed()
        call random_number(r)

        buffer = TILE_NONE

        do concurrent (y = 1:height)
            do concurrent (x = 1:width)
                buffer(x, y) = world(x, y)
                has_fire = .false.

                select case (world(x, y))
                    case (TILE_NONE)
                        if (r(x, y) <= p) &
                            buffer(x, y) = TILE_TREE

                    case (TILE_TREE)
                        loop: do j = -1, 1
                            do i = -1, 1
                                if (i == 0 .and. j == 0) cycle

                                nx = 1 + modulo(x + i, width - 1)
                                ny = 1 + modulo(y + j, height - 1)

                                if (world(nx, ny) == TILE_FIRE) then
                                    has_fire = .true.
                                    exit loop
                                end if
                            end do
                        end do loop

                        if (r(x, y) <= f .or. has_fire) &
                            buffer(x, y) = TILE_FIRE

                    case (TILE_FIRE)
                        buffer(x, y) = TILE_NONE
                end select
            end do
        end do

        world = buffer
    end subroutine forest_next
end module forest

program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_int8_t, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: forest
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 800
    integer, parameter :: SCREEN_HEIGHT = 800

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

    type(frame_buffer_type)      :: frame_buffer
    type(c_ptr)                  :: window
    type(c_ptr)                  :: renderer
    type(sdl_event)              :: event
    integer(kind=1), allocatable :: world(:, :)
    integer(kind=1), allocatable :: buffer(:, :)
    integer(kind=c_int32_t)      :: palette(3)
    integer                      :: rc

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
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, &
                                                   SDL_RENDERER_PRESENTVSYNC))

    ! Create frame buffer texture.
    call create_frame_buffer(renderer, window, frame_buffer, SCREEN_WIDTH, SCREEN_HEIGHT)

    ! Set-up the colour palette.
    palette(TILE_NONE) = sdl_map_rgb(frame_buffer%pixel_format,   0,   0,   0)
    palette(TILE_TREE) = sdl_map_rgb(frame_buffer%pixel_format,  46, 139,  87)
    palette(TILE_FIRE) = sdl_map_rgb(frame_buffer%pixel_format, 255,   0,   0)

    ! Initialise world and buffer.
    call forest_init(world, buffer, SCREEN_WIDTH, SCREEN_HEIGHT, 0.05)

    ! Clear screen.
    rc = sdl_set_render_draw_color(renderer, uint8(0), uint8(0), uint8(0), uint8(SDL_ALPHA_OPAQUE))
    rc = sdl_render_clear(renderer)

    ! Main loop.
    loop: do
        do while (sdl_poll_event(event) > 0)
            select case (event%type)
                case (SDL_QUITEVENT)
                    exit loop
            end select
        end do

        call forest_next(world, buffer, SCREEN_WIDTH, SCREEN_HEIGHT, 0.05, 0.00001)
        call render(frame_buffer, world, palette)
        rc = sdl_render_copy(renderer, &
                             frame_buffer%texture, &
                             frame_buffer%rect, &
                             frame_buffer%rect)
        call sdl_render_present(renderer)
        call sdl_delay(20)
    end do loop

    ! Quit gracefully.
    deallocate (buffer)
    deallocate (world)

    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
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

    subroutine render(frame_buffer, world, palette)
        !! Renders world to frame buffer texture.
        type(frame_buffer_type),      intent(inout) :: frame_buffer
        integer(kind=1), allocatable, intent(inout) :: world(:, :)
        integer(kind=c_int32_t),      intent(inout) :: palette(*)
        integer                                     :: offset, rc
        integer                                     :: width, height
        integer                                     :: x, y

        width = size(world(:, 1))
        height = size(world(1, :))

        rc = sdl_lock_texture(frame_buffer%texture, &
                              frame_buffer%rect, &
                              frame_buffer%pixels_ptr, &
                              frame_buffer%pitch)

        do concurrent (y = 1:height)
            do concurrent (x = 1:width)
                offset = (y * width) + x
                frame_buffer%pixels(offset) = palette(world(x, y))
            end do
        end do

        call sdl_unlock_texture(frame_buffer%texture)
    end subroutine render
end program main
