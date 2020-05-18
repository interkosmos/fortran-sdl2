! sdl2_rwops.f90
!
! Fortran 2008 interfaces to SDL_rwops.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_rwops
    use, intrinsic :: iso_c_binding, only: c_char, c_int, c_ptr
    implicit none

    public :: sdl_rw_from_const_mem
    public :: sdl_rw_from_file
    public :: sdl_rw_from_mem

    interface
        ! SDL_RWops *SDL_RWFromConstMem(void *mem, int size)
        function sdl_rw_from_const_mem(mem, size) bind(c, name='SDL_RWFromConstMem')
            import :: c_ptr, c_int
            type(c_ptr),         intent(in), value :: mem
            integer(kind=c_int), intent(in), value :: size
            type(c_ptr)                            :: sdl_rw_from_const_mem
        end function sdl_rw_from_const_mem

        ! SDL_RWops *SDL_RWFromFile(const char *file, const char *mode)
        function sdl_rw_from_file(file, mode) bind(c, name='SDL_RWFromFile')
            import :: c_char, c_ptr
            character(kind=c_char), intent(in) :: file
            character(kind=c_char), intent(in) :: mode
            type(c_ptr)                        :: sdl_rw_from_file
        end function sdl_rw_from_file

        ! SDL_RWops *SDL_RWFromMem(void *mem, int size)
        function sdl_rw_from_mem(mem, size) bind(c, name='SDL_RWFromMem')
            import :: c_ptr, c_int
            type(c_ptr),         intent(in), value :: mem
            integer(kind=c_int), intent(in), value :: size
            type(c_ptr)                            :: sdl_rw_from_mem
        end function sdl_rw_from_mem
    end interface
end module sdl2_rwops
