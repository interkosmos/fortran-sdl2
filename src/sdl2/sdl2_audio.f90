! sdl2_audio.f90
!
! Fortran 2008 interfaces to SDL_audio.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_audio
    use, intrinsic :: iso_c_binding, only: c_int, c_ptr
    implicit none

    public :: sdl_get_audio_driver_
    public :: sdl_get_current_audio_driver_
    public :: sdl_get_num_audio_devices

    interface
        ! const char *SDL_GetAudioDriver(int index)
        function sdl_get_audio_driver_(index) bind(c, name='SDL_GetAudioDriver')
            import :: c_int, c_ptr
            integer(kind=c_int), intent(in) :: index
            type(c_ptr)                     :: sdl_get_audio_driver_
        end function sdl_get_audio_driver_

        ! const char *SDL_GetCurrentAudioDriver(void)
        function sdl_get_current_audio_driver_() bind(c, name='SDL_GetCurrentAudioDriver')
            import :: c_ptr
            type(c_ptr) :: sdl_get_current_audio_driver_
        end function sdl_get_current_audio_driver_

        ! int SDL_GetNumAudioDevices(int iscapture)
        function sdl_get_num_audio_devices(is_capture) bind(c, name='SDL_GetNumAudioDevices')
            import :: c_int
            integer(kind=c_int), intent(in) :: is_capture
            integer(kind=c_int)             :: sdl_get_num_audio_devices
        end function sdl_get_num_audio_devices
    end interface
end module sdl2_audio
