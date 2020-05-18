! sdl2_cpuinfo.f90
!
! Fortran 2008 interfaces to SDL_cpuinfo.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_cpuinfo
    use, intrinsic :: iso_c_binding
    use :: sdl2_stdinc, only: sdl_bool
    implicit none

    public :: sdl_get_cpu_cache_line_size
    public :: sdl_get_cpu_count
    public :: sdl_get_system_ram
    public :: sdl_has_3dnow
    public :: sdl_has_alti_vec
    public :: sdl_has_avx
    public :: sdl_has_avx2
    public :: sdl_has_mmx
    public :: sdl_has_rdtsc
    public :: sdl_has_sse
    public :: sdl_has_sse2
    public :: sdl_has_sse3
    public :: sdl_has_sse41
    public :: sdl_has_sse42

    interface
        ! int SDL_GetCPUCacheLineSize(void)
        function sdl_get_cpu_cache_line_size() bind(c, name='SDL_GetCPUCacheLineSize')
            import :: c_int
            integer(kind=c_int) :: sdl_get_cpu_cache_line_size
        end function sdl_get_cpu_cache_line_size

        ! int SDL_GetCPUCount(void)
        function sdl_get_cpu_count() bind(c, name='SDL_GetCPUCount')
            import :: c_int
            integer(kind=c_int) :: sdl_get_cpu_count
        end function sdl_get_cpu_count

        ! int SDL_GetSystemRAM(void)
        function sdl_get_system_ram() bind(c, name='SDL_GetSystemRAM')
            import :: c_int
            integer(kind=c_int) :: sdl_get_system_ram
        end function sdl_get_system_ram

        ! SDL_bool SDL_Has3DNow(void)
        function sdl_has_3dnow() bind(c, name='SDL_Has3DNow')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_3dnow
        end function sdl_has_3dnow

        ! SDL_bool SDL_HasAltiVec(void)
        function sdl_has_alti_vec() bind(c, name='SDL_HasAltiVec')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_alti_vec
        end function sdl_has_alti_vec

        ! SDL_bool SDL_HasAVX(void)
        function sdl_has_avx() bind(c, name='SDL_HasAVX')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_avx
        end function sdl_has_avx

        ! SDL_bool SDL_HasAVX2(void)
        function sdl_has_avx2() bind(c, name='SDL_HasAVX2')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_avx2
        end function sdl_has_avx2

        ! SDL_bool SDL_HasMMX(void)
        function sdl_has_mmx() bind(c, name='SDL_HasMMX')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_mmx
        end function sdl_has_mmx

        ! SDL_bool SDL_HasRDTSC(void)
        function sdl_has_rdtsc() bind(c, name='SDL_HasRDTSC')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_rdtsc
        end function sdl_has_rdtsc

        ! SDL_bool SDL_HasSSE(void)
        function sdl_has_sse() bind(c, name='SDL_HasSSE')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_sse
        end function sdl_has_sse

        ! SDL_bool SDL_HasSSE2(void)
        function sdl_has_sse2() bind(c, name='SDL_HasSSE2')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_sse2
        end function sdl_has_sse2

        ! SDL_bool SDL_HasSSE3(void)
        function sdl_has_sse3() bind(c, name='SDL_HasSSE3')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_sse3
        end function sdl_has_sse3

        ! SDL_bool SDL_HasSSE41(void)
        function sdl_has_sse41() bind(c, name='SDL_HasSSE41')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_sse41
        end function sdl_has_sse41

        ! SDL_bool SDL_HasSSE42(void)
        function sdl_has_sse42() bind(c, name='SDL_HasSSE42')
            import :: sdl_bool
            integer(kind=sdl_bool) :: sdl_has_sse42
        end function sdl_has_sse42
    end interface
end module sdl2_cpuinfo
