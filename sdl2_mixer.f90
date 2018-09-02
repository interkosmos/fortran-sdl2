! sdl2_mixer.f90
!
! SDL2_mixer interface for Fortran 2003/2008.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
module sdl2_mixer
    use, intrinsic :: iso_c_binding
    implicit none

    integer(kind=c_int), parameter :: audio_u8     = z'0008'
    integer(kind=c_int), parameter :: audio_s8     = z'8008'
    integer(kind=c_int), parameter :: audio_u16lsb = z'0010'
    integer(kind=c_int), parameter :: audio_s16lsb = z'8010'
    integer(kind=c_int), parameter :: audio_u16msb = z'1010'
    integer(kind=c_int), parameter :: audio_s16msb = z'9010'
    integer(kind=c_int), parameter :: audio_u16    = audio_u16lsb
    integer(kind=c_int), parameter :: audio_s16    = audio_s16lsb

    integer(kind=c_int), parameter :: audio_s32lsb = z'8020'
    integer(kind=c_int), parameter :: audio_s32msb = z'9020'
    integer(kind=c_int), parameter :: audio_s32    = audio_s32lsb

    integer(kind=c_int), parameter :: audio_f32lsb = z'8120'
    integer(kind=c_int), parameter :: audio_f32msb = z'9120'
    integer(kind=c_int), parameter :: audio_f32    = audio_f32lsb

    integer(kind=c_int), parameter :: sdl_audio_allow_frequency_change = z'00000001'
    integer(kind=c_int), parameter :: sdl_audio_allow_format_change    = z'00000002'
    integer(kind=c_int), parameter :: sdl_audio_allow_channels_change  = z'00000002'
    integer(kind=c_int), parameter :: sdl_audio_allow_any_change       = ior(sdl_audio_allow_frequency_change, &
                                                                             ior(sdl_audio_allow_format_change, &
                                                                                 sdl_audio_allow_channels_change))

    integer(kind=c_int), parameter :: mix_channels          = 8
    integer(kind=c_int), parameter :: mix_default_frequency = 22050
    integer(kind=c_int), parameter :: mix_default_channels  = 2
    integer(kind=c_int), parameter :: mix_max_volume        = 128

    type, bind(c) :: mix_chunk
        integer(kind=c_int)     :: allocated
        type(c_ptr)             :: abuf
        integer(kind=c_int64_t) :: alen
        integer(kind=c_int16_t) :: volume
    end type mix_chunk

    interface
        ! Mix_Chunk *Mix_LoadWAV_RW(SDL_RWops *src, int freesrc)
        function mix_load_wav_rw(src, free_src) bind(c, name='Mix_LoadWAV_RW')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr),         intent(in), value :: src
            integer(kind=c_int), intent(in), value :: free_src
            type(c_ptr)                            :: mix_load_wav_rw
        end function mix_load_wav_rw

        ! Mix_Music *Mix_LoadMUS(const char *file)
        function mix_load_mus(file) bind(c, name='Mix_LoadMUS')
            use, intrinsic :: iso_c_binding
            implicit none
            character(kind=c_char), intent(in) :: file
            type(c_ptr)                        :: mix_load_mus
        end function mix_load_mus

        ! int Mix_OpenAudio(int frequency, Uint16 format, int channels, int chunksize)
        function mix_open_audio(frequency, format, channels, chunk_size) bind(c, name='Mix_OpenAudio')
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int),     intent(in), value :: frequency
            integer(kind=c_int32_t), intent(in), value :: format
            integer(kind=c_int),     intent(in), value :: channels
            integer(kind=c_int),     intent(in), value :: chunk_size
            integer(kind=c_int)                        :: mix_open_audio
        end function mix_open_audio

        ! int Mix_PlayChannelTimed(int channel, Mix_Chunk *chunk, int loops, int ticks)
        function mix_play_channel_timed(channel, chunk, loops, ticks) bind(c, name='Mix_PlayChannelTimed')
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int), intent(in), value :: channel
            type(c_ptr),         intent(in), value :: chunk
            integer(kind=c_int), intent(in), value :: loops
            integer(kind=c_int), intent(in), value :: ticks
            integer(kind=c_int)                    :: mix_play_channel_timed
        end function mix_play_channel_timed

        ! int Mix_PlayMusic(Mix_Music *music, int loops)
        function mix_play_music(music, loops) bind(c, name='Mix_PlayMusic')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr),         intent(in), value :: music
            integer(kind=c_int), intent(in), value :: loops
            integer(kind=c_int)                    :: mix_play_music
        end function mix_play_music

        ! int Mix_Playing(int channel)
        function mix_playing(channel) bind(c, name='Mix_Playing')
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int), intent(in), value :: channel
            integer(kind=c_int)                    :: mix_playing
        end function mix_playing

        ! int Mix_PlayingMusic(void)
        function mix_playing_music() bind(c, name='Mix_PlayingMusic')
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int) :: mix_playing_music
        end function mix_playing_music

        ! void Mix_CloseAudio(void)
        subroutine mix_close_audio() bind(c, name='Mix_CloseAudio')
        end subroutine mix_close_audio

        ! void Mix_FreeChunk(Mix_Chunk *chunk)
        subroutine mix_free_chunk(chunk) bind(c, name='Mix_FreeChunk')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr), intent(in), value :: chunk
        end subroutine mix_free_chunk

        ! void Mix_FreeMusic(Mix_Chunk *chunk)
        subroutine mix_free_music(music) bind(c, name='Mix_FreeMusic')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr), intent(in), value :: music
        end subroutine mix_free_music
    end interface

    contains
        function mix_load_wav(file)
            use, intrinsic :: iso_c_binding
            use :: sdl2
            implicit none
            character(kind=c_char), intent(in) :: file
            type(c_ptr)                        :: mix_load_wav

            mix_load_wav = mix_load_wav_rw(sdl_rw_from_file(file, 'rb' // c_null_char), 1)
        end function mix_load_wav

        function mix_play_channel(channel, chunk, loops)
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int), intent(in), value :: channel
            type(c_ptr),         intent(in), value :: chunk
            integer(kind=c_int), intent(in), value :: loops
            integer(kind=c_int)                    :: mix_play_channel

            mix_play_channel = mix_play_channel_timed(channel, chunk, loops, -1)
        end function mix_play_channel
end module sdl2_mixer
