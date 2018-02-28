! sdl2.f90
!
! SDL 2 interface for Fortran 2003/2008.
!
! Author:  Philipp Engel
! Licence: ISC
module sdl2_consts
    use, intrinsic :: iso_c_binding
    implicit none

    integer(kind=c_int), parameter :: sdl_windowpos_undefined_mask = z'1FFF0000'
    integer(kind=c_int), parameter :: sdl_windowpos_undefined      = ior(sdl_windowpos_undefined_mask, 0)

    integer(kind=c_int), parameter :: sdl_init_timer          = z'00000001'
    integer(kind=c_int), parameter :: sdl_init_audio          = z'00000010'
    integer(kind=c_int), parameter :: sdl_init_video          = z'00000020'
    integer(kind=c_int), parameter :: sdl_init_joystick       = z'00000200'
    integer(kind=c_int), parameter :: sdl_init_haptic         = z'00001000'
    integer(kind=c_int), parameter :: sdl_init_gamecontroller = z'00002000'
    integer(kind=c_int), parameter :: sdl_init_events         = z'00004000'
    integer(kind=c_int), parameter :: sdl_init_noparachute    = z'00010000'
    integer(kind=c_int), parameter :: sdl_init_everything     = ior(sdl_init_timer, &
                                                                    ior(sdl_init_video, &
                                                                    ior(sdl_init_video, &
                                                                    ior(sdl_init_joystick, &
                                                                    ior(sdl_init_haptic, &
                                                                    ior(sdl_init_gamecontroller, &
                                                                    ior(sdl_init_events, sdl_init_noparachute)))))))

    integer(kind=c_int), parameter :: sdl_window_fullscreen         = z'00000001'
    integer(kind=c_int), parameter :: sdl_window_opengl             = z'00000002'
    integer(kind=c_int), parameter :: sdl_window_shown              = z'00000004'
    integer(kind=c_int), parameter :: sdl_window_hidden             = z'00000008'
    integer(kind=c_int), parameter :: sdl_window_borderless         = z'00000010'
    integer(kind=c_int), parameter :: sdl_window_resizable          = z'00000020'
    integer(kind=c_int), parameter :: sdl_window_minimized          = z'00000040'
    integer(kind=c_int), parameter :: sdl_window_maximized          = z'00000080'
    integer(kind=c_int), parameter :: sdl_window_input_grabbed      = z'00000100'
    integer(kind=c_int), parameter :: sdl_window_input_focus        = z'00000200'
    integer(kind=c_int), parameter :: sdl_window_mouse_focus        = z'00000400'
    integer(kind=c_int), parameter :: sdl_window_fullscreen_desktop = ior(sdl_window_fullscreen, z'00001000')
    integer(kind=c_int), parameter :: sdl_window_foreign            = z'00000800'
    integer(kind=c_int), parameter :: sdl_window_allow_highdpi      = z'00002000'
    integer(kind=c_int), parameter :: sdl_window_mouse_capture      = z'00004000'
    integer(kind=c_int), parameter :: sdl_window_always_on_top      = z'00008000'
    integer(kind=c_int), parameter :: sdl_window_skip_taskbar       = z'00010000'
    integer(kind=c_int), parameter :: sdl_window_utility            = z'00020000'
    integer(kind=c_int), parameter :: sdl_window_tooltip            = z'00040000'
    integer(kind=c_int), parameter :: sdl_window_popup_menu         = z'00080000'
    integer(kind=c_int), parameter :: sdl_window_vulkan             = z'10000000'
end module sdl2_consts

