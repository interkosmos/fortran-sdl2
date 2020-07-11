! sdl2.f90
!
! Fortran 2008 interfaces to SDL 2.0.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2
    use, intrinsic :: iso_c_binding
    use :: c_util
    use :: sdl2_audio
    use :: sdl2_blendmode
    use :: sdl2_cpuinfo
    use :: sdl2_error
    use :: sdl2_events
    use :: sdl2_filesystem
    use :: sdl2_hints
    use :: sdl2_keyboard
    use :: sdl2_keycode
    use :: sdl2_log
    use :: sdl2_messagebox
    use :: sdl2_mouse
    use :: sdl2_opengl
    use :: sdl2_pixels
    use :: sdl2_platform
    use :: sdl2_rect
    use :: sdl2_render
    use :: sdl2_rwops
    use :: sdl2_scancode
    use :: sdl2_stdinc
    use :: sdl2_surface
    use :: sdl2_thread
    use :: sdl2_timer
    use :: sdl2_version
    use :: sdl2_video
    implicit none

    ! Public interfaces to SDL 2.0.
    public :: sdl_init
    public :: sdl_quit

    ! Public wrapper functions.
    public :: sdl_alloc_format
    public :: sdl_blit_scaled
    public :: sdl_blit_surface
    public :: sdl_convert_surface
    public :: sdl_create_rgb_surface
    public :: sdl_get_audio_driver
    public :: sdl_get_base_path
    public :: sdl_get_current_audio_driver
    public :: sdl_get_current_video_driver
    public :: sdl_get_error
    public :: sdl_get_hint
    public :: sdl_get_keyboard_state
    public :: sdl_get_platform
    public :: sdl_get_render_driver_info
    public :: sdl_get_ticks
    public :: sdl_get_video_driver
    public :: sdl_get_window_surface
    public :: sdl_get_window_title
    public :: sdl_load_bmp
    public :: sdl_map_rgb
    public :: sdl_map_rgba
    public :: sdl_poll_event
    public :: sdl_save_bmp
    public :: sdl_set_hint
    public :: sdl_upper_blit_scaled
    public :: sdl_wait_event

    ! Utility functions and routines.
    public :: sdl_get_pixel_format
    public :: uint8

    ! Generic interfaces.
    interface uint8
        procedure :: uint8_i2
        procedure :: uint8_i4
    end interface

    ! Function and routine interfaces to SDL 2.0.
    interface
        ! int SDL_Init(Uint32 flags)
        function sdl_init(flags) bind(c, name='SDL_Init')
            import :: c_int, c_uint32_t
            integer(kind=c_uint32_t), intent(in), value :: flags
            integer(kind=c_int)                         :: sdl_init
        end function sdl_init

        ! void SDL_Quit(void)
        subroutine sdl_quit() bind(c, name='SDL_Quit')
        end subroutine sdl_quit
    end interface
