! c_util.F90
!
! Types aliases and interfaces to libc for C interoperability.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module c_util

#if defined (__flang__) || (defined (__GFORTRAN__) && __GNUC__ > 15) || (defined (__GFORTRAN__) && __GNUC__ == 15 && __GNUC_MINOR__ >= 2)

    use, intrinsic :: iso_c_binding, only: c_uint8_t, c_uint16_t, c_uint32_t, c_uint64_t, c_unsigned, c_unsigned_char, &
                                           c_unsigned_long, c_unsigned_long_long, c_unsigned_short
    implicit none
    private

    public :: c_uint8_t
    public :: c_uint16_t
    public :: c_uint32_t
    public :: c_uint64_t
    public :: c_unsigned
    public :: c_unsigned_char
    public :: c_unsigned_long
    public :: c_unsigned_long_long
    public :: c_unsigned_short

#else

    use, intrinsic :: iso_c_binding, only: c_int8_t, c_int16_t, c_int32_t, c_int64_t, c_int, c_signed_char, &
                                           c_long, c_long_long, c_short
    implicit none
    private

    integer, parameter, public :: c_uint8_t            = c_int8_t
    integer, parameter, public :: c_uint16_t           = c_int16_t
    integer, parameter, public :: c_uint32_t           = c_int32_t
    integer, parameter, public :: c_uint64_t           = c_int64_t
    integer, parameter, public :: c_unsigned           = c_int
    integer, parameter, public :: c_unsigned_char      = c_signed_char
    integer, parameter, public :: c_unsigned_long      = c_long
    integer, parameter, public :: c_unsigned_long_long = c_long_long
    integer, parameter, public :: c_unsigned_short     = c_short

#endif

    public :: c_strlen

    ! Foreign function interfaces to libc.
    interface
        function c_strlen(str) bind(c, name='strlen')
            use, intrinsic :: iso_c_binding, only: c_ptr, c_size_t
            type(c_ptr), intent(in), value :: str
            integer(kind=c_size_t)         :: c_strlen
        end function c_strlen
    end interface
end module c_util
