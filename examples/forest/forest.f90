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

    public :: forest_has_fire
    public :: forest_init
    public :: forest_next
contains
    function forest_has_fire(world, x, y)
        integer(kind=1), allocatable, intent(inout) :: world(:, :)
        integer,                      intent(in)    :: x
        integer,                      intent(in)    :: y
        logical                                     :: forest_has_fire
        integer                                     :: i, j
        integer                                     :: nx, ny
        integer                                     :: w, h

        forest_has_fire = .false.

        w = size(world(:, 1))
        h = size(world(1, :))

        loop: do j = -1, 1
            do i = -1, 1
                if (i == 0 .and. j == 0) cycle

                nx = mod(x + i, w)
                ny = mod(y + j, h)

                if (world(nx, ny) == TILE_FIRE) then
                    forest_has_fire = .true.
                    exit loop
                end if
            end do
        end do loop
    end function forest_has_fire

    subroutine forest_init(world, p)
        integer(kind=1), allocatable, intent(inout) :: world(:, :)
        real,                         intent(in)    :: p
        integer                                     :: w, h
        integer                                     :: x, y
        real                                        :: r

        call random_seed()

        w = size(world(:, 1))
        h = size(world(1, :))

        world = TILE_NONE

        do y = 1, h
            do x = 1, w
                call random_number(r)
                if (r <= p) &
                    world(x, y) = TILE_TREE
            end do
        end do
    end subroutine forest_init

    subroutine forest_next(world, buffer, p, f)
        integer(kind=1), allocatable, intent(inout) :: world(:, :)
        integer(kind=1), allocatable, intent(inout) :: buffer(:, :)
        real,                         intent(in)    :: p
        real,                         intent(in)    :: f
        integer                                     :: x, y
        integer                                     :: w, h
        real                                        :: r

        w = size(world(:, 1))
        h = size(world(1, :))

        call random_seed()

        buffer = TILE_NONE

        do y = 1, h
            do x = 1, w
                buffer(x, y) = world(x, y)

                call random_number(r)

                select case (world(x, y))
                    case (TILE_NONE)
                        if (r <= p) &
                            buffer(x, y) = TILE_TREE

                    case (TILE_TREE)
                        if (r <= f .or. forest_has_fire(world, x, y)) &
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

    integer, parameter :: SCREEN_WIDTH  = 600
    integer, parameter :: SCREEN_HEIGHT = 600

    type(c_ptr)                  :: window
    type(c_ptr)                  :: renderer
    type(sdl_event)              :: event
    type(sdl_color)              :: palette(3)
    integer(kind=1), allocatable :: world(:, :)
    integer(kind=1), allocatable :: buffer(:, :)
    integer                      :: rc

    ! Set-up the colour palette.
    palette(TILE_NONE) = sdl_color(uint8(  0), uint8(  0), uint8(  0), uint8(SDL_ALPHA_OPAQUE))
    palette(TILE_TREE) = sdl_color(uint8( 46), uint8(139), uint8( 87), uint8(SDL_ALPHA_OPAQUE))
    palette(TILE_FIRE) = sdl_color(uint8(255), uint8(  0), uint8(  0), uint8(SDL_ALPHA_OPAQUE))

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
    renderer = sdl_create_renderer(window, -1, 0)

    ! Initialise world.
    allocate (world(SCREEN_WIDTH, SCREEN_HEIGHT))
    allocate (buffer(SCREEN_WIDTH, SCREEN_HEIGHT))

    call forest_init(world, 0.05)

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

        call forest_next(world, buffer, 0.05, 0.005)
        call render(renderer, world, palette)
        call sdl_render_present(renderer)
        call sdl_delay(50)
    end do loop

    ! Quit gracefully.
    deallocate (buffer)
    deallocate (world)

    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
contains
    subroutine render(renderer, world, palette)
        type(c_ptr),                  intent(in)    :: renderer
        integer(kind=1), allocatable, intent(inout) :: world(:, :)
        type(sdl_color), target,      intent(inout) :: palette(*)
        integer                                     :: rc
        integer                                     :: w, h
        integer                                     :: x, y
        type(sdl_color), pointer                    :: color

        w = size(world(:, 1))
        h = size(world(1, :))

        do y = 1, h
            do x = 1, w
                color => palette(world(x, y))
                rc = sdl_set_render_draw_color(renderer, color%r, color%g, color%b, color%a)
                rc = sdl_render_draw_point(renderer, x, y)
            end do
        end do
    end subroutine render
end program main
