! c_util.f90
!
! Types aliases and interfaces to libc for C interoperability.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module c_util
    use, intrinsic :: iso_c_binding
    implicit none

    integer, parameter :: c_uint8_t            = c_int8_t
    integer, parameter :: c_uint16_t           = c_int16_t
    integer, parameter :: c_uint32_t           = c_int32_t
    integer, parameter :: c_uint64_t           = c_int64_t
    integer, parameter :: c_unsigned           = c_int
    integer, parameter :: c_unsigned_char      = c_signed_char
    integer, parameter :: c_unsigned_long      = c_long
    integer, parameter :: c_unsigned_long_long = c_long_long
    integer, parameter :: c_unsigned_short     = c_short

    public :: c_strlen

    ! Foreign function interfaces to libc.
    interface
        function c_strlen(str) bind(c, name='strlen')
            import :: c_ptr, c_size_t
            type(c_ptr), intent(in), value :: str
            integer(c_size_t)              :: c_strlen
        end function c_strlen
    end interface
end module c_util