module sdl2_types
    use, intrinsic :: iso_c_binding
    implicit none

    ! SDL_Rect
    type, bind(c) :: sdl_rect
        integer(kind=c_int) :: x
        integer(kind=c_int) :: y
        integer(kind=c_int) :: w
        integer(kind=c_int) :: h
    end type sdl_rect

    ! SDL_Color
    type, bind(c) :: sdl_color
        integer(kind=c_int) :: r
        integer(kind=c_int) :: g
        integer(kind=c_int) :: b
        integer(kind=c_int) :: a
    end type sdl_color

    ! SDL_Palette
    type, bind(c) :: sdl_palette
        integer(kind=c_int) :: ncolors
        type(c_ptr)         :: colors
        integer(kind=c_int) :: version
        integer(kind=c_int) :: refcount
    end type sdl_palette

    ! SDL_PixelFormat
    type, bind(c) :: sdl_pixel_format
        integer(kind=c_int)               :: format
        type(c_ptr)                       :: palette
        integer(kind=c_int)               :: bits_per_pixel
        integer(kind=c_int)               :: bytes_per_pixel
        integer(kind=c_int), dimension(2) :: padding
        integer(kind=c_int)               :: r_mask
        integer(kind=c_int)               :: g_mask
        integer(kind=c_int)               :: b_mask
        integer(kind=c_int)               :: a_mask
        integer(kind=c_int)               :: r_loss
        integer(kind=c_int)               :: g_loss
        integer(kind=c_int)               :: b_loss
        integer(kind=c_int)               :: a_loss
        integer(kind=c_int)               :: r_shift
        integer(kind=c_int)               :: g_shift
        integer(kind=c_int)               :: b_shift
        integer(kind=c_int)               :: a_shift
        integer(kind=c_int)               :: ref_count
        type(c_ptr)                       :: next
    end type sdl_pixel_format

    ! SDL_Surface
    type, bind(c) :: sdl_surface
        integer(kind=c_int)    :: flags
        type(c_ptr)            :: format
        integer(kind=c_int)    :: w
        integer(kind=c_int)    :: h
        integer(kind=c_int)    :: pitch
        type(c_ptr)            :: pixels
        type(c_ptr)            :: user_data
        integer(kind=c_int)    :: locked
        type(c_ptr)            :: locked_data
        type(sdl_rect)         :: clip_rect
        type(c_ptr)            :: map
        integer(kind=c_int)    :: ref_count
    end type sdl_surface
end module sdl2_types

