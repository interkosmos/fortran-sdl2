! sdl2_timer.f90
!
! Fortran 2008 interfaces to SDL_timer.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_timer
    use sdl2_c_types, only: c_uint32_t, c_uint64_t
    implicit none
    private

    public :: sdl_delay
    public :: sdl_get_ticks
    public :: sdl_get_performance_counter
    public :: sdl_get_performance_frequency

    interface
        ! Uint64 SDL_GetPerformanceCounter(void)
        function sdl_get_performance_counter() bind(c, name='SDL_GetPerformanceCounter')
            import :: c_uint64_t
            integer(kind=c_uint64_t) :: sdl_get_performance_counter
        end function sdl_get_performance_counter

        ! Uint64 SDL_GetPerformanceFrequency(void)
        function sdl_get_performance_frequency() bind(c, name='SDL_GetPerformanceFrequency')
            import :: c_uint64_t
            integer(kind=c_uint64_t) :: sdl_get_performance_frequency
        end function sdl_get_performance_frequency

        ! Uint32 SDL_GetTicks(void)
        function sdl_get_ticks() bind(c, name='SDL_GetTicks')
            import :: c_uint32_t
            integer(kind=c_uint32_t) :: sdl_get_ticks
        end function sdl_get_ticks

        ! void SDL_Delay(Uint32 ms)
        subroutine sdl_delay(ms) bind(c, name='SDL_Delay')
            import :: c_uint32_t
            integer(kind=c_uint32_t), intent(in), value :: ms
        end subroutine sdl_delay
    end interface
end module sdl2_timer
