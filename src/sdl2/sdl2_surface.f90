! sdl2_surface.f90
!
! Fortran 2008 interface to SDL_surface.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f08sdl2/
! Licence: ISC
module sdl2_surface
    use, intrinsic :: iso_c_binding
    use :: c_util
    use :: sdl2_pixels
    use :: sdl2_rect
    use :: sdl2_stdinc
    implicit none

    ! SDL_Surface
    type, bind(c) :: sdl_surface
        integer(kind=c_uint32_t) :: flags
        type(c_ptr)              :: format
        integer(kind=c_int)      :: w
        integer(kind=c_int)      :: h
        integer(kind=c_int)      :: pitch
        type(c_ptr)              :: pixels
        type(c_ptr)              :: user_data
        integer(kind=c_int)      :: locked
        type(c_ptr)              :: lock_data
        type(sdl_rect)           :: clip_rect
        type(c_ptr)              :: map
        integer(kind=c_int)      :: ref_count
    end type sdl_surface

    public :: sdl_convert_surface_
    public :: sdl_create_rgb_surface_
    public :: sdl_fill_rect
    public :: sdl_fill_rects
    public :: sdl_load_bmp_rw
    public :: sdl_save_bmp_rw
    public :: sdl_set_clip_rect
    public :: sdl_set_color_key
    public :: sdl_upper_blit
    public :: sdl_upper_blit_scaled
    public :: sdl_free_surface

    interface
        ! SDL_Surface *SDL_ConvertSurface(SDL_Surface *src, const SDL_PixelFormat *fmt, Uint32 flags)
        function sdl_convert_surface_(src, fmt, flags) bind(c, name='SDL_ConvertSurface')
            import :: c_ptr, c_uint32_t, sdl_pixel_format, sdl_surface
            type(sdl_surface),        intent(in)        :: src
            type(sdl_pixel_format),   intent(in)        :: fmt
            integer(kind=c_uint32_t), intent(in), value :: flags
            type(c_ptr)                                 :: sdl_convert_surface_
        end function sdl_convert_surface_

        ! SDL_Surface *SDL_CreateRGBSurface(Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask)
        function sdl_create_rgb_surface_(flags, width, height, depth, r_mask, g_mask, b_mask, a_mask) &
                bind(c, name='SDL_CreateRGBSurface')
            import :: c_int, c_int64_t, c_ptr, c_uint32_t
            integer(kind=c_uint32_t), intent(in), value :: flags
            integer(kind=c_int),      intent(in), value :: width
            integer(kind=c_int),      intent(in), value :: height
            integer(kind=c_int),      intent(in), value :: depth
            integer(kind=c_int64_t),  intent(in), value :: r_mask
            integer(kind=c_int64_t),  intent(in), value :: g_mask
            integer(kind=c_int64_t),  intent(in), value :: b_mask
            integer(kind=c_int64_t),  intent(in), value :: a_mask
            type(c_ptr)                                 :: sdl_create_rgb_surface_
        end function sdl_create_rgb_surface_

        ! int SDL_FillRect(SDL_Surface *dst, const SDL_Rect *rect, Uint32 color)
        function sdl_fill_rect(dst, rect, color) bind(c, name='SDL_FillRect')
            import :: c_int, c_uint32_t, sdl_rect, sdl_surface
            type(sdl_surface),        intent(in)        :: dst
            type(sdl_rect),           intent(in)        :: rect
            integer(kind=c_uint32_t), intent(in), value :: color
            integer(kind=c_int)                         :: sdl_fill_rect
        end function sdl_fill_rect

        ! int SDL_FillRects(SDL_Surface* dst, const SDL_Rect* rects, int count, Uint32 color)
        function sdl_fill_rects(dst, rects, count, color) bind(c, name='SDL_FillRects')
            import :: c_int, c_uint32_t, sdl_rect, sdl_surface
            type(sdl_surface),        intent(in)        :: dst
            type(sdl_rect),           intent(in)        :: rects(*)
            integer(kind=c_int),      intent(in), value :: count
            integer(kind=c_uint32_t), intent(in), value :: color
            integer(kind=c_int)                         :: sdl_fill_rects
        end function sdl_fill_rects

        ! SDL_Surface *SDL_LoadBMP_RW(SDL_RWops *src, int freesrc)
        function sdl_load_bmp_rw(src, free_src) bind(c, name='SDL_LoadBMP_RW')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: src
            integer(kind=c_int), intent(in), value :: free_src
            type(c_ptr)                            :: sdl_load_bmp_rw
        end function sdl_load_bmp_rw

        ! int SDL_SaveBMP_RW(SDL_Surface *surface, SDL_RWops *dst, int freedst)
        function sdl_save_bmp_rw(surface, dst, free_dst) bind(c, name='SDL_SaveBMP_RW')
            import :: c_int, c_ptr, sdl_surface
            type(sdl_surface),   intent(in)        :: surface
            type(c_ptr),         intent(in), value :: dst
            integer(kind=c_int), intent(in), value :: free_dst
            integer(kind=c_int)                    :: sdl_save_bmp_rw
        end function sdl_save_bmp_rw

        ! SDL_bool SDL_SetClipRect(SDL_Surface *surface, const SDL_Rect *rect)
        function sdl_set_clip_rect(surface, rect) bind(c, name='SDL_SetClipRect')
            import :: sdl_bool, sdl_rect, sdl_surface
            type(sdl_surface), intent(in) :: surface
            type(sdl_rect),    intent(in) :: rect
            integer(kind=sdl_bool)        :: sdl_set_clip_rect
        end function sdl_set_clip_rect

        ! int SDL_SetColorKey(SDL_Surface *surface, int flag, Uint32 key)
        function sdl_set_color_key(surface, flag, key) bind(c, name='SDL_SetColorKey')
            import :: c_int, c_uint32_t, sdl_surface
            type(sdl_surface),        intent(in)        :: surface
            integer(kind=c_int),      intent(in), value :: flag
            integer(kind=c_uint32_t), intent(in), value :: key
            integer(kind=c_int)                         :: sdl_set_color_key
        end function sdl_set_color_key

        ! int SDL_UpperBlit(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect)
        function sdl_upper_blit(src, src_rect, dst, dst_rect) bind(c, name='SDL_UpperBlit')
            import :: c_int, sdl_rect, sdl_surface
            type(sdl_surface), intent(in) :: src
            type(sdl_rect),    intent(in) :: src_rect
            type(sdl_surface), intent(in) :: dst
            type(sdl_rect),    intent(in) :: dst_rect
            integer(kind=c_int)           :: sdl_upper_blit
        end function sdl_upper_blit

        ! int SDL_UpperBlitScaled(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect)
        function sdl_upper_blit_scaled(src, src_rect, dst, dst_rect) bind(c, name='SDL_UpperBlitScaled')
            import :: c_int, sdl_rect, sdl_surface
            type(sdl_surface), intent(in) :: src
            type(sdl_rect),    intent(in) :: src_rect
            type(sdl_surface), intent(in) :: dst
            type(sdl_rect),    intent(in) :: dst_rect
            integer(kind=c_int)           :: sdl_upper_blit_scaled
        end function sdl_upper_blit_scaled

        ! void SDL_FreeSurface(SDL_Surface *surface)
        subroutine sdl_free_surface(surface) bind(c, name='SDL_FreeSurface')
            import :: sdl_surface
            type(sdl_surface), intent(in) :: surface
        end subroutine sdl_free_surface
    end interface
end module sdl2_surface