module sdl2
    interface
        ! SDL_Window *SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags)
        function sdl_create_window(title, x, y, w, h, flags) bind(c, name='SDL_CreateWindow')
            use, intrinsic :: iso_c_binding
            implicit none
            character(kind=c_char), intent(in)        :: title
            integer(kind=c_int),    intent(in), value :: x
            integer(kind=c_int),    intent(in), value :: y
            integer(kind=c_int),    intent(in), value :: w
            integer(kind=c_int),    intent(in), value :: h
            integer(kind=c_int),    intent(in), value :: flags
            type(c_ptr)                               :: sdl_create_window
        end function sdl_create_window

        ! int SDL_FillRect(SDL_Surface *dst, const SDL_Rect *rect, Uint32 color)
        function sdl_fill_rect(dst, rect, color) bind(c, name='SDL_FillRect')
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            type(sdl_surface),   intent(in)        :: dst
            type(sdl_rect),      intent(in)        :: rect
            integer(kind=c_int), intent(in), value :: color
            integer(kind=c_int)                    :: sdl_fill_rect
        end function sdl_fill_rect

        ! const char *SDL_GetError(void)
        function sdl_get_error_() bind(c, name='SDL_GetError')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr) :: sdl_get_error_
        end function sdl_get_error_

        ! SDL_Surface *SDL_GetWindowSurface(SDL_Window *window)
        function sdl_get_window_surface_(window) bind(c, name='SDL_GetWindowSurface')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr), intent(in), value :: window
            type(c_ptr)                    :: sdl_get_window_surface_
        end function sdl_get_window_surface_

        ! int SDL_Init(Uint32 flags)
        function sdl_init(flags) bind(c, name='SDL_Init')
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int), intent(in), value :: flags
            integer(kind=c_int)                    :: sdl_init
        end function sdl_init

        ! SDL_Surface *SDL_LoadBMP_RW(SDL_RWops *src, int freesrc)
        function sdl_load_bmp_rw(src, free_src) bind(c, name='SDL_LoadBMP_RW')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr),         intent(in), value :: src
            integer(kind=c_int), intent(in), value :: free_src
            type(c_ptr)                            :: sdl_load_bmp_rw
        end function sdl_load_bmp_rw

        ! Uint32 SDL_MapRGB(const SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b)
        function sdl_map_rgb(format, r, g, b) bind(c, name='SDL_MapRGB')
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            type(sdl_pixel_format), intent(in)        :: format
            integer(kind=c_int),    intent(in), value :: r
            integer(kind=c_int),    intent(in), value :: g
            integer(kind=c_int),    intent(in), value :: b
            integer(kind=c_int)                       :: sdl_map_rgb
        end function sdl_map_rgb

        ! SDL_RWops *SDL_RWFromFile(const char *file, const char *mode)
        function sdl_rw_from_file(file, mode) bind(c, name='SDL_RWFromFile')
            use, intrinsic :: iso_c_binding
            implicit none
            character(kind=c_char), intent(in) :: file
            character(kind=c_char), intent(in) :: mode
            type(c_ptr)                        :: sdl_rw_from_file
        end function sdl_rw_from_file

        ! int SDL_UpdateWindowSurface(SDL_Window *window)
        function sdl_update_window_surface(window) bind(c, name='SDL_UpdateWindowSurface')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr), intent(in), value :: window
            integer(kind=c_int)            :: sdl_update_window_surface
        end function sdl_update_window_surface

        ! int SDL_UpperBlit(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect)
        function sdl_upper_blit(src, src_rect, dst, dst_rect) bind(c, name='SDL_UpperBlit')
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            type(sdl_surface), intent(in) :: src
            type(sdl_rect),    intent(in) :: src_rect
            type(sdl_surface), intent(in) :: dst
            type(sdl_rect),    intent(in) :: dst_rect
            integer(kind=c_int)           :: sdl_upper_blit
        end function sdl_upper_blit

        ! void SDL_Delay(Uint32 ms)
        subroutine sdl_delay(ms) bind(c, name='SDL_Delay')
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int), intent(in), value :: ms
        end subroutine sdl_delay

        ! void SDL_DestroyWindow(SDL_Window *window)
        subroutine sdl_destroy_window(window) bind(c, name='SDL_DestroyWindow')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr), intent(in), value :: window
        end subroutine sdl_destroy_window

        ! void SDL_FreeSurface(SDL_Surface *surface)
        subroutine sdl_free_surface(surface) bind(c, name='SDL_FreeSurface')
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            type(sdl_surface), intent(in) :: surface
        end subroutine sdl_free_surface

        ! void SDL_Quit(void)
        subroutine sdl_quit() bind(c, name='SDL_Quit')
        end subroutine sdl_quit
    end interface

    contains
        ! int SDL_BlitSurface(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect)
        function sdl_blit_surface(src, src_rect, dst, dst_rect)
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            type(sdl_surface), intent(in) :: src
            type(sdl_rect),    intent(in) :: src_rect
            type(sdl_surface), intent(in) :: dst
            type(sdl_rect),    intent(in) :: dst_rect
            integer(kind=c_int)           :: sdl_blit_surface

            sdl_blit_surface = sdl_upper_blit(src, src_rect, dst, dst_rect)
        end function sdl_blit_surface

        ! const char *SDL_GetError(void)
        function sdl_get_error()
            !! Converts C char pointer to Fortran character.
            use, intrinsic :: iso_c_binding
            implicit none
            character(len=100)                            :: sdl_get_error
            type(c_ptr)                                   :: ptr
            character(kind=c_char), pointer, dimension(:) :: ptrs
            integer                                       :: i

            ptr = sdl_get_error_()
            call c_f_pointer(ptr, ptrs, [ len(sdl_get_error) ])

            do i = 1, size(ptrs)
                sdl_get_error(i:i) = ptrs(i)
            end do
        end function sdl_get_error

        ! SDL_Surface *SDL_GetWindowSurface(SDL_Window *window)
        function sdl_get_window_surface(window)
            !! Calls `sdl_get_window_surface_()` and converts the result from
            !! `type(c_ptr)` to `type(sdl_surface)`.
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            type(c_ptr), intent(in)    :: window
            type(sdl_surface), pointer :: sdl_get_window_surface
            type(c_ptr)                :: ptr

            ptr = sdl_get_window_surface_(window)
            call c_f_pointer(ptr, sdl_get_window_surface)
        end function sdl_get_window_surface

        function sdl_get_pixel_format(surface)
            !! Converts a C pointer *SDL_PixelFormat to `type(sdl_pixel_format)`.
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            type(sdl_surface), intent(in)   :: surface
            type(sdl_pixel_format), pointer :: sdl_get_pixel_format

            call c_f_pointer(surface%format, sdl_get_pixel_format)
        end function

        ! SDL_Surface *SDL_LoadBMP(const char* file)
        function sdl_load_bmp(file)
            !! Calls `sdl_load_bmp_()` and converts the result from
            !! `type(c_ptr)` to `type(sdl_surface)`.
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            character(kind=c_char), intent(in) :: file
            type(sdl_surface), pointer         :: sdl_load_bmp
            type(c_ptr)                        :: ptr

            ptr = sdl_load_bmp_rw(sdl_rw_from_file(file, 'rb' // c_null_char), 1)
            call c_f_pointer(ptr, sdl_load_bmp)
        end function sdl_load_bmp
end module sdl2