contains
    subroutine c_f_str_chars(c_str, f_str)
        !! Copies a C string, passed as a char-array reference, to a Fortran
        !! string.
        character(len=1, kind=c_char), intent(in)  :: c_str(*)
        character(len=*),              intent(out) :: f_str
        integer                                    :: i

        i = 1

        do while (c_str(i) /= c_null_char .and. i <= len(f_str))
            f_str(i:i) = c_str(i)
            i = i + 1
        end do

        if (i < len(f_str)) f_str(i:) = ' '
    end subroutine c_f_str_chars

    subroutine c_f_str_ptr(c_str, f_str)
        !! Copies a C string, passed as a C pointer, to a Fortran string.
        type(c_ptr),      intent(in)           :: c_str
        character(len=*), intent(out)          :: f_str
        character(kind=c_char, len=1), pointer :: char_ptrs(:)
        integer                                :: i

        if (c_associated(c_str)) then
            call c_f_pointer(c_str, char_ptrs, [huge(0)])

            i = 1

            do while (char_ptrs(i) /= c_null_char .and. i <= len(f_str))
                f_str(i:i) = char_ptrs(i)
                i = i + 1
            end do

            if (i < len(f_str)) f_str(i:) = ' '
        else
            f_str = ' '
        end if
    end subroutine c_f_str_ptr

    function sdl_alloc_format(pixel_format)
        !! Calls `sdl_alloc_format_()` and converts the returned C pointer to
        !! derived type `sdl_pixel_format`.
        integer, intent(in)             :: pixel_format
        type(sdl_pixel_format), pointer :: sdl_alloc_format
        type(c_ptr)                     :: ptr

        ptr = sdl_alloc_format_(pixel_format)
        call c_f_pointer(ptr, sdl_alloc_format)
    end function sdl_alloc_format

    ! int SDL_BlitScaled(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect)
    function sdl_blit_scaled(src, src_rect, dst, dst_rect)
        !! Macro for `sdl_upper_blit_scaled()`, as defined in `SDL_surface.h`.
        type(sdl_surface), intent(in) :: src
        type(sdl_rect),    intent(in) :: src_rect
        type(sdl_surface), intent(in) :: dst
        type(sdl_rect),    intent(in) :: dst_rect
        integer(kind=c_int)           :: sdl_blit_scaled

        sdl_blit_scaled = sdl_upper_blit_scaled(src, src_rect, dst, dst_rect)
    end function sdl_blit_scaled

    ! int SDL_BlitSurface(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect)
    function sdl_blit_surface(src, src_rect, dst, dst_rect)
        !! Macro for `sdl_upper_blit()`, as defined in `SDL_surface.h`.
        type(sdl_surface), intent(in) :: src
        type(sdl_rect),    intent(in) :: src_rect
        type(sdl_surface), intent(in) :: dst
        type(sdl_rect),    intent(in) :: dst_rect
        integer(kind=c_int)           :: sdl_blit_surface

        sdl_blit_surface = sdl_upper_blit(src, src_rect, dst, dst_rect)
    end function sdl_blit_surface

    ! SDL_Surface *SDL_ConvertSurface(SDL_Surface *src, const SDL_PixelFormat *fmt, Uint32 flags)
    function sdl_convert_surface(src, fmt, flags)
        !! Calls `sdl_convert_surface_()` and converts the returned
        !! C pointer to derived type `sdl_surface`.
        type(sdl_surface),        intent(in) :: src
        type(sdl_pixel_format),   intent(in) :: fmt
        integer(kind=c_uint32_t), intent(in) :: flags
        type(sdl_surface),        pointer    :: sdl_convert_surface
        type(c_ptr)                          :: ptr

        ptr = sdl_convert_surface_(src, fmt, flags)
        call c_f_pointer(ptr, sdl_convert_surface)
    end function sdl_convert_surface

    ! SDL_Surface *SDL_CreateRGBSurface(Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask)
    function sdl_create_rgb_surface(flags, width, height, depth, r_mask, g_mask, b_mask, a_mask)
        !! Calls `sdl_create_rgb_surface_()` and converts the returned
        !! C pointer to derived type `sdl_surface`.
        integer(kind=c_uint32_t), intent(in) :: flags
        integer(kind=c_int),      intent(in) :: width
        integer(kind=c_int),      intent(in) :: height
        integer(kind=c_int),      intent(in) :: depth
        integer(kind=c_int64_t),  intent(in) :: r_mask
        integer(kind=c_int64_t),  intent(in) :: g_mask
        integer(kind=c_int64_t),  intent(in) :: b_mask
        integer(kind=c_int64_t),  intent(in) :: a_mask
        type(sdl_surface), pointer           :: sdl_create_rgb_surface
        type(c_ptr)                          :: ptr

        ptr = sdl_create_rgb_surface_(flags, width, height, depth, r_mask, g_mask, b_mask, a_mask)
        call c_f_pointer(ptr, sdl_create_rgb_surface)
    end function sdl_create_rgb_surface

    ! const char *SDL_GetAudioDriver(int index)
    function sdl_get_audio_driver(index)
        !! Calls `sdl_get_audio_driver_()` and converts the returned
        !! C char pointer to Fortran character.
        integer(kind=c_int), intent(in) :: index
        type(c_ptr)                     :: ptr
        character(len=:), allocatable   :: sdl_get_audio_driver
        integer(kind=8)                 :: size

        ptr = sdl_get_audio_driver_(index)
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_audio_driver)
        call c_f_str_ptr(ptr, sdl_get_audio_driver)
    end function sdl_get_audio_driver

    ! char *SDL_GetBasePath(void)
    function sdl_get_base_path()
        !! Calls `sdl_get_base_path_()` and converts the returned
        !! C char pointer to Fortran character.
        type(c_ptr)                   :: ptr
        character(len=:), allocatable :: sdl_get_base_path
        integer(kind=8)               :: size

        ptr = sdl_get_base_path_()
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_base_path)
        call c_f_str_ptr(ptr, sdl_get_base_path)
        call sdl_free(ptr)
    end function sdl_get_base_path

    ! const char *SDL_GetCurrentAudioDriver(void)
    function sdl_get_current_audio_driver()
        !! Calls `sdl_get_current_audio_driver_()` and converts the returned
        !! C char pointer to Fortran character.
        type(c_ptr)                   :: ptr
        character(len=:), allocatable :: sdl_get_current_audio_driver
        integer(kind=8)               :: size

        ptr = sdl_get_current_audio_driver_()
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_current_audio_driver)
        call c_f_str_ptr(ptr, sdl_get_current_audio_driver)
    end function sdl_get_current_audio_driver

    ! const char *SDL_GetCurrentVideoDriver(void)
    function sdl_get_current_video_driver()
        !! Calls `sdl_get_current_video_driver_()` and converts the returned
        !! C char pointer to Fortran character.
        type(c_ptr)                   :: ptr
        character(len=:), allocatable :: sdl_get_current_video_driver
        integer(kind=8)               :: size

        ptr = sdl_get_current_video_driver_()
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_current_video_driver)
        call c_f_str_ptr(ptr, sdl_get_current_video_driver)
    end function sdl_get_current_video_driver

    ! const char *SDL_GetError(void)
    function sdl_get_error()
        !! Calls `sdl_get_error_()` and converts the returned
        !! C char pointer to Fortran character.
        character(len=:), allocatable :: sdl_get_error
        type(c_ptr)                   :: ptr
        integer(kind=8)               :: size

        ptr = sdl_get_error_()
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_error)
        call c_f_str_ptr(ptr, sdl_get_error)
    end function sdl_get_error

    ! const Uint8 *SDL_GetKeyboardState(int *numkeys)
    function sdl_get_keyboard_state()
        !! Calls `sdl_get_keyboard_state_()` and converts the returned
        !! C pointer to Fortran pointers.
        integer(kind=c_uint8_t), pointer :: sdl_get_keyboard_state(:)
        type(c_ptr)                      :: ptr

        ptr = sdl_get_keyboard_state_(c_null_ptr)
        if (.not. c_associated(ptr)) return
        call c_f_pointer(ptr, sdl_get_keyboard_state, shape=[244])
    end function sdl_get_keyboard_state

    ! const char *SDL_GetHint(const char *name)
    function sdl_get_hint(name)
        !! Calls `sdl_get_hint_()` and converts the returned
        !! C char pointer to Fortran character.
        character(len=*), intent(in)  :: name
        character(len=:), allocatable :: sdl_get_hint
        type(c_ptr)                   :: ptr
        integer(kind=8)               :: size

        ptr = sdl_get_hint_(name // c_null_char)
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_hint)
        call c_f_str_ptr(ptr, sdl_get_hint)
    end function sdl_get_hint

    function sdl_get_pixel_format(surface)
        !! Converts the `*SDL_PixelFormat` pointer inside `surface`
        !! to `sdl_pixel_format`.
        type(sdl_surface),      intent(in) :: surface
        type(sdl_pixel_format), pointer    :: sdl_get_pixel_format

        call c_f_pointer(surface%format, sdl_get_pixel_format)
    end function sdl_get_pixel_format

    ! const char *SDL_GetPlatform(void)
    function sdl_get_platform()
        !! Calls `sdl_get_platform_()` and converts the returned
        !! C char pointer to Fortran character.
        character(len=:), allocatable :: sdl_get_platform
        type(c_ptr)                   :: ptr
        integer(kind=8)               :: size

        ptr = sdl_get_platform_()
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_platform)
        call c_f_str_ptr(ptr, sdl_get_platform)
    end function sdl_get_platform

    ! const char *SDL_GetVideoDriver(int index)
    function sdl_get_video_driver(index)
        !! Calls `sdl_get_video_driver_()` and converts the returned
        !! C char pointer to Fortran character.
        integer,          intent(in)  :: index
        type(c_ptr)                   :: ptr
        character(len=:), allocatable :: sdl_get_video_driver
        integer(kind=8)               :: size

        ptr = sdl_get_video_driver_(index)
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_video_driver)
        call c_f_str_ptr(ptr, sdl_get_video_driver)
    end function sdl_get_video_driver

    ! SDL_Surface *SDL_GetWindowSurface(SDL_Window *window)
    function sdl_get_window_surface(window)
        !! Calls `sdl_get_window_surface_()` and converts the returned
        !! C pointer to derived type `sdl_surface`.
        type(c_ptr),       intent(in) :: window
        type(sdl_surface), pointer    :: sdl_get_window_surface
        type(c_ptr)                   :: ptr

        sdl_get_window_surface => null()
        ptr = sdl_get_window_surface_(window)
        if (.not. c_associated(ptr)) return
        call c_f_pointer(ptr, sdl_get_window_surface)
    end function sdl_get_window_surface

    ! const char *SDL_GetWindowTitle(SDL_Window *window)
    function sdl_get_window_title(window)
        !! Calls `sdl_get_window_title_()` and converts the returned
        !! C char pointer to Fortran character.
        type(c_ptr),      intent(in)  :: window
        type(c_ptr)                   :: ptr
        character(len=:), allocatable :: sdl_get_window_title
        integer(kind=8)               :: size

        ptr = sdl_get_window_title_(window)
        if (.not. c_associated(ptr)) return
        size = c_strlen(ptr)
        allocate (character(len=size) :: sdl_get_window_title)
        call c_f_str_ptr(ptr, sdl_get_window_title)
    end function sdl_get_window_title

    ! SDL_Surface *SDL_LoadBMP(const char *file)
    function sdl_load_bmp(file)
        !! Calls `sdl_load_bmp_rw()` and converts the returned
        !! C pointer to derived type `sdl_surface`.
        character(kind=c_char), intent(in) :: file
        type(sdl_surface),      pointer    :: sdl_load_bmp
        type(c_ptr)                        :: ptr

        ptr = sdl_load_bmp_rw(sdl_rw_from_file(file, 'rb' // c_null_char), 1)
        call c_f_pointer(ptr, sdl_load_bmp)
    end function sdl_load_bmp

    ! Uint32 SDL_MapRGB(const SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b)
    function sdl_map_rgb(format, r, g, b)
        !! Calls `sdl_map_rgb_()` with RGB values casted to `Uint8`.
        type(sdl_pixel_format) , intent(in) :: format
        integer,                 intent(in) :: r
        integer,                 intent(in) :: g
        integer,                 intent(in) :: b
        integer                             :: sdl_map_rgb

        sdl_map_rgb = sdl_map_rgb_(format, uint8(r), uint8(g), uint8(b))
    end function sdl_map_rgb

    ! Uint32 SDL_MapRGBA(const SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b, Uint8 a)
    function sdl_map_rgba(format, r, g, b, a)
        !! Calls `sdl_map_rgba_()` with RGBA values casted to `Uint8`.
        type(sdl_pixel_format) , intent(in) :: format
        integer,                 intent(in) :: r
        integer,                 intent(in) :: g
        integer,                 intent(in) :: b
        integer,                 intent(in) :: a
        integer                             :: sdl_map_rgba

        sdl_map_rgba = sdl_map_rgba_(format, uint8(r), uint8(g), uint8(b), uint8(a))
    end function sdl_map_rgba

    ! int SDL_PollEvent(SDL_Event *event)
    function sdl_poll_event(event)
        !! Calls `sdl_poll_event_()` and transfers the returned
        !! union to the respective event type.
        type(sdl_event), intent(inout) :: event
        integer                        :: sdl_poll_event

        sdl_poll_event = sdl_poll_event_(event)
        call sdl_transfer_event(event)
    end function sdl_poll_event

    ! int SDL_SaveBMP(SDL_Surface *surface, const char *file)
    function sdl_save_bmp(surface, file)
        type(sdl_surface),      intent(in) :: surface
        character(kind=c_char), intent(in) :: file
        integer                            :: sdl_save_bmp

        sdl_save_bmp = sdl_save_bmp_rw(surface, sdl_rw_from_file(file, 'wb' // c_null_char), 1)
    end function sdl_save_bmp

    ! SDL_bool SDL_SetHint(const char *name, const char *value)
    function sdl_set_hint(name, value)
        !! Adds `c_null_char` to name and value before calling
        !! `sdl_set_hint_()`.
        character(len=*), intent(in) :: name
        character(len=*), intent(in) :: value
        integer                      :: sdl_set_hint

        sdl_set_hint = sdl_set_hint_(name // c_null_char, value // c_null_char)
    end function sdl_set_hint

    ! int SDL_WaitEvent(SDL_Event *event)
    function sdl_wait_event(event)
        !! Calls `sdl_wait_event_()` and transfers the returned
        !! union to the respective event type.
        type(sdl_event), intent(inout) :: event
        integer                        :: sdl_wait_event

        sdl_wait_event = sdl_wait_event_(event)
        call sdl_transfer_event(event)
    end function sdl_wait_event

    pure function uint8_i2(i)
        !! Utility function that converts Fortran signed integer
        !! (2 bytes) to Uint8.
        integer(kind=2), intent(in) :: i
        integer(kind=c_int8_t)      :: uint8_i2

        uint8_i2 = transfer([i, 1_2], 1_c_int8_t)
    end function uint8_i2

    pure function uint8_i4(i)
        !! Utility function that converts Fortran signed integer
        !! (4 bytes) to Uint8.
        integer(kind=4), intent(in) :: i
        integer(kind=c_int8_t)      :: uint8_i4

        uint8_i4 = transfer([i, 1_4], 1_c_int8_t)
    end function uint8_i4

    subroutine sdl_transfer_event(event)
        !! Transfers a given event union to the respective event type
        !! (since there are no unions in Fortran).
        type(sdl_event), intent(inout) :: event

        select case (event%type)
            ! SDL_WindowEvent
            case (SDL_WINDOWEVENT)
                event%window = transfer(event, event%window)

            ! SDL_KeyboardEvent
            case (SDL_KEYDOWN : SDL_KEYUP)
                event%key = transfer(event, event%key)

            ! SDL_TextEditingEvent
            case (SDL_TEXTEDITING)
                event%edit = transfer(event, event%edit)

            ! SDL_TextInputEvent
            case (SDL_TEXTINPUT)
                event%text = transfer(event, event%text)

            ! SDL_MouseMotionEvent
            case (SDL_MOUSEMOTION)
                event%motion = transfer(event, event%motion)

            ! SDL_MouseButtonEvent
            case (SDL_MOUSEBUTTONDOWN : SDL_MOUSEBUTTONUP)
                event%button = transfer(event, event%button)

            ! SDL_MouseWheelEvent
            case (SDL_MOUSEWHEEL)
                event%wheel = transfer(event, event%wheel)

            ! SDL_JoyAxisEvent
            case (SDL_JOYAXISMOTION)
                event%j_axis = transfer(event, event%j_axis)

            ! SDL_JoyBallEvent
            case (SDL_JOYBALLMOTION)
                event%j_ball = transfer(event, event%j_ball)

            ! SDL_JoyHatEvent
            case (SDL_JOYHATMOTION)
                event%j_hat = transfer(event, event%j_hat)

            ! SDL_JoyButtonEvent
            case (SDL_JOYBUTTONDOWN : SDL_JOYBUTTONUP)
                event%j_button = transfer(event, event%j_button)

            ! SDL_JoyDeviceEvent
            case (SDL_JOYDEVICEADDED : SDL_JOYDEVICEREMOVED)
                event%j_device = transfer(event, event%j_device)

            ! SDL_ControllerAxisEvent
            case (SDL_CONTROLLERAXISMOTION)
                event%c_axis = transfer(event, event%c_axis)

            ! SDL_ControllerButtonEvent
            case (SDL_CONTROLLERBUTTONDOWN : SDL_CONTROLLERBUTTONUP)
                event%c_button = transfer(event, event%c_button)

            ! SDL_ControllerDeviceEvent
            case (SDL_CONTROLLERDEVICEADDED : SDL_CONTROLLERDEVICEREMAPPED)
                event%c_device = transfer(event, event%c_device)

            ! SDL_AudioDeviceEvent
            case (SDL_AUDIODEVICEADDED : SDL_AUDIODEVICEREMOVED)
                event%a_device = transfer(event, event%a_device)

            ! SDL_QuitEvent
            case (SDL_QUITEVENT)
                event%quit = transfer(event, event%quit)

            ! SDL_UserEvent
            case (SDL_USEREVENT)
                event%user = transfer(event, event%user)

            ! SDL_SysWMEvent
            case (SDL_SYSWMEVENT)
                event%sys_wm = transfer(event, event%sys_wm)

            ! SDL_TouchFingerEvent
            case (SDL_FINGERDOWN : SDL_FINGERMOTION)
                event%t_finger = transfer(event, event%t_finger)

            ! SDL_MultiGestureEvent
            case (SDL_MULTIGESTURE)
                event%m_gesture = transfer(event, event%m_gesture)

            ! SDL_DollarGestureEvent
            case (SDL_DOLLARGESTURE : SDL_DOLLARRECORD)
                event%d_gesture = transfer(event, event%d_gesture)

            ! SDL_DropEvent
            case (SDL_DROPFILE : SDL_DROPCOMPLETE)
                event%drop = transfer(event, event%drop)
        end select
    end subroutine sdl_transfer_event
end module sdl2
