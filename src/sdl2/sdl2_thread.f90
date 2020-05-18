! sdl2_thread.f90
!
! Fortran 2008 interfaces to SDL_thread.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_thread
    use, intrinsic :: iso_c_binding, only: c_char, c_funptr, c_int, c_ptr
    implicit none

    public :: sdl_create_thread
    public :: sdl_detach_thread
    public :: sdl_wait_thread

    interface
        ! SDL_Thread *SDL_CreateThread(SDL_ThreadFunction fn, const char *name, void *data)
        function sdl_create_thread(fn, name, data) bind(c, name='SDL_CreateThread')
            import :: c_char, c_ptr, c_funptr
            type(c_funptr),         intent(in), value :: fn
            character(kind=c_char), intent(in)        :: name
            type(c_ptr),            intent(in), value :: data
            type(c_ptr)                               :: sdl_create_thread
        end function sdl_create_thread

        ! void SDL_DetachThread(SDL_Thread *thread)
        subroutine sdl_detach_thread(thread) bind(c, name='SDL_DetachThread')
            import :: c_ptr
            type(c_ptr), intent(in), value :: thread
        end subroutine sdl_detach_thread

        ! void SDL_WaitThread(SDL_Thread *thread, int *status)
        subroutine sdl_wait_thread(thread, status) bind(c, name='SDL_WaitThread')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: thread
            integer(kind=c_int), intent(in)        :: status
        end subroutine sdl_wait_thread
    end interface
end module sdl2_thread
