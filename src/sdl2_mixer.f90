! sdl2_mixer.f90
!
! Fortran 2008 interfaces to SDL2_mixer.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_mixer
    use :: sdl2_c_types, only: c_char, c_int, c_int16_t, c_int64_t, c_null_char, c_ptr, c_uint32_t
    use :: sdl2_rwops,   only: sdl_rw_from_file
    implicit none

    integer(kind=c_int), parameter, public :: AUDIO_U8     = int(z'0008')
    integer(kind=c_int), parameter, public :: AUDIO_S8     = int(z'8008')
    integer(kind=c_int), parameter, public :: AUDIO_U16LSB = int(z'0010')
    integer(kind=c_int), parameter, public :: AUDIO_S16LSB = int(z'8010')
    integer(kind=c_int), parameter, public :: AUDIO_U16MSB = int(z'1010')
    integer(kind=c_int), parameter, public :: AUDIO_S16MSB = int(z'9010')
    integer(kind=c_int), parameter, public :: AUDIO_U16    = AUDIO_U16LSB
    integer(kind=c_int), parameter, public :: AUDIO_S16    = AUDIO_S16LSB

    integer(kind=c_int), parameter, public :: AUDIO_S32LSB = int(z'8020')
    integer(kind=c_int), parameter, public :: AUDIO_S32MSB = int(z'9020')
    integer(kind=c_int), parameter, public :: AUDIO_S32    = AUDIO_S32LSB

    integer(kind=c_int), parameter, public :: AUDIO_F32LSB = int(z'8120')
    integer(kind=c_int), parameter, public :: AUDIO_F32MSB = int(z'9120')
    integer(kind=c_int), parameter, public :: AUDIO_F32    = AUDIO_F32LSB

    integer(kind=c_int), parameter, public :: SDL_AUDIO_ALLOW_FREQUENCY_CHANGE = int(z'00000001')
    integer(kind=c_int), parameter, public :: SDL_AUDIO_ALLOW_FORMAT_CHANGE    = int(z'00000002')
    integer(kind=c_int), parameter, public :: SDL_AUDIO_ALLOW_CHANNELS_CHANGE  = int(z'00000002')
    integer(kind=c_int), parameter, public :: SDL_AUDIO_ALLOW_ANY_CHANGE       = ior(SDL_AUDIO_ALLOW_FREQUENCY_CHANGE, &
                                                                                     ior(SDL_AUDIO_ALLOW_FORMAT_CHANGE, &
                                                                                         SDL_AUDIO_ALLOW_CHANNELS_CHANGE))

    integer(kind=c_int), parameter, public :: MIX_INIT_FLAC = int(z'00000001')
    integer(kind=c_int), parameter, public :: MIX_INIT_MOD  = int(z'00000002')
    integer(kind=c_int), parameter, public :: MIX_INIT_MP3  = int(z'00000008')
    integer(kind=c_int), parameter, public :: MIX_INIT_OGG  = int(z'00000010')
    integer(kind=c_int), parameter, public :: MIX_INIT_MID  = int(z'00000020')
    integer(kind=c_int), parameter, public :: MIX_INIT_OPUS = int(z'00000040')

    integer(kind=c_int), parameter, public :: MIX_CHANNELS          = 8
    integer(kind=c_int), parameter, public :: MIX_DEFAULT_FREQUENCY = 22050
    integer(kind=c_int), parameter, public :: MIX_DEFAULT_CHANNELS  = 2
    integer(kind=c_int), parameter, public :: MIX_MAX_VOLUME        = 128

    type, public, bind(c) :: mix_chunk
        integer(kind=c_int)     :: allocated
        type(c_ptr)             :: abuf
        integer(kind=c_int64_t) :: alen
        integer(kind=c_int16_t) :: volume
    end type mix_chunk

    interface
        ! int Mix_AllocateChannels(int numchans)
        function mix_allocate_channels(num_chans) bind(c, name='Mix_AllocateChannels')
            import :: c_int
            integer(kind=c_int), intent(in), value :: num_chans
            integer(kind=c_int)                    :: mix_allocate_channels
        end function mix_allocate_channels

        ! int Mix_Init(int flags)
        function mix_init(flags) bind(c, name='Mix_Init')
            import :: c_int
            integer(kind=c_int), intent(in), value :: flags
            integer(kind=c_int)                    :: mix_init
        end function mix_init

        ! Mix_Chunk *Mix_LoadWAV_RW(SDL_RWops *src, int freesrc)
        function mix_load_wav_rw(src, free_src) bind(c, name='Mix_LoadWAV_RW')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: src
            integer(kind=c_int), intent(in), value :: free_src
            type(c_ptr)                            :: mix_load_wav_rw
        end function mix_load_wav_rw

        ! Mix_Music *Mix_LoadMUS(const char *file)
        function mix_load_mus(file) bind(c, name='Mix_LoadMUS')
            import :: c_char, c_ptr
            character(kind=c_char), intent(in) :: file
            type(c_ptr)                        :: mix_load_mus
        end function mix_load_mus

        ! int Mix_OpenAudio(int frequency, Uint16 format, int channels, int chunksize)
        function mix_open_audio(frequency, format, channels, chunk_size) bind(c, name='Mix_OpenAudio')
            import :: c_int, c_uint32_t
            integer(kind=c_int),      intent(in), value :: frequency
            integer(kind=c_uint32_t), intent(in), value :: format
            integer(kind=c_int),      intent(in), value :: channels
            integer(kind=c_int),      intent(in), value :: chunk_size
            integer(kind=c_int)                         :: mix_open_audio
        end function mix_open_audio

        ! int Mix_PlayChannelTimed(int channel, Mix_Chunk *chunk, int loops, int ticks)
        function mix_play_channel_timed(channel, chunk, loops, ticks) bind(c, name='Mix_PlayChannelTimed')
            import :: c_int, c_ptr
            integer(kind=c_int), intent(in), value :: channel
            type(c_ptr),         intent(in), value :: chunk
            integer(kind=c_int), intent(in), value :: loops
            integer(kind=c_int), intent(in), value :: ticks
            integer(kind=c_int)                    :: mix_play_channel_timed
        end function mix_play_channel_timed

        ! int Mix_PlayMusic(Mix_Music *music, int loops)
        function mix_play_music(music, loops) bind(c, name='Mix_PlayMusic')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: music
            integer(kind=c_int), intent(in), value :: loops
            integer(kind=c_int)                    :: mix_play_music
        end function mix_play_music

        ! int Mix_Playing(int channel)
        function mix_playing(channel) bind(c, name='Mix_Playing')
            import :: c_int
            integer(kind=c_int), intent(in), value :: channel
            integer(kind=c_int)                    :: mix_playing
        end function mix_playing

        ! int Mix_PlayingMusic(void)
        function mix_playing_music() bind(c, name='Mix_PlayingMusic')
            import :: c_int
            integer(kind=c_int) :: mix_playing_music
        end function mix_playing_music

        ! int Mix_VolumeChunk(Mix_Chunk *chunk, int volume)
        function mix_volume_chunk(chunk, volume) bind(c, name='Mix_VolumeChunk')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: chunk
            integer(kind=c_int), intent(in), value :: volume
            integer(kind=c_int)                    :: mix_volume_chunk
        end function mix_volume_chunk

        ! int Mix_VolumeMusic(Mix_Music *music, int volume)
        function mix_volume_music(music, volume) bind(c, name='Mix_VolumeMusic')
            import :: c_int, c_ptr
            type(c_ptr),         intent(in), value :: music
            integer(kind=c_int), intent(in), value :: volume
            integer(kind=c_int)                    :: mix_volume_music
        end function mix_volume_music

        ! void Mix_CloseAudio(void)
        subroutine mix_close_audio() bind(c, name='Mix_CloseAudio')
        end subroutine mix_close_audio

        ! void Mix_FreeChunk(Mix_Chunk *chunk)
        subroutine mix_free_chunk(chunk) bind(c, name='Mix_FreeChunk')
            import :: c_ptr
            type(c_ptr), intent(in), value :: chunk
        end subroutine mix_free_chunk

        ! void Mix_FreeMusic(Mix_Chunk *chunk)
        subroutine mix_free_music(music) bind(c, name='Mix_FreeMusic')
            import :: c_ptr
            type(c_ptr), intent(in), value :: music
        end subroutine mix_free_music

        ! void Mix_Quit()
        subroutine mix_quit() bind(c, name='Mix_Quit')
        end subroutine mix_quit
    end interface
contains
    function mix_load_wav(file)
        use :: sdl2
        character(kind=c_char), intent(in) :: file
        type(c_ptr)                        :: mix_load_wav

        mix_load_wav = mix_load_wav_rw(sdl_rw_from_file(file, 'rb' // c_null_char), 1)
    end function mix_load_wav

    function mix_play_channel(channel, chunk, loops)
        integer(kind=c_int), intent(in), value :: channel
        type(c_ptr),         intent(in), value :: chunk
        integer(kind=c_int), intent(in), value :: loops
        integer(kind=c_int)                    :: mix_play_channel

        mix_play_channel = mix_play_channel_timed(channel, chunk, loops, -1)
    end function mix_play_channel
end module sdl2_mixer
