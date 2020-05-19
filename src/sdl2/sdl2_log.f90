! sdl2_log.f90
!
! Fortran 2008 interfaces to SDL_log.h. The various SDL_Log() routines cannot
! be called directly due to the ellipsis arguments. Wrapper routines in C are
! required first.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_log
    use, intrinsic :: iso_c_binding
    use :: c_util, only: c_char, c_funptr, c_int, c_ptr
    implicit none

    enum, bind(c)
        enumerator :: SDL_LOG_CATEGORY_APPLICATION
        enumerator :: SDL_LOG_CATEGORY_ERROR
        enumerator :: SDL_LOG_CATEGORY_ASSERT
        enumerator :: SDL_LOG_CATEGORY_SYSTEM
        enumerator :: SDL_LOG_CATEGORY_AUDIO
        enumerator :: SDL_LOG_CATEGORY_VIDEO
        enumerator :: SDL_LOG_CATEGORY_RENDER
        enumerator :: SDL_LOG_CATEGORY_INPUT
        enumerator :: SDL_LOG_CATEGORY_TEST
        enumerator :: SDL_LOG_CATEGORY_RESERVED1
        enumerator :: SDL_LOG_CATEGORY_RESERVED2
        enumerator :: SDL_LOG_CATEGORY_RESERVED3
        enumerator :: SDL_LOG_CATEGORY_RESERVED4
        enumerator :: SDL_LOG_CATEGORY_RESERVED5
        enumerator :: SDL_LOG_CATEGORY_RESERVED6
        enumerator :: SDL_LOG_CATEGORY_RESERVED7
        enumerator :: SDL_LOG_CATEGORY_RESERVED8
        enumerator :: SDL_LOG_CATEGORY_RESERVED9
        enumerator :: SDL_LOG_CATEGORY_RESERVED10
        enumerator :: SDL_LOG_CATEGORY_CUSTOM
    end enum

    enum, bind(c)
        enumerator :: SDL_LOG_PRIORITY_VERBOSE = 1
        enumerator :: SDL_LOG_PRIORITY_DEBUG
        enumerator :: SDL_LOG_PRIORITY_INFO
        enumerator :: SDL_LOG_PRIORITY_WARN
        enumerator :: SDL_LOG_PRIORITY_ERROR
        enumerator :: SDL_LOG_PRIORITY_CRITICAL
        enumerator :: SDL_NUM_LOG_PRIORITIES
    end enum

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
