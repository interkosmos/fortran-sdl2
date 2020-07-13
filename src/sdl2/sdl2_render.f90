! sdl2_render.f90
!
! Fortran 2008 interfaces to SDL_render.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_render
    use, intrinsic :: iso_c_binding
    use :: c_util
    use :: sdl2_rect
    use :: sdl2_surface
    implicit none

    ! SDL_RendererFlags
    integer(kind=c_int), parameter :: SDL_RENDERER_SOFTWARE      = int(z'00000001')
    integer(kind=c_int), parameter :: SDL_RENDERER_ACCELERATED   = int(z'00000002')
    integer(kind=c_int), parameter :: SDL_RENDERER_PRESENTVSYNC  = int(z'00000004')
    integer(kind=c_int), parameter :: SDL_RENDERER_TARGETTEXTURE = int(z'00000008')

    ! SDL_RendererFlip
    integer(kind=c_int), parameter :: SDL_FLIP_NONE       = int(z'00000000')
    integer(kind=c_int), parameter :: SDL_FLIP_HORIZONTAL = int(z'00000001')
    integer(kind=c_int), parameter :: SDL_FLIP_VERTICAL   = int(z'00000002')

    ! SDL_TextureAccess
    enum, bind(c)
        enumerator :: SDL_TEXTUREACCESS_STATIC
        enumerator :: SDL_TEXTUREACCESS_STREAMING
        enumerator :: SDL_TEXTUREACCESS_TARGET
    end enum

    ! SDL_RendererInfo
    type, bind(c), public :: sdl_renderer_info
        type(c_ptr)             :: name
        integer(kind=c_int32_t) :: flags
        integer(kind=c_int32_t) :: num_texture_formats
        integer(kind=c_int32_t) :: texture_formats(16)
        integer(kind=c_int)     :: max_texture_width
        integer(kind=c_int)     :: max_texture_height
    end type sdl_renderer_info

    public :: sdl_create_renderer
    public :: sdl_create_texture
    public :: sdl_create_texture_from_surface
    public :: sdl_destroy_renderer
    public :: sdl_destroy_texture
    public :: sdl_get_num_render_drivers
    public :: sdl_get_render_driver_info
    public :: sdl_get_render_target
    public :: sdl_gl_bind_texture
    public :: sdl_gl_unbind_texture
    public :: sdl_lock_texture
    public :: sdl_query_texture
    public :: sdl_render_clear
    public :: sdl_render_copy
    public :: sdl_render_copy_ex
    public :: sdl_render_draw_line
    public :: sdl_render_draw_lines
    public :: sdl_render_draw_point
    public :: sdl_render_draw_points
    public :: sdl_render_draw_rect
    public :: sdl_render_draw_rects
    public :: sdl_render_fill_rect
    public :: sdl_render_fill_rects
    public :: sdl_render_get_scale
    public :: sdl_render_get_viewport
    public :: sdl_render_present
    public :: sdl_render_read_pixels
    public :: sdl_render_set_scale
    public :: sdl_render_set_viewport
    public :: sdl_set_render_draw_blend_mode
    public :: sdl_set_render_draw_color
    public :: sdl_set_render_target
    public :: sdl_set_texture_color_mod
    public :: sdl_unlock_texture
    public :: sdl_update_texture

    interface
        ! SDL_Renderer *SDL_CreateRenderer(SDL_Window *window, int index, Uint32 flags)
        function sdl_create_renderer(window, index, flags) bind(c, name='SDL_CreateRenderer')
            import :: c_int, c_ptr, c_uint32_t
            type(c_ptr),              intent(in), value :: window
            integer(kind=c_int),      intent(in), value :: index
            integer(kind=c_uint32_t), intent(in), value :: flags
            type(c_ptr)                                 :: sdl_create_renderer
        end function sdl_create_renderer

        ! SDL_Texture *SDL_CreateTexture(SDL_Renderer *renderer, Uint32 format, int access, int w, int h)
        function sdl_create_texture(renderer, format, access, w, h) bind(c, name='SDL_CreateTexture')
            import :: c_int, c_ptr, c_uint32_t
            type(c_ptr),              intent(in), value :: renderer
            integer(kind=c_uint32_t), intent(in), value :: format
            integer(kind=c_int),      intent(in), value :: access
            integer(kind=c_int),      intent(in), value :: w
            integer(kind=c_int),      intent(in), value :: h
            type(c_ptr)                                 :: sdl_create_texture
        end function sdl_create_texture

        ! SDL_Texture *SDL_CreateTextureFromSurface(SDL_Renderer *renderer, SDL_Surface *surface)
        function sdl_create_texture_from_surface(renderer, surface) bind(c, name='SDL_CreateTextureFromSurface')
            import :: c_ptr, sdl_surface
            type(c_ptr),       intent(in), value :: renderer
            type(sdl_surface), intent(in)        :: surface
            type(c_ptr)                          :: sdl_create_texture_from_surface
        end function sdl_create_texture_from_surface

        ! int SDL_GetNumRenderDrivers(void)
        function sdl_get_num_render_drivers() bind(c, name='SDL_GetNumRenderDrivers')
            import :: c_int
            integer(kind=c_int) :: sdl_get_num_render_drivers
        end function sdl_get_num_render_drivers

        ! int SDL_GetRenderDriverInfo(int index, SDL_RendererInfo *info)
        function sdl_get_render_driver_info(index, info) bind(c, name='SDL_GetRenderDriverInfo')
            import :: c_int, c_ptr
            integer(kind=c_int), intent(in), value :: index
            type(c_ptr),         intent(in), value :: info
            integer(kind=c_int)                    :: sdl_get_render_driver_info
        end function sdl_get_render_driver_info

        ! SDL_Texture *SDL_GetRenderTarget(SDL_Renderer *renderer)
        function sdl_get_render_target(renderer) bind(c, name='SDL_GetRenderTarget')
            import :: c_ptr
            type(c_ptr), intent(in), value :: renderer
            type(c_ptr)                    :: sdl_get_render_target
        end function sdl_get_render_target

        ! int SDL_GL_BindTexture(SDL_Texture *texture, float *texw, float *texh)
        function sdl_gl_bind_texture(texture, texw, texh) bind(c, name='SDL_GL_BindTexture')
            import :: c_float, c_int, c_ptr
            type(c_ptr),        intent(in), value :: texture
            real(kind=c_float), intent(in)        :: texw
            real(kind=c_float), intent(in)        :: texh
            integer(kind=c_int)                   :: sdl_gl_bind_texture
        end function sdl_gl_bind_texture

        ! int SDL_GL_UnbindTexture(SDL_Texture *texture)
        function sdl_gl_unbind_texture(texture) bind(c, name='SDL_GL_UnbindTexture')
            import :: c_int, c_ptr
            type(c_ptr), intent(in), value :: texture
            integer(kind=c_int)            :: sdl_gl_unbind_texture
        end function sdl_gl_unbind_texture

        ! int SDL_LockTexture(SDL_Texture *texture, const SDL_Rect *rect, void **pixels, int *pitch)
        function sdl_lock_texture(texture, rect, pixels, pitch) bind(c, name='SDL_LockTexture')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),         intent(in), value :: texture
            type(sdl_rect),      intent(in)        :: rect
            type(c_ptr),         intent(in)        :: pixels
            integer(kind=c_int), intent(inout)     :: pitch
            integer(kind=c_int)                    :: sdl_lock_texture
        end function sdl_lock_texture

        ! int SDL_QueryTexture(SDL_Texture *texture, Uint32 *format, int *access, int *w, int *h)
        function sdl_query_texture(texture, format, access, w, h) bind(c, name='SDL_QueryTexture')
            import :: c_int, c_ptr, c_uint32_t
            type(c_ptr),              intent(in), value :: texture
            integer(kind=c_uint32_t), intent(inout)     :: format
            integer(kind=c_int),      intent(inout)     :: access
            integer(kind=c_int),      intent(inout)     :: w
            integer(kind=c_int),      intent(inout)     :: h
            integer(kind=c_int)                         :: sdl_query_texture
        end function sdl_query_texture

        ! int SDL_RenderClear(SDL_Renderer *renderer)
        function sdl_render_clear(renderer) bind(c, name='SDL_RenderClear')
            import :: c_int, c_ptr
            type(c_ptr), intent(in), value :: renderer
            integer(kind=c_int)            :: sdl_render_clear
        end function sdl_render_clear

        ! int SDL_RenderCopy(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_Rect *srcrect, const SDL_Rect *dstrect)
        function sdl_render_copy(renderer, texture, src_rect, dst_rect) bind(c, name='SDL_RenderCopy')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),    intent(in), value :: renderer
            type(c_ptr),    intent(in), value :: texture
            type(sdl_rect), intent(in)        :: src_rect
            type(sdl_rect), intent(in)        :: dst_rect
            integer(kind=c_int)               :: sdl_render_copy
        end function sdl_render_copy

        ! int SDL_RenderCopyEx(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_Rect *srcrect, const SDL_Rect *dstrect, const double angle, const SDL_Point *center, const SDL_RendererFlip flip)
        function sdl_render_copy_ex(renderer, texture, src_rect, dst_rect, angle, center, flip) bind(c, name='SDL_RenderCopyEx')
            import :: c_double, c_int, c_ptr, sdl_point, sdl_rect
            type(c_ptr),         intent(in), value :: renderer
            type(c_ptr),         intent(in), value :: texture
            type(sdl_rect),      intent(in)        :: src_rect
            type(sdl_rect),      intent(in)        :: dst_rect
            real(kind=c_double), intent(in), value :: angle
            type(sdl_point),     intent(in)        :: center
            integer(kind=c_int), intent(in), value :: flip
            integer(kind=c_int)                    :: sdl_render_copy_ex
        end function sdl_render_copy_ex

        ! int SDL_RenderDrawLine(SDL_Renderer *renderer, int x1, int y1, int x2, int y2)
        function sdl_render_draw_line(renderer, x1, y1, x2, y2) bind(c, name='SDL_RenderDrawLine')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: renderer
            integer(kind=c_int), intent(in), value :: x1
            integer(kind=c_int), intent(in), value :: y1
            integer(kind=c_int), intent(in), value :: x2
            integer(kind=c_int), intent(in), value :: y2
            integer(kind=c_int)                    :: sdl_render_draw_line
        end function sdl_render_draw_line

        ! int SDL_RenderDrawLines(SDL_Renderer *renderer, const SDL_Point *points, int count)
        function sdl_render_draw_lines(renderer, points, count) bind(c, name='SDL_RenderDrawLines')
            import :: c_int, c_ptr, sdl_point
            type(c_ptr),         intent(in), value :: renderer
            type(sdl_point),     intent(in)        :: points(*)
            integer(kind=c_int), intent(in), value :: count
            integer(kind=c_int)                    :: sdl_render_draw_lines
        end function sdl_render_draw_lines

        ! int SDL_RenderDrawPoint(SDL_Renderer *renderer, int x, int y)
        function sdl_render_draw_point(renderer, x, y) bind(c, name='SDL_RenderDrawPoint')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: renderer
            integer(kind=c_int), intent(in), value :: x
            integer(kind=c_int), intent(in), value :: y
            integer(kind=c_int)                    :: sdl_render_draw_point
        end function sdl_render_draw_point

        ! int SDL_RenderDrawPoints(SDL_Renderer *renderer, const SDL_Point *points, int count)
        function sdl_render_draw_points(renderer, points, count) bind(c, name='SDL_RenderDrawPoints')
            import :: c_int, c_ptr, sdl_point
            type(c_ptr),         intent(in), value :: renderer
            type(sdl_point),     intent(in)        :: points(*)
            integer(kind=c_int), intent(in), value :: count
            integer(kind=c_int)                    :: sdl_render_draw_points
        end function sdl_render_draw_points

        ! int SDL_RenderDrawRect(SDL_Renderer *renderer, const SDL_Rect *rect)
        function sdl_render_draw_rect(renderer, rect) bind(c, name='SDL_RenderDrawRect')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),    intent(in), value :: renderer
            type(sdl_rect), intent(in)        :: rect
            integer(kind=c_int)               :: sdl_render_draw_rect
        end function sdl_render_draw_rect

        ! int SDL_RenderDrawRects(SDL_Renderer *renderer, const SDL_Rect *rects, int count)
        function sdl_render_draw_rects(renderer, rects, count) bind(c, name='SDL_RenderDrawRects')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),         intent(in), value :: renderer
            type(sdl_rect),      intent(in)        :: rects(*)
            integer(kind=c_int), intent(in), value :: count
            integer(kind=c_int)                    :: sdl_render_draw_rects
        end function sdl_render_draw_rects

        ! int SDL_RenderFillRect(SDL_Renderer *renderer, const SDL_Rect *rect)
        function sdl_render_fill_rect(renderer, rect) bind(c, name='SDL_RenderFillRect')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),    intent(in), value :: renderer
            type(sdl_rect), intent(in)        :: rect
            integer(kind=c_int)               :: sdl_render_fill_rect
        end function sdl_render_fill_rect

        ! int SDL_RenderFillRects(SDL_Renderer *renderer, const SDL_Rect *rects, int count)
        function sdl_render_fill_rects(renderer, rects, count) bind(c, name='SDL_RenderFillRects')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),         intent(in), value :: renderer
            type(sdl_rect),      intent(in)        :: rects(*)
            integer(kind=c_int), intent(in), value :: count
            integer(kind=c_int)                    :: sdl_render_fill_rects
        end function sdl_render_fill_rects

        ! int SDL_RenderReadPixels(SDL_Renderer *renderer, const SDL_Rect *rect, Uint32 format, void *pixels, int pitch)
        function sdl_render_read_pixels(renderer, rect, format, pixels, pitch) bind(c, name='SDL_RenderReadPixels')
            import :: c_int, c_ptr, c_uint32_t, sdl_rect
            type(c_ptr),              intent(in), value :: renderer
            type(sdl_rect),           intent(in)        :: rect
            integer(kind=c_uint32_t), intent(in), value :: format
            type(c_ptr),              intent(in), value :: pixels
            integer(kind=c_int),      intent(in), value :: pitch
            integer(kind=c_int)                         :: sdl_render_read_pixels
        end function sdl_render_read_pixels

        ! int SDL_RenderSetScale(SDL_Renderer *renderer, float scaleX, float scaleY)
        function sdl_render_set_scale(renderer, scale_x, scale_y) bind(c, name='SDL_RenderSetScale')
            import :: c_float, c_int, c_ptr
            type(c_ptr),        intent(in), value :: renderer
            real(kind=c_float), intent(in), value :: scale_x
            real(kind=c_float), intent(in), value :: scale_y
            integer(kind=c_int)                   :: sdl_render_set_scale
        end function sdl_render_set_scale

        ! int SDL_RenderSetViewport(SDL_Renderer *renderer, const SDL_Rect *rect)
        function sdl_render_set_viewport(renderer, rect) bind(c, name='SDL_RenderSetViewport')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),    intent(in), value :: renderer
            type(sdl_rect), intent(in)        :: rect
            integer(kind=c_int)               :: sdl_render_set_viewport
        end function sdl_render_set_viewport

        ! int SDL_SetRenderDrawBlendMode(SDL_Renderer *renderer, SDL_BlendMode blendMode)
        function sdl_set_render_draw_blend_mode(renderer, blend_mode) bind(c, name='SDL_SetRenderDrawBlendMode')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: renderer
            integer(kind=c_int), intent(in), value :: blend_mode
            integer(kind=c_int)                    :: sdl_set_render_draw_blend_mode
        end function sdl_set_render_draw_blend_mode

        ! int SDL_SetRenderDrawColor(SDL_Renderer *renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
        function sdl_set_render_draw_color(renderer, r, g, b, a) bind(c, name='SDL_SetRenderDrawColor')
            import :: c_int, c_ptr, c_uint8_t
            type(c_ptr),             intent(in), value :: renderer
            integer(kind=c_uint8_t), intent(in), value :: r
            integer(kind=c_uint8_t), intent(in), value :: g
            integer(kind=c_uint8_t), intent(in), value :: b
            integer(kind=c_uint8_t), intent(in), value :: a
            integer(kind=c_int)                         :: sdl_set_render_draw_color
        end function sdl_set_render_draw_color

        ! int SDL_SetRenderTarget(SDL_Renderer *renderer, SDL_Texture *texture)
        function sdl_set_render_target(renderer, texture) bind(c, name='SDL_SetRenderTarget')
            import :: c_int, c_ptr
            type(c_ptr),             intent(in), value :: renderer
            type(c_ptr),             intent(in), value :: texture
            integer(kind=c_int)                        :: sdl_set_render_target
        end function sdl_set_render_target

        ! int SDL_SetTextureColorMod(SDL_Texture *texture, Uint8 r, Uint8 g, Uint8 b)
        function sdl_set_texture_color_mod(texture, r, g, b) bind(c, name='SDL_SetTextureColorMod')
            import :: c_int, c_ptr, c_uint8_t
            type(c_ptr),             intent(in), value :: texture
            integer(kind=c_uint8_t), intent(in), value :: r
            integer(kind=c_uint8_t), intent(in), value :: g
            integer(kind=c_uint8_t), intent(in), value :: b
            integer(kind=c_int)                        :: sdl_set_texture_color_mod
        end function sdl_set_texture_color_mod

        ! int SDL_UpdateTexture(SDL_Texture *texture, const SDL_Rect *rect, void *pixels, int *pitch)
        function sdl_update_texture(texture, rect, pixels, pitch) bind(c, name='SDL_UpdateTexture')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),         intent(in), value :: texture
            type(sdl_rect),      intent(in)        :: rect
            type(c_ptr),         intent(in), value :: pixels
            integer(kind=c_int), intent(in)        :: pitch
            integer(kind=c_int)                    :: sdl_update_texture
        end function sdl_update_texture

        ! void SDL_DestroyRenderer(SDL_Renderer *renderer)
        subroutine sdl_destroy_renderer(renderer) bind(c, name='SDL_DestroyRenderer')
            import :: c_ptr
            type(c_ptr), intent(in), value :: renderer
        end subroutine sdl_destroy_renderer

        ! void SDL_DestroyTexture(SDL_Texture *texture)
        subroutine sdl_destroy_texture(texture) bind(c, name='SDL_DestroyTexture')
            import :: c_ptr
            type(c_ptr), intent(in), value :: texture
        end subroutine sdl_destroy_texture

        ! void SDL_RenderGetScale(SDL_Renderer *renderer, float *scaleX, float *scaleY)
        subroutine sdl_render_get_scale(renderer, scale_x, scale_y) bind(c, name='SDL_RenderGetScale')
            import :: c_float, c_ptr
            type(c_ptr),        intent(in), value :: renderer
            real(kind=c_float), intent(in)        :: scale_x
            real(kind=c_float), intent(in)        :: scale_y
        end subroutine sdl_render_get_scale

        ! void SDL_RenderGetViewport(SDL_Renderer *renderer, SDL_Rect *rect)
        subroutine sdl_render_get_viewport(renderer, rect) bind(c, name='SDL_RenderGetViewport')
            import :: c_int, c_ptr, sdl_rect
            type(c_ptr),    intent(in), value :: renderer
            type(sdl_rect), intent(inout)     :: rect
        end subroutine sdl_render_get_viewport

        ! void SDL_RenderPresent(SDL_Renderer *renderer)
        subroutine sdl_render_present(renderer) bind(c, name='SDL_RenderPresent')
            import :: c_ptr
            type(c_ptr), intent(in), value :: renderer
        end subroutine sdl_render_present

        ! void SDL_UnlockTexture(SDL_Texture *texture)
        subroutine sdl_unlock_texture(texture) bind(c, name='SDL_UnlockTexture')
            import :: c_int, c_ptr
            type(c_ptr), intent(in), value :: texture
        end subroutine sdl_unlock_texture
    end interface
end module sdl2_render
