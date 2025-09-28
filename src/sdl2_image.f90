! sdl2_image.f90
!
! Fortran 2008 interfaces to SDL2_image.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_image
    use sdl2_c_types, only: c_ptr, c_char, c_int
    use, intrinsic :: iso_c_binding, only: c_f_pointer, c_associated
    use :: sdl2_surface
    implicit none
    private

    integer(kind=c_int), parameter, public :: IMG_INIT_JPG  = int(z'00000001')
    integer(kind=c_int), parameter, public :: IMG_INIT_PNG  = int(z'00000002')
    integer(kind=c_int), parameter, public :: IMG_INIT_TIF  = int(z'00000004')
    integer(kind=c_int), parameter, public :: IMG_INIT_WEBP = int(z'00000008')

    public :: img_init
    public :: img_load
    public :: img_load_png_rw
    public :: img_load_texture
    public :: img_quit

    interface
        ! int IMG_Init(int flags)
        function img_init(flags) bind(c, name='IMG_Init')
            import :: c_int
            integer(kind=c_int), intent(in), value :: flags
            integer(kind=c_int)                    :: img_init
        end function img_init

        ! SDL_Surface *IMG_Load(const char *file)
        function img_load_(file_name) bind(c, name='IMG_Load')
            import :: c_char, c_ptr
            character(kind=c_char), intent(in) :: file_name
            type(c_ptr)                        :: img_load_
        end function img_load_

        ! SDL_Surface *IMG_LoadPNG_RW(SDL_RWops *src)
        function img_load_png_rw_(src) bind(c, name='IMG_LoadPNG_RW')
            import :: c_ptr
            type(c_ptr), intent(in), value :: src
            type(c_ptr)                    :: img_load_png_rw_
        end function img_load_png_rw_

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
contains
    function img_load(file_name)
        character(len=*), intent(in) :: file_name
        type(sdl_surface), pointer   :: img_load
        type(c_ptr)                  :: ptr

        img_load => null()
        ptr = img_load_(file_name)
        if (.not. c_associated(ptr)) return
        call c_f_pointer(ptr, img_load)
    end function img_load

    function img_load_png_rw(src)
        type(c_ptr), intent(in)    :: src
        type(sdl_surface), pointer :: img_load_png_rw
        type(c_ptr)                :: ptr

        img_load_png_rw => null()
        ptr = img_load_png_rw_(src)
        if (.not. c_associated(ptr)) return
        call c_f_pointer(ptr, img_load_png_rw)
    end function img_load_png_rw
end module sdl2_image
