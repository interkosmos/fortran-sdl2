! glu.f90
!
! Selection of auto-generated Fortran 2008 interfaces to glu.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module glu
    use :: sdl2_c_types, only: c_int, c_ptr
    use :: sdl2_opengl
    implicit none
    private

    integer(kind=c_int), parameter, public :: GLU_FALSE = 0
    integer(kind=c_int), parameter, public :: GLU_TRUE  = 1

    public :: gludeletequadric
    public :: glulookat
    public :: glunewquadric
    public :: gluortho2d
    public :: gluperspective
    public :: gluproject
    public :: glusphere

    interface
        ! GLUquadric* gluNewQuadric(void)
        function glunewquadric() bind(c, name='gluNewQuadric')
            import :: c_ptr
            type(c_ptr) :: glunewquadric
        end function glunewquadric

        ! GLint gluProject(GLdouble objX, GLdouble objY, GLdouble objZ, const GLdouble *model, const GLdouble *proj, const GLint *view, GLdouble* winX, GLdouble* winY, GLdouble* winZ)
        function gluproject(objx, objy, objz, model, proj, view, winx, winy, winz) bind(c, name='gluProject')
            import :: GLdouble, GLint
            real(kind=gldouble), intent(in), value :: objx
            real(kind=gldouble), intent(in), value :: objy
            real(kind=gldouble), intent(in), value :: objz
            real(kind=gldouble), intent(in)        :: model
            real(kind=gldouble), intent(in)        :: proj
            integer(kind=glint), intent(in)        :: view
            real(kind=gldouble), intent(in)        :: winx
            real(kind=gldouble), intent(in)        :: winy
            real(kind=gldouble), intent(in)        :: winz
            integer(kind=glint)                    :: gluproject
        end function gluproject

        ! void gluDeleteQuadric(GLUquadric* quad)
        subroutine gludeletequadric(quad) bind(c, name='gluDeleteQuadric')
            import :: c_ptr
            type(c_ptr), intent(in), value :: quad
        end subroutine gludeletequadric

        ! void gluLookAt(GLdouble eyeX, GLdouble eyeY, GLdouble eyeZ, GLdouble centerX, GLdouble centerY, GLdouble centerZ, GLdouble upX, GLdouble upY, GLdouble upZ)
        subroutine glulookat(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz) bind(c, name='gluLookAt')
            import :: GLdouble
            real(kind=gldouble), intent(in), value :: eyex
            real(kind=gldouble), intent(in), value :: eyey
            real(kind=gldouble), intent(in), value :: eyez
            real(kind=gldouble), intent(in), value :: centerx
            real(kind=gldouble), intent(in), value :: centery
            real(kind=gldouble), intent(in), value :: centerz
            real(kind=gldouble), intent(in), value :: upx
            real(kind=gldouble), intent(in), value :: upy
            real(kind=gldouble), intent(in), value :: upz
        end subroutine glulookat

        ! void gluOrtho2D(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top)
        subroutine gluortho2d(left, right, bottom, top) bind(c, name='gluOrtho2D')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: left
            real(kind=GLdouble), intent(in), value :: right
            real(kind=GLdouble), intent(in), value :: bottom
            real(kind=GLdouble), intent(in), value :: top
        end subroutine gluortho2d

        ! void gluPerspective(GLdouble fovy, GLdouble aspect, GLdouble zNear, GLdouble zFar)
        subroutine gluperspective(fovy, aspect, znear, zfar) bind(c, name='gluPerspective')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: fovy
            real(kind=gldouble), intent(in), value :: aspect
            real(kind=gldouble), intent(in), value :: znear
            real(kind=gldouble), intent(in), value :: zfar
        end subroutine gluperspective

        ! void gluSphere(GLUquadric* quad, GLdouble radius, GLint slices, GLint stacks)
        subroutine glusphere(quad, radius, slices, stacks) bind(c, name='gluSphere')
            import :: c_ptr, GLdouble, GLint
            type(c_ptr),         intent(in), value :: quad
            real(kind=GLdouble), intent(in), value :: radius
            integer(kind=GLint), intent(in), value :: slices
            integer(kind=GLint), intent(in), value :: stacks
        end subroutine glusphere
     end interface
end module glu
