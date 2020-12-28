! logo.f90
!
! Demo that lets you fly through a field of Fortran logos.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module logo
    implicit none
    private

    type, public :: point_type
        integer :: x, y
    end type point_type

    type, public :: logo_type
        real    :: x, y, z
        integer :: color
    end type logo_type

    public :: logo_init
    public :: logo_move
    public :: logo_project
contains
    subroutine logo_init(logos, width, height, ncolors, max_depth)
        !! Initialises logos to given viewport width and height, with
        !! respect to maximum depth in Z.
        type(logo_type), intent(inout) :: logos(:)
        integer,         intent(in)    :: width
        integer,         intent(in)    :: height
        integer,         intent(in)    :: ncolors
        real,            intent(in)    :: max_depth
        integer                        :: i
        real                           :: r(3)

        do i = 1, size(logos)
            call random_number(r)
            logos(i) = logo_type(x     = (width / 2) - (r(1) * width), &
                                 y     = (height / 2) - (r(2) * height), &
                                 z     = max_depth - (i * (max_depth / size(logos))), &
                                 color = 1 + int(r(3) * ncolors))
        end do
    end subroutine logo_init

    subroutine logo_move(logos, width, height, ncolors, max_depth, dz)
        !! Moves logos in camera direction by `dz`. Logos passing the camera
        !! will be reset to a random X, Y position, and Z set to `max_depth`.
        type(logo_type), intent(inout) :: logos(:)
        integer,         intent(in)    :: width
        integer,         intent(in)    :: ncolors
        integer,         intent(in)    :: height
        real,            intent(in)    :: max_depth
        real,            intent(in)    :: dz
        integer                        :: i
        real                           :: r(3)

        do i = 1, size(logos)
            logos(i)%z = logos(i)%z - dz

            if (logos(i)%z < 0.0) then
                call random_number(r)
                logos(i) = logo_type(x     = (width / 2) - (r(1) * width), &
                                     y     = (height / 2) - (r(2) * height), &
                                     z     = max_depth, &
                                     color = 1 + int(r(3) * ncolors))
            end if
        end do
    end subroutine logo_move

    subroutine logo_project(logos, width, height, points)
        !! Projects logo coordinates from 3D into 2D.
        type(logo_type),  intent(inout) :: logos(:)
        integer,          intent(in)    :: width
        integer,          intent(in)    :: height
        type(point_type), intent(inout) :: points(:)
        integer                         :: i
        real                            :: k

        do i = 1, size(logos)
            k = 128.0 / logos(i)%z
            points(i)%x = int(logos(i)%x * k + (width / 2))
            points(i)%y = int(logos(i)%y * k + (height / 2))
        end do
    end subroutine logo_project
end module logo

