! sdl2_image.f90
!
! SDL2_image interface for Fortran 2003/2008.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/f03sdl2/
! Licence: ISC
module sdl2_image
    use, intrinsic :: iso_c_binding
    implicit none

    integer(kind=c_int), parameter :: img_init_jpg  = z'00000001'
    integer(kind=c_int), parameter :: img_init_png  = z'00000002'
    integer(kind=c_int), parameter :: img_init_tif  = z'00000004'
    integer(kind=c_int), parameter :: img_init_webp = z'00000008'

    interface
        ! int IMG_Init(int flags)
        function img_init(flags) bind(c, name='IMG_Init')
            use, intrinsic :: iso_c_binding
            implicit none
            integer(kind=c_int), intent(in), value :: flags
            integer(kind=c_int)                    :: img_init
        end function img_init

        ! SDL_Surface *IMG_Load(const char *file)
        function img_load(file_name) bind(c, name='IMG_LoadTexture')
            use, intrinsic :: iso_c_binding
            use :: sdl2_types
            implicit none
            character(kind=c_char), intent(in) :: file_name
            type(sdl_surface)                  :: img_load
        end function img_load

        ! SDL_Texture *IMG_LoadTexture(SDL_Renderer *renderer, const char *file)
        function img_load_texture(renderer, file_name) bind(c, name='IMG_LoadTexture')
            use, intrinsic :: iso_c_binding
            implicit none
            type(c_ptr),            intent(in), value :: renderer
            character(kind=c_char), intent(in)        :: file_name
            type(c_ptr)                               :: img_load_texture
        end function img_load_texture

        ! void IMG_Quit(void)
        subroutine img_quit() bind(c, name='IMG_Quit')
        end subroutine img_quit
    end interface
end module sdl2_image
