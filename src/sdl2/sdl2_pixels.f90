! sdl2_pixels.f90
!
! Fortran 2008 interfaces to SDL_pixels.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_pixels
    use, intrinsic :: iso_c_binding
    use :: c_util
    implicit none

    ! SDL_PixelFormatEnum
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_UNKNOWN     = int(z'0')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_INDEX1LSB   = int(z'11100100')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_INDEX1MSB   = int(z'11200100')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_INDEX4LSB   = int(z'12100400')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_INDEX4MSB   = int(z'12200400')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_INDEX8      = int(z'13000801')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGB332      = int(z'14110801')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGB444      = int(z'15120c02')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGB555      = int(z'15130f02')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGR555      = int(z'15530f02')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_ARGB4444    = int(z'15321002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGBA4444    = int(z'15421002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_ABGR4444    = int(z'15721002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGRA4444    = int(z'15821002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_ARGB1555    = int(z'15331002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGBA5551    = int(z'15441002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_ABGR1555    = int(z'15731002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGRA5551    = int(z'15841002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGB565      = int(z'15151002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGR565      = int(z'15551002')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGB24       = int(z'17101803')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGR24       = int(z'17401803')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGB888      = int(z'16161804')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGBX8888    = int(z'16261804')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGR888      = int(z'16561804')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGRX8888    = int(z'16661804')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_ARGB8888    = int(z'16362004')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_RGBA8888    = int(z'16462004')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_ABGR8888    = int(z'16762004')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_BGRA8888    = int(z'16862004')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_ARGB2101010 = int(z'16372004')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_YV12        = int(z'32315659')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_IYUV        = int(z'56555949')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_YUY2        = int(z'32595559')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_UYVY        = int(z'59565955')
    integer(kind=c_int), parameter :: SDL_PIXELFORMAT_YVYU        = int(z'55595659')

    integer(kind=c_int), parameter :: SDL_ALPHA_OPAQUE      = 255
    integer(kind=c_int), parameter :: SDL_ALPHA_TRANSPARENT = 0

    ! SDL_Color
    type, bind(c) :: sdl_color
        integer(kind=c_uint8_t) :: r
        integer(kind=c_uint8_t) :: g
        integer(kind=c_uint8_t) :: b
        integer(kind=c_uint8_t) :: a
    end type sdl_color

    ! SDL_Palette
    type, bind(c) :: sdl_palette
        integer(kind=c_int)      :: ncolors
        type(c_ptr)              :: colors
        integer(kind=c_uint32_t) :: version
        integer(kind=c_int)      :: ref_count
    end type sdl_palette

    ! SDL_PixelFormat
    type, bind(c) :: sdl_pixel_format
        integer(kind=c_uint32_t) :: format
        type(c_ptr)              :: palette
        integer(kind=c_uint8_t)  :: bits_per_pixel
        integer(kind=c_uint8_t)  :: bytes_per_pixel
        integer(kind=c_uint8_t)  :: padding(2)
        integer(kind=c_uint32_t) :: r_mask
        integer(kind=c_uint32_t) :: g_mask
        integer(kind=c_uint32_t) :: b_mask
        integer(kind=c_uint32_t) :: a_mask
        integer(kind=c_uint8_t)  :: r_loss
        integer(kind=c_uint8_t)  :: g_loss
        integer(kind=c_uint8_t)  :: b_loss
        integer(kind=c_uint8_t)  :: a_loss
        integer(kind=c_uint8_t)  :: r_shift
        integer(kind=c_uint8_t)  :: g_shift
        integer(kind=c_uint8_t)  :: b_shift
        integer(kind=c_uint8_t)  :: a_shift
        integer(kind=c_int)      :: ref_count
        type(c_ptr)              :: next
    end type sdl_pixel_format

    public :: sdl_alloc_format_
    public :: sdl_free_format
    public :: sdl_get_rgb
    public :: sdl_get_rgba
    public :: sdl_map_rgb_
    public :: sdl_map_rgba_

    interface
        ! SDL_PixelFormat* SDL_AllocFormat(Uint32 pixel_format)
        function sdl_alloc_format_(pixel_format) bind(c, name='SDL_AllocFormat')
            import :: c_ptr, c_uint32_t
            integer(kind=c_uint32_t), intent(in), value :: pixel_format
            type(c_ptr)                                 :: sdl_alloc_format_
        end function sdl_alloc_format_

        ! Uint32 SDL_MapRGB(const SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b)
        function sdl_map_rgb_(format, r, g, b) bind(c, name='SDL_MapRGB')
            import :: c_uint8_t, c_uint32_t, sdl_pixel_format
            type(sdl_pixel_format) , intent(in)        :: format
            integer(kind=c_uint8_t), intent(in), value :: r
            integer(kind=c_uint8_t), intent(in), value :: g
            integer(kind=c_uint8_t), intent(in), value :: b
            integer(kind=c_uint32_t)                    :: sdl_map_rgb_
        end function sdl_map_rgb_

        ! Uint32 SDL_MapRGBA(const SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
        function sdl_map_rgba_(format, r, g, b, a) bind(c, name='SDL_MapRGBA')
            import :: c_uint8_t, c_uint32_t, sdl_pixel_format
            type(sdl_pixel_format) , intent(in)        :: format
            integer(kind=c_uint8_t), intent(in), value :: r
            integer(kind=c_uint8_t), intent(in), value :: g
            integer(kind=c_uint8_t), intent(in), value :: b
            integer(kind=c_uint8_t), intent(in), value :: a
            integer(kind=c_uint32_t)                    :: sdl_map_rgba_
        end function sdl_map_rgba_

        ! void SDL_FreeFormat(SDL_PixelFormat* format)
        subroutine sdl_free_format(format) bind(c, name='SDL_FreeFormat')
            import :: sdl_pixel_format
            type(sdl_pixel_format), intent(in) :: format
        end subroutine sdl_free_format

        ! void SDL_GetRGB(Uint32 pixel, const SDL_PixelFormat *format, Uint8 *r, Uint8 *g, Uint8 *b)
        subroutine sdl_get_rgb(pixel, format, r, g, b) bind(c, name='SDL_GetRGB')
            import :: c_ptr, c_uint8_t, c_uint32_t, sdl_pixel_format
            integer(kind=c_uint32_t), intent(in), value :: pixel
            type(sdl_pixel_format),   intent(in)        :: format
            integer(kind=c_uint8_t),  intent(out)       :: r
            integer(kind=c_uint8_t),  intent(out)       :: g
            integer(kind=c_uint8_t),  intent(out)       :: b
        end subroutine sdl_get_rgb

        ! void SDL_GetRGBA(Uint32 pixel, const SDL_PixelFormat *format, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a)
        subroutine sdl_get_rgba(pixel, format, r, g, b, a) bind(c, name='SDL_GetRGBA')
            import :: c_ptr, c_uint8_t, c_uint32_t, sdl_pixel_format
            integer(kind=c_uint32_t), intent(in), value :: pixel
            type(sdl_pixel_format),   intent(in)        :: format
            integer(kind=c_uint8_t),  intent(out)       :: r
            integer(kind=c_uint8_t),  intent(out)       :: g
            integer(kind=c_uint8_t),  intent(out)       :: b
            integer(kind=c_uint8_t),  intent(out)       :: a
        end subroutine sdl_get_rgba
    end interface
end module sdl2_pixels
