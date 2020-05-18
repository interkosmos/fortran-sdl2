! sdl2_image.f90
!
! Fortran 2008 interfaces to SDL2_image.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_image
    use, intrinsic :: iso_c_binding
    implicit none

    integer(kind=c_int), parameter :: IMG_INIT_JPG  = int(z'00000001')
    integer(kind=c_int), parameter :: IMG_INIT_PNG  = int(z'00000002')
    integer(kind=c_int), parameter :: IMG_INIT_TIF  = int(z'00000004')
    integer(kind=c_int), parameter :: IMG_INIT_WEBP = int(z'00000008')

    interface
        ! int IMG_Init(int flags)
        function img_init(flags) bind(c, name='IMG_Init')
            import :: c_int
            integer(kind=c_int), intent(in), value :: flags
            integer(kind=c_int)                    :: img_init
        end function img_init

        ! SDL_Surface *IMG_Load(const char *file)
        function img_load(file_name) bind(c, name='IMG_Load')
            use :: sdl2, only: sdl_surface
            import :: c_char
            character(kind=c_char), intent(in) :: file_name
            type(sdl_surface)                  :: img_load
        end function img_load

        ! SDL_Texture *IMG_LoadTexture(SDL_Renderer *renderer, const char *file)
        function img_load_texture(renderer, file_name) bind(c, name='IMG_LoadTexture')
            import :: c_char, c_ptr
            type(c_ptr),            intent(in), value :: renderer
            character(kind=c_char), intent(in)        :: file_name
            type(c_ptr)                               :: img_load_texture
        end function img_load_texture

        ! void IMG_Quit(void)
        subroutine img_quit() bind(c, name='IMG_Quit')
        end subroutine img_quit
    end interface
end module sdl2_image
