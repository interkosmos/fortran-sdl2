! sdl2_c_types.F90
!
! Types aliases for C interoperability.
!
! Author:  Philipp Engel, Igor S. Gerasimov
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_c_types
    use, intrinsic :: iso_c_binding, only: c_int8_t, c_int16_t, c_int32_t, c_int64_t, &
                                           c_char, c_signed_char, c_short, c_int, &
                                           c_long, c_long_long, &
                                           c_ptr, c_funptr, c_null_ptr, c_null_char, &
                                           c_size_t, &
                                           c_float, c_double

#if HAS_UNSIGNED

    use, intrinsic :: iso_c_binding, only: c_uint8_t, c_uint16_t, c_uint32_t, c_uint64_t, &
                                           c_unsigned_char, c_unsigned, c_unsigned_short, &
                                           c_unsigned_long, c_unsigned_long_long

#endif

    implicit none
    private

#if !HAS_UNSIGNED

    integer, parameter :: c_uint8_t            = c_int8_t
    integer, parameter :: c_uint16_t           = c_int16_t
    integer, parameter :: c_uint32_t           = c_int32_t
    integer, parameter :: c_uint64_t           = c_int64_t
    integer, parameter :: c_unsigned           = c_int
    integer, parameter :: c_unsigned_char      = c_signed_char
    integer, parameter :: c_unsigned_long      = c_long
    integer, parameter :: c_unsigned_long_long = c_long_long
    integer, parameter :: c_unsigned_short     = c_short

#endif

    public :: c_double
    public :: c_float
    public :: c_funptr
    public :: c_null_char
    public :: c_null_ptr
    public :: c_ptr
    public :: c_size_t

    public :: c_char
    public :: c_int
    public :: c_int8_t
    public :: c_int16_t
    public :: c_int32_t
    public :: c_int64_t
    public :: c_long
    public :: c_long_long
    public :: c_short
    public :: c_signed_char

    public :: c_uint8_t
    public :: c_uint16_t
    public :: c_uint32_t
    public :: c_uint64_t
    public :: c_unsigned
    public :: c_unsigned_char
    public :: c_unsigned_long
    public :: c_unsigned_long_long
    public :: c_unsigned_short
end module sdl2_c_types
