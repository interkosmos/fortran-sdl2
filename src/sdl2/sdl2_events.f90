! sdl2_events.f90
!
! Fortran 2008 interfaces to SDL_events.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_events
    use sdl2_c_types, only: c_ptr, c_char, c_int, c_uint8_t, c_uint16_t, c_uint32_t, c_int16_t, c_int32_t, c_int64_t, c_float
    implicit none
    private

    ! SDL_EventType
    integer(kind=c_int), parameter, public :: SDL_FIRSTEVENT               = 0
    integer(kind=c_int), parameter, public :: SDL_QUITEVENT                = int(z'100')
    integer(kind=c_int), parameter, public :: SDL_APP_TERMINATING          = int(z'101')
    integer(kind=c_int), parameter, public :: SDL_APP_LOWMEMORY            = int(z'102')
    integer(kind=c_int), parameter, public :: SDL_APP_WILLENTERBACKGROUND  = int(z'103')
    integer(kind=c_int), parameter, public :: SDL_APP_DIDENTERBACKGROUND   = int(z'104')
    integer(kind=c_int), parameter, public :: SDL_APP_WILLENTERFOREGROUND  = int(z'105')
    integer(kind=c_int), parameter, public :: SDL_APP_DIDENTERFOREGROUND   = int(z'106')
    integer(kind=c_int), parameter, public :: SDL_WINDOWEVENT              = int(z'200')
    integer(kind=c_int), parameter, public :: SDL_SYSWMEVENT               = int(z'201')
    integer(kind=c_int), parameter, public :: SDL_KEYDOWN                  = int(z'300')
    integer(kind=c_int), parameter, public :: SDL_KEYUP                    = int(z'301')
    integer(kind=c_int), parameter, public :: SDL_TEXTEDITING              = int(z'302')
    integer(kind=c_int), parameter, public :: SDL_TEXTINPUT                = int(z'303')
    integer(kind=c_int), parameter, public :: SDL_KEYMAPCHANGED            = int(z'304')
    integer(kind=c_int), parameter, public :: SDL_MOUSEMOTION              = int(z'400')
    integer(kind=c_int), parameter, public :: SDL_MOUSEBUTTONDOWN          = int(z'401')
    integer(kind=c_int), parameter, public :: SDL_MOUSEBUTTONUP            = int(z'402')
    integer(kind=c_int), parameter, public :: SDL_MOUSEWHEEL               = int(z'403')
    integer(kind=c_int), parameter, public :: SDL_JOYAXISMOTION            = int(z'600')
    integer(kind=c_int), parameter, public :: SDL_JOYBALLMOTION            = int(z'601')
    integer(kind=c_int), parameter, public :: SDL_JOYHATMOTION             = int(z'602')
    integer(kind=c_int), parameter, public :: SDL_JOYBUTTONDOWN            = int(z'603')
    integer(kind=c_int), parameter, public :: SDL_JOYBUTTONUP              = int(z'604')
    integer(kind=c_int), parameter, public :: SDL_JOYDEVICEADDED           = int(z'605')
    integer(kind=c_int), parameter, public :: SDL_JOYDEVICEREMOVED         = int(z'606')
    integer(kind=c_int), parameter, public :: SDL_CONTROLLERAXISMOTION     = int(z'650')
    integer(kind=c_int), parameter, public :: SDL_CONTROLLERBUTTONDOWN     = int(z'651')
    integer(kind=c_int), parameter, public :: SDL_CONTROLLERBUTTONUP       = int(z'652')
    integer(kind=c_int), parameter, public :: SDL_CONTROLLERDEVICEADDED    = int(z'653')
    integer(kind=c_int), parameter, public :: SDL_CONTROLLERDEVICEREMOVED  = int(z'654')
    integer(kind=c_int), parameter, public :: SDL_CONTROLLERDEVICEREMAPPED = int(z'655')
    integer(kind=c_int), parameter, public :: SDL_FINGERDOWN               = int(z'700')
    integer(kind=c_int), parameter, public :: SDL_FINGERUP                 = int(z'701')
    integer(kind=c_int), parameter, public :: SDL_FINGERMOTION             = int(z'702')
    integer(kind=c_int), parameter, public :: SDL_DOLLARGESTURE            = int(z'800')
    integer(kind=c_int), parameter, public :: SDL_DOLLARRECORD             = int(z'801')
    integer(kind=c_int), parameter, public :: SDL_MULTIGESTURE             = int(z'802')
    integer(kind=c_int), parameter, public :: SDL_CLIPBOARDUPDATE          = int(z'900')
    integer(kind=c_int), parameter, public :: SDL_DROPFILE                 = int(z'1000')
    integer(kind=c_int), parameter, public :: SDL_DROPTEXT                 = int(z'1001')
    integer(kind=c_int), parameter, public :: SDL_DROPBEGIN                = int(z'1002')
    integer(kind=c_int), parameter, public :: SDL_DROPCOMPLETE             = int(z'1003')
    integer(kind=c_int), parameter, public :: SDL_AUDIODEVICEADDED         = int(z'1100')
    integer(kind=c_int), parameter, public :: SDL_AUDIODEVICEREMOVED       = int(z'1101')
    integer(kind=c_int), parameter, public :: SDL_RENDERTARGETSRESET       = int(z'2000')
    integer(kind=c_int), parameter, public :: SDL_RENDERDEVICERESET        = int(z'2001')
    integer(kind=c_int), parameter, public :: SDL_USEREVENT                = int(z'8000')
    integer(kind=c_int), parameter, public :: SDL_LASTEVEMT                = int(z'FFFF')

    ! SDL_CommonEvent
    type, public, bind(c) :: sdl_common_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
    end type sdl_common_event

    ! SDL_WindowEvent
    type, public, bind(c) :: sdl_window_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        integer(kind=c_uint8_t)  :: event
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
        integer(kind=c_uint8_t)  :: padding3
        integer(kind=c_int32_t)  :: data1
        integer(kind=c_int32_t)  :: data2
    end type sdl_window_event

    ! SDL_Keysym
    type, public, bind(c) :: sdl_key_sym
        integer(kind=c_int)      :: scan_code
        integer(kind=c_int32_t)  :: sym
        integer(kind=c_uint16_t) :: mod
        integer(kind=c_uint32_t) :: unused
    end type sdl_key_sym

    ! SDL_KeyboardEvent
    type, public, bind(c) :: sdl_keyboard_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        integer(kind=c_uint8_t)  :: state
        integer(kind=c_uint8_t)  :: repeat
        integer(kind=c_uint8_t)  :: padding2
        integer(kind=c_uint8_t)  :: padding3
        type(sdl_key_sym)        :: key_sym
    end type sdl_keyboard_event

    ! SDL_TextEditingEvent
    type, public, bind(c) :: sdl_text_editing_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        character(kind=c_char)   :: text(32)
        integer(kind=c_int32_t)  :: start
        integer(kind=c_int32_t)  :: length
    end type sdl_text_editing_event

    ! SDL_TextInputEvent
    type, public, bind(c) :: sdl_text_input_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        character(kind=c_char)   :: text(32)
    end type sdl_text_input_event

    ! SDL_MouseMotionEvent
    type, public, bind(c) :: sdl_mouse_motion_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        integer(kind=c_uint32_t) :: which
        integer(kind=c_uint32_t) :: state
        integer(kind=c_int32_t)  :: x
        integer(kind=c_int32_t)  :: y
        integer(kind=c_int32_t)  :: x_rel
        integer(kind=c_int32_t)  :: y_rel
    end type sdl_mouse_motion_event

    ! SDL_MouseButtonEvent
    type, public, bind(c) :: sdl_mouse_button_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        integer(kind=c_uint32_t) :: which
        integer(kind=c_uint8_t)  :: button
        integer(kind=c_uint8_t)  :: state
        integer(kind=c_uint8_t)  :: clicks
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_int32_t)  :: x
        integer(kind=c_int32_t)  :: y
    end type sdl_mouse_button_event

    ! SDL_MouseWheelEvent
    type, public, bind(c) :: sdl_mouse_wheel_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        integer(kind=c_uint32_t) :: which
        integer(kind=c_int32_t)  :: x
        integer(kind=c_int32_t)  :: y
        integer(kind=c_uint32_t) :: direction
    end type sdl_mouse_wheel_event

    ! SDL_JoyAxisEvent
    type, public, bind(c) :: sdl_joy_axis_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
        integer(kind=c_uint8_t)  :: axis
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
        integer(kind=c_uint8_t)  :: padding3
        integer(kind=c_int16_t)  :: value
        integer(kind=c_uint16_t) :: padding4
    end type sdl_joy_axis_event

    ! SDL_JoyBallEvent
    type, public, bind(c) :: sdl_joy_ball_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
        integer(kind=c_uint8_t)  :: ball
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
        integer(kind=c_uint8_t)  :: padding3
        integer(kind=c_int16_t)  :: x_rel
        integer(kind=c_int16_t)  :: y_rel
    end type sdl_joy_ball_event

    ! SDL_JoyHatEvent
    type, public, bind(c) :: sdl_joy_hat_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
        integer(kind=c_uint8_t)  :: hat
        integer(kind=c_uint8_t)  :: value
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
    end type sdl_joy_hat_event

    ! SDL_JoyButtonEvent
    type, public, bind(c) :: sdl_joy_button_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
        integer(kind=c_uint8_t)  :: button
        integer(kind=c_uint8_t)  :: state
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
    end type sdl_joy_button_event

    ! SDL_JoyDeviceEvent
    type, public, bind(c) :: sdl_joy_device_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
    end type sdl_joy_device_event

    ! SDL_ControllerAxisEvent
    type, public, bind(c) :: sdl_controller_axis_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
        integer(kind=c_uint8_t)  :: axis
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
        integer(kind=c_uint8_t)  :: padding3
        integer(kind=c_int16_t)  :: value
        integer(kind=c_uint16_t) :: padding4
    end type sdl_controller_axis_event

    ! SDL_ControllerButtonEvent
    type, public, bind(c) :: sdl_controller_button_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
        integer(kind=c_uint8_t)  :: button
        integer(kind=c_uint8_t)  :: state
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
    end type sdl_controller_button_event

    ! SDL_ControllerDeviceEvent
    type, public, bind(c) :: sdl_controller_device_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
    end type sdl_controller_device_event

    ! SDL_AudioDeviceEvent
    type, public, bind(c) :: sdl_audio_device_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int32_t)  :: which
        integer(kind=c_uint8_t)  :: is_capture
        integer(kind=c_uint8_t)  :: padding1
        integer(kind=c_uint8_t)  :: padding2
        integer(kind=c_uint8_t)  :: padding3
    end type sdl_audio_device_event

    ! SDL_TouchFingerEvent
    type, public, bind(c) :: sdl_touch_finger_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int64_t)  :: touch_id
        integer(kind=c_int64_t)  :: finger_id
        real(kind=c_float)       :: x
        real(kind=c_float)       :: y
        real(kind=c_float)       :: dx
        real(kind=c_float)       :: dy
        real(kind=c_float)       :: pressure
    end type sdl_touch_finger_event

    ! SDL_MultiGestureEvent
    type, public, bind(c) :: sdl_multi_gesture_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int64_t)  :: touch_id
        real(kind=c_float)       :: d_theta
        real(kind=c_float)       :: d_dist
        real(kind=c_float)       :: x
        real(kind=c_float)       :: y
        integer(kind=c_uint16_t) :: num_fingers
        integer(kind=c_uint16_t) :: padding
    end type sdl_multi_gesture_event

    ! SDL_DollarGestureEvent
    type, public, bind(c) :: sdl_dollar_gesture_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_int64_t)  :: touch_id
        integer(kind=c_int64_t)  :: gesture_id
        integer(kind=c_uint32_t) :: num_fingers
        real(kind=c_float)       :: error
        real(kind=c_float)       :: x
        real(kind=c_float)       :: y
    end type sdl_dollar_gesture_event

    ! SDL_DropEvent
    type, public, bind(c) :: sdl_drop_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        type(c_ptr)              :: file
        integer(kind=c_uint32_t) :: window_id
    end type sdl_drop_event

    ! SDL_QuitEvent
    type, public, bind(c) :: sdl_quit_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
    end type sdl_quit_event

    ! SDL_OSEvent
    type, public, bind(c) :: sdl_os_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
    end type sdl_os_event

    ! SDL_UserEvent
    type, public, bind(c) :: sdl_user_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        integer(kind=c_uint32_t) :: window_id
        integer(kind=c_int32_t)  :: code
        type(c_ptr)              :: data1
        type(c_ptr)              :: data2
    end type sdl_user_event

    ! SDL_SysWMEvent
    type, public, bind(c) :: sdl_sys_wm_event
        integer(kind=c_uint32_t) :: type
        integer(kind=c_uint32_t) :: timestamp
        type(c_ptr)              :: msg
    end type sdl_sys_wm_event

    ! SDL_Event
    type, public, bind(c) :: sdl_event
        integer(kind=c_uint32_t)          :: type
        type(sdl_common_event)            :: common
        type(sdl_window_event)            :: window
        type(sdl_keyboard_event)          :: key
        type(sdl_text_editing_event)      :: edit
        type(sdl_text_input_event)        :: text
        type(sdl_mouse_motion_event)      :: motion
        type(sdl_mouse_button_event)      :: button
        type(sdl_mouse_wheel_event)       :: wheel
        type(sdl_joy_axis_event)          :: j_axis
        type(sdl_joy_ball_event)          :: j_ball
        type(sdl_joy_hat_event)           :: j_hat
        type(sdl_joy_button_event)        :: j_button
        type(sdl_joy_device_event)        :: j_device
        type(sdl_controller_axis_event)   :: c_axis
        type(sdl_controller_button_event) :: c_button
        type(sdl_controller_device_event) :: c_device
        type(sdl_audio_device_event)      :: a_device
        type(sdl_quit_event)              :: quit
        type(sdl_user_event)              :: user
        type(sdl_sys_wm_event)            :: sys_wm
        type(sdl_touch_finger_event)      :: t_finger
        type(sdl_multi_gesture_event)     :: m_gesture
        type(sdl_dollar_gesture_event)    :: d_gesture
        type(sdl_drop_event)              :: drop
        integer(kind=c_uint8_t)           :: padding(56)
    end type sdl_event

    public :: sdl_poll_event_
    public :: sdl_pump_events
    public :: sdl_wait_event_

    interface
        ! int SDL_PollEvent(SDL_Event *event)
        function sdl_poll_event_(event) bind(c, name='SDL_PollEvent')
            import :: c_int, sdl_event
            type(sdl_event), intent(inout) :: event
            integer(kind=c_int)            :: sdl_poll_event_
        end function sdl_poll_event_

        ! int SDL_WaitEvent(SDL_Event *event)
        function sdl_wait_event_(event) bind(c, name='SDL_WaitEvent')
            import :: c_int, sdl_event
            type(sdl_event), intent(inout) :: event
            integer(kind=c_int)            :: sdl_wait_event_
        end function sdl_wait_event_

        ! void SDL_PumpEvents(void)
        subroutine sdl_pump_events() bind(c, name='SDL_PumpEvents')
        end subroutine sdl_pump_events
    end interface
end module sdl2_events
