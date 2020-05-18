! info.f90
!
! Displays various debug information and quits.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: compiler_version, stdout => output_unit, &
                                             stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 640
    integer, parameter :: SCREEN_HEIGHT = 240

    type(c_ptr) :: window

    ! Initialise SDL.
    if (sdl_init(ior(SDL_INIT_TIMER, ior(SDL_INIT_VIDEO, SDL_INIT_AUDIO))) < 0) then
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

    ! Print debug messages to `stdout`.
    call print_debug(window)

    ! Quit gracefully.
    call sdl_destroy_window(window)
    call sdl_quit()
contains
    function has(n)
        !! Returns a string with `YES` or `NO`, depending on a given number n
        !! beeing one or not.
        integer,          intent(in)  :: n
        character(len=:), allocatable :: has

        if (n == 1) then
            has = 'YES'
        else
            has = 'NO'
        end if
    end function has

    subroutine print_debug(window)
        !! Prints debug messages to stdout.
        type(c_ptr), intent(in)         :: window
        integer                         :: dt(8)
        integer                         :: w, h, x, y
        integer(kind=8)                 :: size
        type(sdl_version)               :: sdl_v
        type(sdl_renderer_info), target :: info
        character(len=:), allocatable   :: str

        call date_and_time(values=dt)
        call sdl_get_version(sdl_v)
        call sdl_get_window_size(window, w, h)
        call sdl_get_window_position(window, x, y)

        if (sdl_get_render_driver_info(0, c_loc(info)) == 0) then
            size = c_strlen(info%name)
            allocate (character(len=size) :: str)
            call c_f_string_ptr(info%name, str)
        else
            allocate (character(len=3) :: str)
            str = 'N/A'
        end if

        print '(2a)',       'App path........: ', sdl_get_base_path()
        print '(a, i4, 5(a, i2.2))', &
                            'Date and time...: ', dt(1), '/', &
                                                  dt(2), '/', &
                                                  dt(3), ' ', &
                                                  dt(5), ':', &
                                                  dt(6), ':', &
                                                  dt(7)
        print '(2a)',       'Platform........: ', sdl_get_platform()
        print '(2a)',       'Fortran compiler: ', compiler_version()
        print '(3(a, i0))', 'SDL version.....: ', sdl_v%major, '.', &
                                                  sdl_v%minor, '.', &
                                                  sdl_v%patch
        print '(2a)',       'Audio driver....: ', sdl_get_current_audio_driver()
        print '(2a)',       'Video driver....: ', sdl_get_current_video_driver()
        print '(2a)',       'Renderer........: ', str
        print '(2a)',       'VSync...........: ', has(ieor(info%flags, SDL_RENDERER_PRESENTVSYNC))
        print '(a, i0, a)', 'RAM.............: ', sdl_get_system_ram(), ' MiB'
        print '(a, i0)',    'CPU cores.......: ', sdl_get_cpu_count()
        print '(a, i0, a)', 'CPU L1 cache....: ', sdl_get_cpu_cache_line_size(), ' KiB'
        print '(2a)',       '3DNow!..........: ', has(sdl_has_3dnow())
        print '(2a)',       'AVX.............: ', has(sdl_has_avx())
        print '(2a)',       'AVX2............: ', has(sdl_has_avx2())
        print '(2a)',       'AltiVec.........: ', has(sdl_has_alti_vec())
        print '(2a)',       'MMX.............: ', has(sdl_has_mmx())
        print '(2a)',       'RDTSC...........: ', has(sdl_has_rdtsc())
        print '(2a)',       'SSE.............: ', has(sdl_has_sse())
        print '(2a)',       'SSE2............: ', has(sdl_has_sse2())
        print '(2a)',       'SSE3............: ', has(sdl_has_sse3())
        print '(2a)',       'SSE4.1..........: ', has(sdl_has_sse41())
        print '(2a)',       'SSE4.2..........: ', has(sdl_has_sse42())
        print '(a, i0)',    'Window ID.......: ', sdl_get_window_id(window)
        print '(2a)',       'Window title....: ', sdl_get_window_title(window)
        print '(2(a, i0))', 'Window size.....: ', w, 'x', h
        print '(2(a, i0))', 'Window position.: ', x, ', ', y
    end subroutine print_debug
end program main