program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    use :: sdl2_image
    use :: logo
    implicit none

    type :: color_type
        integer(kind=2) :: r
        integer(kind=2) :: g
        integer(kind=2) :: b
    end type color_type

    type :: texture_type
        integer(kind=c_int32_t) :: format
        integer                 :: access
        integer                 :: width
        integer                 :: height
        type(c_ptr)             :: ptr
        type(sdl_rect)          :: rect
    end type texture_type

    character(len=*), parameter :: FILE_NAME     = 'logo.png'
    integer,          parameter :: NLOGOS        = 20
    integer,          parameter :: SCREEN_WIDTH  = 1024
    integer,          parameter :: SCREEN_HEIGHT = 768
    real,             parameter :: DZ            = 2.0
    real,             parameter :: MAX_DEPTH     = 800.0

    integer                  :: rc
    type(c_ptr)              :: renderer
    type(c_ptr)              :: window
    type(color_type)         :: colors(7)
    type(sdl_event)          :: event
    type(texture_type)       :: texture
    integer(kind=1), pointer :: keys(:) => null()

    type(logo_type)  :: logos(NLOGOS)
    type(point_type) :: points(NLOGOS)

    ! Initialise PRNG.
    call random_seed()

    ! Fill colour table.
    colors(1) = color_type(255,   0,   0)
    colors(2) = color_type(255,   0, 255)
    colors(3) = color_type(255, 255,   0)
    colors(4) = color_type(  0, 255,   0)
    colors(5) = color_type(  0,   0, 255)
    colors(6) = color_type(  0, 255, 255)
    colors(7) = color_type(255, 255, 255)

    ! Initialise SDL and SDL2_image.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    if (img_init(IMG_INIT_PNG) < 0) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('Fortran SDL 2.0' // c_null_char, &
                               0, 0, &
                               SCREEN_WIDTH, SCREEN_HEIGHT, &
                               ior(SDL_WINDOW_BORDERLESS, SDL_WINDOW_SHOWN))

    if (.not. c_associated(window)) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Initialise the logo.
    call logo_init(logos     = logos, &
                   width     = SCREEN_WIDTH, &
                   height    = SCREEN_HEIGHT, &
                   ncolors   = size(colors), &
                   max_depth = MAX_DEPTH)

    ! Create renderer with hardware acceleration and VSync.
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, &
                                                   SDL_RENDERER_PRESENTVSYNC))

    if (.not. c_associated(renderer)) then
        write (stderr, '(2a)') 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Load texture from file.
    rc = load_texture(renderer, FILE_NAME, texture)

    if (rc < 0) then
        write (stderr, '(2a)')  'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Hide mouse cursor.
    rc = sdl_show_cursor(SDL_FALSE)

    loop: do
        ! Poll event.
        if (sdl_poll_event(event) > 0) then
            select case (event%type)
                case (SDL_KEYDOWN)
                    keys(0:) => sdl_get_keyboard_state()

                    if (keys(SDL_SCANCODE_ESCAPE) == 1) &
                        exit loop

                case (SDL_QUITEVENT)
                    exit loop
            end select
        end if

        call logo_move(logos, SCREEN_WIDTH, SCREEN_HEIGHT, size(colors), MAX_DEPTH, DZ)
        call logo_project(logos, SCREEN_WIDTH, SCREEN_HEIGHT, points)

        rc = sdl_render_clear(renderer)
        call render(renderer, logos, points, texture, colors, max_depth)
        call sdl_render_present(renderer)
    end do loop

    ! Show mouse cursor.
    rc = sdl_show_cursor(SDL_TRUE)

    ! Quit gracefully.
    call sdl_destroy_texture(texture%ptr)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)

    call img_quit()
    call sdl_quit()
contains
    function load_texture(renderer, file_name, texture) result(rc)
        !! Loads texture from file.
        type(c_ptr),        intent(in)  :: renderer
        character(len=*),   intent(in)  :: file_name
        type(texture_type), intent(out) :: texture
        integer                         :: rc

        rc = -1

        texture%ptr = img_load_texture(renderer, file_name // c_null_char)
        if (.not. c_associated(texture%ptr)) return

        rc = sdl_query_texture(texture%ptr, &
                               texture%format, &
                               texture%access, &
                               texture%width, &
                               texture%height)
        if (rc < 0) return

        texture%rect = sdl_rect(0, 0, texture%width, texture%height)
        rc = 0
    end function load_texture

    subroutine color_mod(ptr, color)
        !! Colourises given texture.
        type(c_ptr),      intent(in) :: ptr
        type(color_type), intent(in) :: color

        rc = sdl_set_texture_color_mod(ptr,&
                                       uint8(color%r), &
                                       uint8(color%g), &
                                       uint8(color%b))
    end subroutine color_mod

    subroutine render(renderer, logos, points, texture, colors, max_depth)
        !! Renders scene, without Z sorting.
        type(c_ptr),        intent(in)    :: renderer
        type(logo_type),    intent(inout) :: logos(:)
        type(point_type),   intent(inout) :: points(:)
        type(texture_type), intent(inout) :: texture
        type(color_type),   intent(inout) :: colors(:)
        real,               intent(in)    :: max_depth
        integer                           :: i, rc
        integer                           :: w, h
        real                              :: s
        type(sdl_rect)                    :: rect

        do i = 1, size(logos)
            s = 1.0 - (logos(i)%z / max_depth)
            w = int(50.0 * s)
            h = int(50.0 * s)
            rect = sdl_rect(points(i)%x, &
                            points(i)%y, &
                            w, &
                            h)

            call color_mod(texture%ptr, colors(logos(i)%color))
            rc = sdl_render_copy(renderer, texture%ptr, texture%rect, rect)
        end do
    end subroutine render
end program main
