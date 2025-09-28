! sdl2_ttf.f90
!
! Fortran 2008 interfaces to SDL2_ttf.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_ttf
    use sdl2_c_types, only: c_ptr, c_char, c_int
    implicit none
    private

    public :: ttf_init
    public :: ttf_open_font
    public :: ttf_render_text_shaded
    public :: ttf_render_text_solid
    public :: ttf_close_font
    public :: ttf_quit

    interface
        ! int TTF_Init(void)
        function ttf_init() bind(c, name='TTF_Init')
            import :: c_int
            integer(kind=c_int) :: ttf_init
        end function ttf_init

        ! TTF_Font *TTF_OpenFont(const char *file, int ptsize)
        function ttf_open_font(file, ptsize) bind(c, name='TTF_OpenFont')
            import :: c_char, c_int, c_ptr
            character(kind=c_char), intent(in)        :: file
            integer(kind=c_int),    intent(in), value :: ptsize
            type(c_ptr)                               :: ttf_open_font
        end function ttf_open_font

        ! SDL_Surface *TTF_RenderText_Shaded(TTF_Font *font, const char *text, SDL_Color fg, SDL_Color bg)
        function ttf_render_text_shaded_(font, text, fg, bg) bind(c, name='TTF_RenderText_Shaded')
            use :: sdl2, only: sdl_color
            import :: c_char, c_ptr
            type(c_ptr),            intent(in), value :: font
            character(kind=c_char), intent(in)        :: text
            type(sdl_color),        intent(in), value :: fg
            type(sdl_color),        intent(in), value :: bg
            type(c_ptr)                               :: ttf_render_text_shaded_
        end function ttf_render_text_shaded_

        ! SDL_Surface *TTF_RenderText_Solid(TTF_Font *font, const char *text, SDL_Color fg)
        function ttf_render_text_solid_(font, text, fg) bind(c, name='TTF_RenderText_Solid')
            use :: sdl2, only: sdl_color
            import :: c_char, c_ptr
            type(c_ptr),            intent(in), value :: font
            character(kind=c_char), intent(in)        :: text
            type(sdl_color),        intent(in), value :: fg
            type(c_ptr)                               :: ttf_render_text_solid_
        end function ttf_render_text_solid_

        ! void TTF_CloseFont(TTF_Font *font)
        subroutine ttf_close_font(font) bind(c, name='TTF_CloseFont')
            import :: c_ptr
            type(c_ptr), intent(in), value :: font
        end subroutine ttf_close_font

        ! void TTF_Quit(void)
        subroutine ttf_quit() bind(c, name='TTF_Quit')
        end subroutine ttf_quit
    end interface
contains
    ! SDL_Surface *TTF_RenderText_Shaded(TTF_Font *font, const char *text, SDL_Color fg, SDL_Color bg)
    function ttf_render_text_shaded(font, text, fg, bg)
        !! Calls `ttf_render_text_shaded_()` and converts the returned
        !! C pointer to derived type `sdl_surface`.
        use :: sdl2, only: sdl_color, sdl_surface
        type(c_ptr),            intent(in) :: font
        character(kind=c_char), intent(in) :: text
        type(sdl_color),        intent(in) :: fg
        type(sdl_color),        intent(in) :: bg
        type(sdl_surface),      pointer    :: ttf_render_text_shaded
        type(c_ptr)                        :: ptr

        ptr = ttf_render_text_shaded_(font, text, fg, bg)
        call c_f_pointer(ptr, ttf_render_text_shaded)
    end function ttf_render_text_shaded

    ! SDL_Surface *TTF_RenderText_Solid(TTF_Font *font, const char *text, SDL_Color fg)
    function ttf_render_text_solid(font, text, fg)
        !! Calls `ttf_render_text_solid_()` and converts the returned
        !! C pointer to derived type `sdl_surface`.
        use :: sdl2, only: sdl_color, sdl_surface
        type(c_ptr),            intent(in) :: font
        character(kind=c_char), intent(in) :: text
        type(sdl_color),        intent(in) :: fg
        type(sdl_surface),      pointer    :: ttf_render_text_solid
        type(c_ptr)                        :: ptr

        ptr = ttf_render_text_solid_(font, text, fg)
        call c_f_pointer(ptr, ttf_render_text_solid)
    end function ttf_render_text_solid
end module sdl2_ttf
