! sdl2_log.f90
!
! Fortran 2008 interfaces to SDL_log.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_log
    use :: sdl2_c_types, only: c_char, c_funptr, c_int, c_ptr
    implicit none
    private

    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_APPLICATION = 0
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_ERROR       = 1
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_ASSERT      = 2
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_SYSTEM      = 3
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_AUDIO       = 4
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_VIDEO       = 5
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RENDER      = 6
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_INPUT       = 7
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_TEST        = 8
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED1   = 9
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED2   = 10
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED3   = 11
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED4   = 12
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED5   = 13
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED6   = 14
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED7   = 15
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED8   = 16
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED9   = 17
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_RESERVED10  = 18
    integer(kind=c_int), parameter, public :: SDL_LOG_CATEGORY_CUSTOM      = 19

    integer(kind=c_int), parameter, public :: SDL_LOG_PRIORITY_VERBOSE  = 1
    integer(kind=c_int), parameter, public :: SDL_LOG_PRIORITY_DEBUG    = 2
    integer(kind=c_int), parameter, public :: SDL_LOG_PRIORITY_INFO     = 3
    integer(kind=c_int), parameter, public :: SDL_LOG_PRIORITY_WARN     = 4
    integer(kind=c_int), parameter, public :: SDL_LOG_PRIORITY_ERROR    = 5
    integer(kind=c_int), parameter, public :: SDL_LOG_PRIORITY_CRITICAL = 6
    integer(kind=c_int), parameter, public :: SDL_NUM_LOG_PRIORITIES    = 7

    public :: sdl_log_
    public :: sdl_log_critical_
    public :: sdl_log_debug_
    public :: sdl_log_error_
    public :: sdl_log_info_
    public :: sdl_log_verbose_
    public :: sdl_log_warn_
    public :: sdl_log_get_output_function
    public :: sdl_log_get_priority
    public :: sdl_log_reset_priorities
    public :: sdl_log_set_all_priority
    public :: sdl_log_set_output_function
    public :: sdl_log_set_priority

    interface
        ! SDL_LogPriority SDL_LogGetPriority(int category)
        function sdl_log_get_priority(category) bind(c, name='SDL_LogGetPriority')
            import :: c_int
            integer(kind=c_int), intent(in), value :: category
            integer(kind=c_int)                    :: sdl_log_get_priority
        end function sdl_log_get_priority

        ! void SDL_Log(const char *fmt, ...)
        subroutine sdl_log_(fmt, str) bind(c, name='SDL_Log')
            import :: c_char
            character(kind=c_char), intent(in) :: fmt
            character(kind=c_char), intent(in) :: str
        end subroutine sdl_log_

        ! void SDL_LogCritical(int category, const char *fmt, ...)
        subroutine sdl_log_critical_(category, fmt, str) bind(c, name='SDL_LogCritical')
            import :: c_int, c_char
            integer(kind=c_int),    intent(in) :: category
            character(kind=c_char), intent(in) :: fmt
            character(kind=c_char), intent(in) :: str
        end subroutine sdl_log_critical_

        ! void SDL_LogDebug(int category, const char *fmt, ...)
        subroutine sdl_log_debug_(category, fmt, str) bind(c, name='SDL_LogDebug')
            import :: c_int, c_char
            integer(kind=c_int),    intent(in) :: category
            character(kind=c_char), intent(in) :: fmt
            character(kind=c_char), intent(in) :: str
        end subroutine sdl_log_debug_

        ! void SDL_LogError(int category, const char *fmt, ...)
        subroutine sdl_log_error_(category, fmt, str) bind(c, name='SDL_LogError')
            import :: c_int, c_char
            integer(kind=c_int),    intent(in) :: category
            character(kind=c_char), intent(in) :: fmt
            character(kind=c_char), intent(in) :: str
        end subroutine sdl_log_error_

        ! void SDL_LogInfo(int category, const char *fmt, ...)
        subroutine sdl_log_info_(category, fmt, str) bind(c, name='SDL_LogInfo')
            import :: c_int, c_char
            integer(kind=c_int),    intent(in) :: category
            character(kind=c_char), intent(in) :: fmt
            character(kind=c_char), intent(in) :: str
        end subroutine sdl_log_info_

        ! void SDL_LogVerbose(int category, const char *fmt, ...)
        subroutine sdl_log_verbose_(category, fmt, str) bind(c, name='SDL_LogVerbose')
            import :: c_int, c_char
            integer(kind=c_int),    intent(in) :: category
            character(kind=c_char), intent(in) :: fmt
            character(kind=c_char), intent(in) :: str
        end subroutine sdl_log_verbose_

        ! void SDL_LogWarn(int category, const char *fmt, ...)
        subroutine sdl_log_warn_(category, fmt, str) bind(c, name='SDL_LogWarn')
            import :: c_int, c_char
            integer(kind=c_int),    intent(in) :: category
            character(kind=c_char), intent(in) :: fmt
            character(kind=c_char), intent(in) :: str
        end subroutine sdl_log_warn_

        ! void SDL_LogGetOutputFunction(SDL_LogOutputFunction callback, void *userdata)
        subroutine sdl_log_get_output_function(callback, userdata) bind(c, name='SDL_LogGetOutputFunction')
            import :: c_funptr, c_ptr
            type(c_funptr), intent(in), value :: callback
            type(c_ptr),    intent(in), value :: userdata
        end subroutine sdl_log_get_output_function

        ! void SDL_LogResetPriorities()
        subroutine sdl_log_reset_priorities() bind(c, name='SDL_LogResetPriorities')
        end subroutine sdl_log_reset_priorities

        ! void SDL_LogSetAllPriority(SDL_LogPriority priority)
        subroutine sdl_log_set_all_priority(priority) bind(c, name='SDL_LogSetAllPriority')
            import :: c_int
            integer(kind=c_int), intent(in), value :: priority
        end subroutine sdl_log_set_all_priority

        ! void SDL_LogSetOutputFunction(SDL_LogOutputFunction callback, void *userdata)
        subroutine sdl_log_set_output_function(callback, userdata) bind(c, name='SDL_LogSetOutputFunction')
            import :: c_funptr, c_ptr
            type(c_funptr), intent(in), value :: callback
            type(c_ptr),    intent(in), value :: userdata
        end subroutine sdl_log_set_output_function

        ! void SDL_LogSetPriority(SDL_LogPriority priority)
        subroutine sdl_log_set_priority(category, priority) bind(c, name='SDL_LogSetPriority')
            import :: c_int
            integer(kind=c_int), intent(in), value :: category
            integer(kind=c_int), intent(in), value :: priority
        end subroutine sdl_log_set_priority
    end interface
end module sdl2_log
