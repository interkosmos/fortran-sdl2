! fire.f90
!
! Example that renders the DOOM fire effect to screen. Algorithm is taken from:
! http://fabiensanglard.net/doom_fire_psx/
!
! Author:  Philipp Engel
! Licence: ISC
module doom
    implicit  none

    type :: rgb_type
        integer :: r = 0
        integer :: g = 0
        integer :: b = 0
    end type rgb_type

    type(rgb_type), target :: palette(37) = [ &
        rgb_type(  7,   7,   7), &
        rgb_type( 31,   7,   7), &
        rgb_type( 47,  15,   7), &
        rgb_type( 71,  15,   7), &
        rgb_type( 87,  23,   7), &
        rgb_type(103,  31,   7), &
        rgb_type(119,  31,   7), &
        rgb_type(143,  39,   7), &
        rgb_type(159,  47,   7), &
        rgb_type(175,  63,   7), &
        rgb_type(191,  71,   7), &
        rgb_type(199,  71,   7), &
        rgb_type(223,  79,   7), &
        rgb_type(223,  87,   7), &
        rgb_type(223,  87,   7), &
        rgb_type(215,  95,   7), &
        rgb_type(215,  95,   7), &
        rgb_type(215, 103,  15), &
        rgb_type(207, 111,  15), &
        rgb_type(207, 119,  15), &
        rgb_type(207, 127,  15), &
        rgb_type(207, 135,  23), &
        rgb_type(199, 135,  23), &
        rgb_type(199, 143,  23), &
        rgb_type(199, 151,  31), &
        rgb_type(191, 159,  31), &
        rgb_type(191, 159,  31), &
        rgb_type(191, 167,  39), &
        rgb_type(191, 167,  39), &
        rgb_type(191, 175,  47), &
        rgb_type(183, 175,  47), &
        rgb_type(183, 183,  47), &
        rgb_type(183, 183,  55), &
        rgb_type(207, 207, 111), &
        rgb_type(223, 223, 159), &
        rgb_type(239, 239, 199), &
        rgb_type(255, 255, 255) ]
contains
    subroutine fire_burn(fire, width, height)
        integer, intent(inout) :: fire(0:)
        integer, intent(in)    :: width
        integer, intent(in)    :: height

        integer :: i, p, rnd
        integer :: x, y
        real    :: r

        do y = 1, height - 1
            do x = 0, width - 1
                i = (y * width) + x
                p = fire(i)

                if (p == 0) then
                    fire(i - width) = 0
                else
                    call random_number(r)
                    rnd = iand(int(r * 3), 3)
                    fire(i - width - rnd + 1) = p - iand(rnd, 1)
                end if
            end do
        end do
    end subroutine fire_burn

    subroutine fire_init(fire, width, height)
        integer, intent(inout) :: fire(0:)
        integer, intent(in)    :: width
        integer, intent(in)    :: height

        integer :: x

        fire(:) = 0

        do x = 0, width - 1
            fire((height - 1) * width + x) = 36
        end do
    end subroutine fire_init
end module doom

program main
    use, intrinsic :: iso_c_binding
    use, intrinsic :: iso_fortran_env, only: stderr => error_unit, stdout => output_unit
    use :: sdl2
    use :: doom
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 640
    integer, parameter :: SCREEN_HEIGHT = 400
    integer, parameter :: FIRE_HEIGHT   = SCREEN_HEIGHT / 2
    integer, parameter :: FIRE_WIDTH    = SCREEN_WIDTH / 2

    type :: buffer_type
        integer                         :: format       ! Texture format.
        integer                         :: pitch        ! Texture pitch.
        integer(c_int32_t),     pointer :: pixels(:)    ! SDL_Texture pixels pointer.
        type(c_ptr)                     :: pixels_ptr   ! C pointer to texture pixels.
        type(c_ptr)                     :: texture      ! C pointer to SDL_Texture.
        type(sdl_pixel_format), pointer :: pixel_format ! SDL_PixelFormat of SDL_Texture.
        type(sdl_rect)                  :: rect         ! Utitlity rectangle.
    end type buffer_type

    type(buffer_type)    :: buffer
    type(c_ptr)          :: renderer
    type(c_ptr)          :: window
    type(sdl_event)      :: event
    type(sdl_rect)       :: screen_rect
    integer, allocatable :: fire(:)
    integer              :: rc

    ! Initialise PRNG.
    call random_seed()

    allocate (fire(0:(FIRE_WIDTH * FIRE_HEIGHT) - 1))

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

    ! Create renderer with VSync enabled.
    renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, SDL_RENDERER_PRESENTVSYNC))
    ! Create frame buffer texture.
    buffer%texture = sdl_create_texture(renderer, &
                                        SDL_PIXELFORMAT_ARGB8888, &
                                        SDL_TEXTUREACCESS_STREAMING, &
                                        FIRE_WIDTH, &
                                        FIRE_HEIGHT)

    buffer%format = sdl_get_window_pixel_format(window)
    buffer%pixel_format => sdl_alloc_format(buffer%format)

    buffer%rect = sdl_rect(0, 0, FIRE_WIDTH, FIRE_HEIGHT)
    screen_rect = sdl_rect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    ! Get texture's pixel pointers.
    rc = sdl_lock_texture(buffer%texture, buffer%rect, buffer%pixels_ptr, buffer%pitch)
    call c_f_pointer(buffer%pixels_ptr, buffer%pixels, shape=[FIRE_WIDTH * FIRE_HEIGHT])
    call sdl_unlock_texture(buffer%texture)

    ! Initialise fire.
    call fire_init(fire, FIRE_WIDTH, FIRE_HEIGHT)

    ! Main loop.
    loop: do
        ! Event handling.
        do while (sdl_poll_event(event) > 0)
            select case (event%type)
                case (SDL_QUITEVENT); exit loop
            end select
        end do

        call fire_burn(fire, FIRE_WIDTH, FIRE_HEIGHT)
        call render(buffer, fire, FIRE_WIDTH, FIRE_HEIGHT)

        ! Copy buffer texture to screen.
        rc = sdl_render_copy(renderer, buffer%texture, buffer%rect, screen_rect)
        call sdl_render_present(renderer)
    end do loop

    ! Quit gracefully.
    deallocate (fire)
    call sdl_destroy_texture(buffer%texture)
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
contains
    subroutine render(buffer, fire, width, height)
        type(buffer_type), intent(inout) :: buffer
        integer,           intent(inout) :: fire(*)
        integer,           intent(in)    :: width
        integer,           intent(in)    :: height

        integer                 :: i, rc
        integer                 :: x, y
        type(rgb_type), pointer :: p

        rc = sdl_lock_texture(buffer%texture, buffer%rect, buffer%pixels_ptr, buffer%pitch)

        do y = 0, height - 1
            do x = 0, width - 1
                i = fire(y * width + x)
                p => palette(i + 1)

                buffer%pixels(y * width + x + 1) = sdl_map_rgb(buffer%pixel_format, p%r, p%g, p%b)
            end do
        end do

        call sdl_unlock_texture(buffer%texture)
    end subroutine render
end program main
