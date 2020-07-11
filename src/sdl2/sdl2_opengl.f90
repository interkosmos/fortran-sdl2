! sdl2_opengl.f90
!
! Auto-generated Fortran 2008 interfaces to SDL_opengl.h.
!
! Author:  Philipp Engel
! GitHub:  https://github.com/interkosmos/fortran-sdl2/
! Licence: ISC
module sdl2_opengl
    use, intrinsic :: iso_c_binding
    implicit none
    integer, parameter, public :: GLenum     = c_int
    integer, parameter, public :: GLboolean  = c_signed_char
    integer, parameter, public :: GLbitfield = c_int
    integer, parameter, public :: GLbyte     = c_signed_char
    integer, parameter, public :: GLshort    = c_short
    integer, parameter, public :: GLint      = c_int
    integer, parameter, public :: GLubyte    = c_signed_char
    integer, parameter, public :: GLushort   = c_short
    integer, parameter, public :: GLuint     = c_int
    integer, parameter, public :: GLsizei    = c_int
    integer, parameter, public :: GLfloat    = c_float
    integer, parameter, public :: GLclampf   = c_float
    integer, parameter, public :: GLdouble   = c_double
    integer, parameter, public :: GLclampd   = c_double

    ! Boolean values
    integer(kind=c_int), parameter :: GL_FALSE = 0
    integer(kind=c_int), parameter :: GL_TRUE  = 1

    ! Data types
    integer(kind=c_int), parameter :: GL_BYTE           = int(z'1400')
    integer(kind=c_int), parameter :: GL_UNSIGNED_BYTE  = int(z'1401')
    integer(kind=c_int), parameter :: GL_SHORT          = int(z'1402')
    integer(kind=c_int), parameter :: GL_UNSIGNED_SHORT = int(z'1403')
    integer(kind=c_int), parameter :: GL_INT            = int(z'1404')
    integer(kind=c_int), parameter :: GL_UNSIGNED_INT   = int(z'1405')
    integer(kind=c_int), parameter :: GL_FLOAT          = int(z'1406')
    integer(kind=c_int), parameter :: GL_2_BYTES        = int(z'1407')
    integer(kind=c_int), parameter :: GL_3_BYTES        = int(z'1408')
    integer(kind=c_int), parameter :: GL_4_BYTES        = int(z'1409')
    integer(kind=c_int), parameter :: GL_DOUBLE         = int(z'140A')

    ! Primitives
    integer(kind=c_int), parameter :: GL_POINTS         = int(z'0000')
    integer(kind=c_int), parameter :: GL_LINES          = int(z'0001')
    integer(kind=c_int), parameter :: GL_LINE_LOOP      = int(z'0002')
    integer(kind=c_int), parameter :: GL_LINE_STRIP     = int(z'0003')
    integer(kind=c_int), parameter :: GL_TRIANGLES      = int(z'0004')
    integer(kind=c_int), parameter :: GL_TRIANGLE_STRIP = int(z'0005')
    integer(kind=c_int), parameter :: GL_TRIANGLE_FAN   = int(z'0006')
    integer(kind=c_int), parameter :: GL_QUADS          = int(z'0007')
    integer(kind=c_int), parameter :: GL_QUAD_STRIP     = int(z'0008')
    integer(kind=c_int), parameter :: GL_POLYGON        = int(z'0009')

    ! Vertex Arrays
    integer(kind=c_int), parameter :: GL_VERTEX_ARRAY                   = int(z'8074')
    integer(kind=c_int), parameter :: GL_NORMAL_ARRAY                   = int(z'8075')
    integer(kind=c_int), parameter :: GL_COLOR_ARRAY                    = int(z'8076')
    integer(kind=c_int), parameter :: GL_INDEX_ARRAY                    = int(z'8077')
    integer(kind=c_int), parameter :: GL_TEXTURE_COORD_ARRAY            = int(z'8078')
    integer(kind=c_int), parameter :: GL_EDGE_FLAG_ARRAY                = int(z'8079')
    integer(kind=c_int), parameter :: GL_VERTEX_ARRAY_SIZE              = int(z'807A')
    integer(kind=c_int), parameter :: GL_VERTEX_ARRAY_TYPE              = int(z'807B')
    integer(kind=c_int), parameter :: GL_VERTEX_ARRAY_STRIDE            = int(z'807C')
    integer(kind=c_int), parameter :: GL_NORMAL_ARRAY_TYPE              = int(z'807E')
    integer(kind=c_int), parameter :: GL_NORMAL_ARRAY_STRIDE            = int(z'807F')
    integer(kind=c_int), parameter :: GL_COLOR_ARRAY_SIZE               = int(z'8081')
    integer(kind=c_int), parameter :: GL_COLOR_ARRAY_TYPE               = int(z'8082')
    integer(kind=c_int), parameter :: GL_COLOR_ARRAY_STRIDE             = int(z'8083')
    integer(kind=c_int), parameter :: GL_INDEX_ARRAY_TYPE               = int(z'8085')
    integer(kind=c_int), parameter :: GL_INDEX_ARRAY_STRIDE             = int(z'8086')
    integer(kind=c_int), parameter :: GL_TEXTURE_COORD_ARRAY_SIZE       = int(z'8088')
    integer(kind=c_int), parameter :: GL_TEXTURE_COORD_ARRAY_TYPE       = int(z'8089')
    integer(kind=c_int), parameter :: GL_TEXTURE_COORD_ARRAY_STRIDE     = int(z'808A')
    integer(kind=c_int), parameter :: GL_EDGE_FLAG_ARRAY_STRIDE         = int(z'808C')
    integer(kind=c_int), parameter :: GL_VERTEX_ARRAY_POINTER           = int(z'808E')
    integer(kind=c_int), parameter :: GL_NORMAL_ARRAY_POINTER           = int(z'808F')
    integer(kind=c_int), parameter :: GL_COLOR_ARRAY_POINTER            = int(z'8090')
    integer(kind=c_int), parameter :: GL_INDEX_ARRAY_POINTER            = int(z'8091')
    integer(kind=c_int), parameter :: GL_TEXTURE_COORD_ARRAY_POINTER    = int(z'8092')
    integer(kind=c_int), parameter :: GL_EDGE_FLAG_ARRAY_POINTER        = int(z'8093')
    integer(kind=c_int), parameter :: GL_V2F                            = int(z'2A20')
    integer(kind=c_int), parameter :: GL_V3F                            = int(z'2A21')
    integer(kind=c_int), parameter :: GL_C4UB_V2F                       = int(z'2A22')
    integer(kind=c_int), parameter :: GL_C4UB_V3F                       = int(z'2A23')
    integer(kind=c_int), parameter :: GL_C3F_V3F                        = int(z'2A24')
    integer(kind=c_int), parameter :: GL_N3F_V3F                        = int(z'2A25')
    integer(kind=c_int), parameter :: GL_C4F_N3F_V3F                    = int(z'2A26')
    integer(kind=c_int), parameter :: GL_T2F_V3F                        = int(z'2A27')
    integer(kind=c_int), parameter :: GL_T4F_V4F                        = int(z'2A28')
    integer(kind=c_int), parameter :: GL_T2F_C4UB_V3F                   = int(z'2A29')
    integer(kind=c_int), parameter :: GL_T2F_C3F_V3F                    = int(z'2A2A')
    integer(kind=c_int), parameter :: GL_T2F_N3F_V3F                    = int(z'2A2B')
    integer(kind=c_int), parameter :: GL_T2F_C4F_N3F_V3F                = int(z'2A2C')
    integer(kind=c_int), parameter :: GL_T4F_C4F_N3F_V4F                = int(z'2A2D')

    ! Matrix Mode
    integer(kind=c_int), parameter :: GL_MATRIX_MODE    = int(z'0BA0')
    integer(kind=c_int), parameter :: GL_MODELVIEW      = int(z'1700')
    integer(kind=c_int), parameter :: GL_PROJECTION     = int(z'1701')
    integer(kind=c_int), parameter :: GL_TEXTURE        = int(z'1702')

    ! Points
    integer(kind=c_int), parameter :: GL_POINT_SMOOTH           = int(z'0B10')
    integer(kind=c_int), parameter :: GL_POINT_SIZE             = int(z'0B11')
    integer(kind=c_int), parameter :: GL_POINT_SIZE_GRANULARITY = int(z'0B13')
    integer(kind=c_int), parameter :: GL_POINT_SIZE_RANGE       = int(z'0B12')

    ! Lines
    integer(kind=c_int), parameter :: GL_LINE_SMOOTH            = int(z'0B20')
    integer(kind=c_int), parameter :: GL_LINE_STIPPLE           = int(z'0B24')
    integer(kind=c_int), parameter :: GL_LINE_STIPPLE_PATTERN   = int(z'0B25')
    integer(kind=c_int), parameter :: GL_LINE_STIPPLE_REPEAT    = int(z'0B26')
    integer(kind=c_int), parameter :: GL_LINE_WIDTH             = int(z'0B21')
    integer(kind=c_int), parameter :: GL_LINE_WIDTH_GRANULARITY = int(z'0B23')
    integer(kind=c_int), parameter :: GL_LINE_WIDTH_RANGE       = int(z'0B22')

    ! Polygons
    integer(kind=c_int), parameter :: GL_POINT                  = int(z'1B00')
    integer(kind=c_int), parameter :: GL_LINE                   = int(z'1B01')
    integer(kind=c_int), parameter :: GL_FILL                   = int(z'1B02')
    integer(kind=c_int), parameter :: GL_CW                     = int(z'0900')
    integer(kind=c_int), parameter :: GL_CCW                    = int(z'0901')
    integer(kind=c_int), parameter :: GL_FRONT                  = int(z'0404')
    integer(kind=c_int), parameter :: GL_BACK                   = int(z'0405')
    integer(kind=c_int), parameter :: GL_POLYGON_MODE           = int(z'0B40')
    integer(kind=c_int), parameter :: GL_POLYGON_SMOOTH         = int(z'0B41')
    integer(kind=c_int), parameter :: GL_POLYGON_STIPPLE        = int(z'0B42')
    integer(kind=c_int), parameter :: GL_EDGE_FLAG              = int(z'0B43')
    integer(kind=c_int), parameter :: GL_CULL_FACE              = int(z'0B44')
    integer(kind=c_int), parameter :: GL_CULL_FACE_MODE         = int(z'0B45')
    integer(kind=c_int), parameter :: GL_FRONT_FACE             = int(z'0B46')
    integer(kind=c_int), parameter :: GL_POLYGON_OFFSET_FACTOR  = int(z'8038')
    integer(kind=c_int), parameter :: GL_POLYGON_OFFSET_UNITS   = int(z'2A00')
    integer(kind=c_int), parameter :: GL_POLYGON_OFFSET_POINT   = int(z'2A01')
    integer(kind=c_int), parameter :: GL_POLYGON_OFFSET_LINE    = int(z'2A02')
    integer(kind=c_int), parameter :: GL_POLYGON_OFFSET_FILL    = int(z'8037')

    ! Display Lists
    integer(kind=c_int), parameter :: GL_COMPILE                = int(z'1300')
    integer(kind=c_int), parameter :: GL_COMPILE_AND_EXECUTE    = int(z'1301')
    integer(kind=c_int), parameter :: GL_LIST_BASE              = int(z'0B32')
    integer(kind=c_int), parameter :: GL_LIST_INDEX             = int(z'0B33')
    integer(kind=c_int), parameter :: GL_LIST_MODE              = int(z'0B30')

    ! Depth buffer
    integer(kind=c_int), parameter :: GL_NEVER              = int(z'0200')
    integer(kind=c_int), parameter :: GL_LESS               = int(z'0201')
    integer(kind=c_int), parameter :: GL_EQUAL              = int(z'0202')
    integer(kind=c_int), parameter :: GL_LEQUAL             = int(z'0203')
    integer(kind=c_int), parameter :: GL_GREATER            = int(z'0204')
    integer(kind=c_int), parameter :: GL_NOTEQUAL           = int(z'0205')
    integer(kind=c_int), parameter :: GL_GEQUAL             = int(z'0206')
    integer(kind=c_int), parameter :: GL_ALWAYS             = int(z'0207')
    integer(kind=c_int), parameter :: GL_DEPTH_TEST         = int(z'0B71')
    integer(kind=c_int), parameter :: GL_DEPTH_BITS         = int(z'0D56')
    integer(kind=c_int), parameter :: GL_DEPTH_CLEAR_VALUE  = int(z'0B73')
    integer(kind=c_int), parameter :: GL_DEPTH_FUNC         = int(z'0B74')
    integer(kind=c_int), parameter :: GL_DEPTH_RANGE        = int(z'0B70')
    integer(kind=c_int), parameter :: GL_DEPTH_WRITEMASK    = int(z'0B72')
    integer(kind=c_int), parameter :: GL_DEPTH_COMPONENT    = int(z'1902')

    ! Lighting
    integer(kind=c_int), parameter :: GL_LIGHTING                   = int(z'0B50')
    integer(kind=c_int), parameter :: GL_LIGHT0                     = int(z'4000')
    integer(kind=c_int), parameter :: GL_LIGHT1                     = int(z'4001')
    integer(kind=c_int), parameter :: GL_LIGHT2                     = int(z'4002')
    integer(kind=c_int), parameter :: GL_LIGHT3                     = int(z'4003')
    integer(kind=c_int), parameter :: GL_LIGHT4                     = int(z'4004')
    integer(kind=c_int), parameter :: GL_LIGHT5                     = int(z'4005')
    integer(kind=c_int), parameter :: GL_LIGHT6                     = int(z'4006')
    integer(kind=c_int), parameter :: GL_LIGHT7                     = int(z'4007')
    integer(kind=c_int), parameter :: GL_SPOT_EXPONENT              = int(z'1205')
    integer(kind=c_int), parameter :: GL_SPOT_CUTOFF                = int(z'1206')
    integer(kind=c_int), parameter :: GL_CONSTANT_ATTENUATION       = int(z'1207')
    integer(kind=c_int), parameter :: GL_LINEAR_ATTENUATION         = int(z'1208')
    integer(kind=c_int), parameter :: GL_QUADRATIC_ATTENUATION      = int(z'1209')
    integer(kind=c_int), parameter :: GL_AMBIENT                    = int(z'1200')
    integer(kind=c_int), parameter :: GL_DIFFUSE                    = int(z'1201')
    integer(kind=c_int), parameter :: GL_SPECULAR                   = int(z'1202')
    integer(kind=c_int), parameter :: GL_SHININESS                  = int(z'1601')
    integer(kind=c_int), parameter :: GL_EMISSION                   = int(z'1600')
    integer(kind=c_int), parameter :: GL_POSITION                   = int(z'1203')
    integer(kind=c_int), parameter :: GL_SPOT_DIRECTION             = int(z'1204')
    integer(kind=c_int), parameter :: GL_AMBIENT_AND_DIFFUSE        = int(z'1602')
    integer(kind=c_int), parameter :: GL_COLOR_INDEXES              = int(z'1603')
    integer(kind=c_int), parameter :: GL_LIGHT_MODEL_TWO_SIDE       = int(z'0B52')
    integer(kind=c_int), parameter :: GL_LIGHT_MODEL_LOCAL_VIEWER   = int(z'0B51')
    integer(kind=c_int), parameter :: GL_LIGHT_MODEL_AMBIENT        = int(z'0B53')
    integer(kind=c_int), parameter :: GL_FRONT_AND_BACK             = int(z'0408')
    integer(kind=c_int), parameter :: GL_SHADE_MODEL                = int(z'0B54')
    integer(kind=c_int), parameter :: GL_FLAT                       = int(z'1D00')
    integer(kind=c_int), parameter :: GL_SMOOTH                     = int(z'1D01')
    integer(kind=c_int), parameter :: GL_COLOR_MATERIAL             = int(z'0B57')
    integer(kind=c_int), parameter :: GL_COLOR_MATERIAL_FACE        = int(z'0B55')
    integer(kind=c_int), parameter :: GL_COLOR_MATERIAL_PARAMETER   = int(z'0B56')
    integer(kind=c_int), parameter :: GL_NORMALIZE                  = int(z'0BA1')

    ! User clipping planes
    integer(kind=c_int), parameter :: GL_CLIP_PLANE0    = int(z'3000')
    integer(kind=c_int), parameter :: GL_CLIP_PLANE1    = int(z'3001')
    integer(kind=c_int), parameter :: GL_CLIP_PLANE2    = int(z'3002')
    integer(kind=c_int), parameter :: GL_CLIP_PLANE3    = int(z'3003')
    integer(kind=c_int), parameter :: GL_CLIP_PLANE4    = int(z'3004')
    integer(kind=c_int), parameter :: GL_CLIP_PLANE5    = int(z'3005')

    ! Accumulation buffer
    integer(kind=c_int), parameter :: GL_ACCUM_RED_BITS     = int(z'0D58')
    integer(kind=c_int), parameter :: GL_ACCUM_GREEN_BITS   = int(z'0D59')
    integer(kind=c_int), parameter :: GL_ACCUM_BLUE_BITS    = int(z'0D5A')
    integer(kind=c_int), parameter :: GL_ACCUM_ALPHA_BITS   = int(z'0D5B')
    integer(kind=c_int), parameter :: GL_ACCUM_CLEAR_VALUE  = int(z'0B80')
    integer(kind=c_int), parameter :: GL_ACCUM              = int(z'0100')
    integer(kind=c_int), parameter :: GL_ADD                = int(z'0104')
    integer(kind=c_int), parameter :: GL_LOAD               = int(z'0101')
    integer(kind=c_int), parameter :: GL_MULT               = int(z'0103')
    integer(kind=c_int), parameter :: GL_RETURN             = int(z'0102')

    ! Alpha testing
    integer(kind=c_int), parameter :: GL_ALPHA_TEST         = int(z'0BC0')
    integer(kind=c_int), parameter :: GL_ALPHA_TEST_REF     = int(z'0BC2')
    integer(kind=c_int), parameter :: GL_ALPHA_TEST_FUNC    = int(z'0BC1')

    ! Blending
    integer(kind=c_int), parameter :: GL_BLEND                  = int(z'0BE2')
    integer(kind=c_int), parameter :: GL_BLEND_SRC              = int(z'0BE1')
    integer(kind=c_int), parameter :: GL_BLEND_DST              = int(z'0BE0')
    integer(kind=c_int), parameter :: GL_ZERO                   = 0
    integer(kind=c_int), parameter :: GL_ONE                    = 1
    integer(kind=c_int), parameter :: GL_SRC_COLOR              = int(z'0300')
    integer(kind=c_int), parameter :: GL_ONE_MINUS_SRC_COLOR    = int(z'0301')
    integer(kind=c_int), parameter :: GL_SRC_ALPHA              = int(z'0302')
    integer(kind=c_int), parameter :: GL_ONE_MINUS_SRC_ALPHA    = int(z'0303')
    integer(kind=c_int), parameter :: GL_DST_ALPHA              = int(z'0304')
    integer(kind=c_int), parameter :: GL_ONE_MINUS_DST_ALPHA    = int(z'0305')
    integer(kind=c_int), parameter :: GL_DST_COLOR              = int(z'0306')
    integer(kind=c_int), parameter :: GL_ONE_MINUS_DST_COLOR    = int(z'0307')
    integer(kind=c_int), parameter :: GL_SRC_ALPHA_SATURATE     = int(z'0308')

    ! Render Mode
    integer(kind=c_int), parameter :: GL_FEEDBACK   = int(z'1C01')
    integer(kind=c_int), parameter :: GL_RENDER     = int(z'1C00')
    integer(kind=c_int), parameter :: GL_SELECT     = int(z'1C02')

    ! Feedback
    integer(kind=c_int), parameter :: GL_2D                         = int(z'0600')
    integer(kind=c_int), parameter :: GL_3D                         = int(z'0601')
    integer(kind=c_int), parameter :: GL_3D_COLOR                   = int(z'0602')
    integer(kind=c_int), parameter :: GL_3D_COLOR_TEXTURE           = int(z'0603')
    integer(kind=c_int), parameter :: GL_4D_COLOR_TEXTURE           = int(z'0604')
    integer(kind=c_int), parameter :: GL_POINT_TOKEN                = int(z'0701')
    integer(kind=c_int), parameter :: GL_LINE_TOKEN                 = int(z'0702')
    integer(kind=c_int), parameter :: GL_LINE_RESET_TOKEN           = int(z'0707')
    integer(kind=c_int), parameter :: GL_POLYGON_TOKEN              = int(z'0703')
    integer(kind=c_int), parameter :: GL_BITMAP_TOKEN               = int(z'0704')
    integer(kind=c_int), parameter :: GL_DRAW_PIXEL_TOKEN           = int(z'0705')
    integer(kind=c_int), parameter :: GL_COPY_PIXEL_TOKEN           = int(z'0706')
    integer(kind=c_int), parameter :: GL_PASS_THROUGH_TOKEN         = int(z'0700')
    integer(kind=c_int), parameter :: GL_FEEDBACK_BUFFER_POINTER    = int(z'0DF0')
    integer(kind=c_int), parameter :: GL_FEEDBACK_BUFFER_SIZE       = int(z'0DF1')
    integer(kind=c_int), parameter :: GL_FEEDBACK_BUFFER_TYPE       = int(z'0DF2')

    ! Selection
    integer(kind=c_int), parameter :: GL_SELECTION_BUFFER_POINTER   = int(z'0DF3')
    integer(kind=c_int), parameter :: GL_SELECTION_BUFFER_SIZE      = int(z'0DF4')

    ! Fog
    integer(kind=c_int), parameter :: GL_FOG            = int(z'0B60')
    integer(kind=c_int), parameter :: GL_FOG_MODE       = int(z'0B65')
    integer(kind=c_int), parameter :: GL_FOG_DENSITY    = int(z'0B62')
    integer(kind=c_int), parameter :: GL_FOG_COLOR      = int(z'0B66')
    integer(kind=c_int), parameter :: GL_FOG_INDEX      = int(z'0B61')
    integer(kind=c_int), parameter :: GL_FOG_START      = int(z'0B63')
    integer(kind=c_int), parameter :: GL_FOG_END        = int(z'0B64')
    integer(kind=c_int), parameter :: GL_LINEAR         = int(z'2601')
    integer(kind=c_int), parameter :: GL_EXP            = int(z'0800')
    integer(kind=c_int), parameter :: GL_EXP2           = int(z'0801')

    ! Logic Ops
    integer(kind=c_int), parameter :: GL_LOGIC_OP       = int(z'0BF1')
    integer(kind=c_int), parameter :: GL_INDEX_LOGIC_OP = int(z'0BF1')
    integer(kind=c_int), parameter :: GL_COLOR_LOGIC_OP = int(z'0BF2')
    integer(kind=c_int), parameter :: GL_LOGIC_OP_MODE  = int(z'0BF0')
    integer(kind=c_int), parameter :: GL_CLEAR          = int(z'1500')
    integer(kind=c_int), parameter :: GL_SET            = int(z'150F')
    integer(kind=c_int), parameter :: GL_COPY           = int(z'1503')
    integer(kind=c_int), parameter :: GL_COPY_INVERTED  = int(z'150C')
    integer(kind=c_int), parameter :: GL_NOOP           = int(z'1505')
    integer(kind=c_int), parameter :: GL_INVERT         = int(z'150A')
    integer(kind=c_int), parameter :: GL_AND            = int(z'1501')
    integer(kind=c_int), parameter :: GL_NAND           = int(z'150E')
    integer(kind=c_int), parameter :: GL_OR             = int(z'1507')
    integer(kind=c_int), parameter :: GL_NOR            = int(z'1508')
    integer(kind=c_int), parameter :: GL_XOR            = int(z'1506')
    integer(kind=c_int), parameter :: GL_EQUIV          = int(z'1509')
    integer(kind=c_int), parameter :: GL_AND_REVERSE    = int(z'1502')
    integer(kind=c_int), parameter :: GL_AND_INVERTED   = int(z'1504')
    integer(kind=c_int), parameter :: GL_OR_REVERSE     = int(z'150B')
    integer(kind=c_int), parameter :: GL_OR_INVERTED    = int(z'150D')

    ! Stencil
    integer(kind=c_int), parameter :: GL_STENCIL_BITS               = int(z'0D57')
    integer(kind=c_int), parameter :: GL_STENCIL_TEST               = int(z'0B90')
    integer(kind=c_int), parameter :: GL_STENCIL_CLEAR_VALUE        = int(z'0B91')
    integer(kind=c_int), parameter :: GL_STENCIL_FUNC               = int(z'0B92')
    integer(kind=c_int), parameter :: GL_STENCIL_VALUE_MASK         = int(z'0B93')
    integer(kind=c_int), parameter :: GL_STENCIL_FAIL               = int(z'0B94')
    integer(kind=c_int), parameter :: GL_STENCIL_PASS_DEPTH_FAIL    = int(z'0B95')
    integer(kind=c_int), parameter :: GL_STENCIL_PASS_DEPTH_PASS    = int(z'0B96')
    integer(kind=c_int), parameter :: GL_STENCIL_REF                = int(z'0B97')
    integer(kind=c_int), parameter :: GL_STENCIL_WRITEMASK          = int(z'0B98')
    integer(kind=c_int), parameter :: GL_STENCIL_INDEX              = int(z'1901')
    integer(kind=c_int), parameter :: GL_KEEP                       = int(z'1E00')
    integer(kind=c_int), parameter :: GL_REPLACE                    = int(z'1E01')
    integer(kind=c_int), parameter :: GL_INCR                       = int(z'1E02')
    integer(kind=c_int), parameter :: GL_DECR                       = int(z'1E03')

    ! Buffers, Pixel Drawing/Reading
    integer(kind=c_int), parameter :: GL_NONE               = 0
    integer(kind=c_int), parameter :: GL_LEFT               = int(z'0406')
    integer(kind=c_int), parameter :: GL_RIGHT              = int(z'0407')
    integer(kind=c_int), parameter :: GL_FRONT_LEFT         = int(z'0400')
    integer(kind=c_int), parameter :: GL_FRONT_RIGHT        = int(z'0401')
    integer(kind=c_int), parameter :: GL_BACK_LEFT          = int(z'0402')
    integer(kind=c_int), parameter :: GL_BACK_RIGHT         = int(z'0403')
    integer(kind=c_int), parameter :: GL_AUX0               = int(z'0409')
    integer(kind=c_int), parameter :: GL_AUX1               = int(z'040A')
    integer(kind=c_int), parameter :: GL_AUX2               = int(z'040B')
    integer(kind=c_int), parameter :: GL_AUX3               = int(z'040C')
    integer(kind=c_int), parameter :: GL_COLOR_INDEX        = int(z'1900')
    integer(kind=c_int), parameter :: GL_RED                = int(z'1903')
    integer(kind=c_int), parameter :: GL_GREEN              = int(z'1904')
    integer(kind=c_int), parameter :: GL_BLUE               = int(z'1905')
    integer(kind=c_int), parameter :: GL_ALPHA              = int(z'1906')
    integer(kind=c_int), parameter :: GL_LUMINANCE          = int(z'1909')
    integer(kind=c_int), parameter :: GL_LUMINANCE_ALPHA    = int(z'190A')
    integer(kind=c_int), parameter :: GL_ALPHA_BITS         = int(z'0D55')
    integer(kind=c_int), parameter :: GL_RED_BITS           = int(z'0D52')
    integer(kind=c_int), parameter :: GL_GREEN_BITS         = int(z'0D53')
    integer(kind=c_int), parameter :: GL_BLUE_BITS          = int(z'0D54')
    integer(kind=c_int), parameter :: GL_INDEX_BITS         = int(z'0D51')
    integer(kind=c_int), parameter :: GL_SUBPIXEL_BITS      = int(z'0D50')
    integer(kind=c_int), parameter :: GL_AUX_BUFFERS        = int(z'0C00')
    integer(kind=c_int), parameter :: GL_READ_BUFFER        = int(z'0C02')
    integer(kind=c_int), parameter :: GL_DRAW_BUFFER        = int(z'0C01')
    integer(kind=c_int), parameter :: GL_DOUBLEBUFFER       = int(z'0C32')
    integer(kind=c_int), parameter :: GL_STEREO             = int(z'0C33')
    integer(kind=c_int), parameter :: GL_BITMAP             = int(z'1A00')
    integer(kind=c_int), parameter :: GL_COLOR              = int(z'1800')
    integer(kind=c_int), parameter :: GL_DEPTH              = int(z'1801')
    integer(kind=c_int), parameter :: GL_STENCIL            = int(z'1802')
    integer(kind=c_int), parameter :: GL_DITHER             = int(z'0BD0')
    integer(kind=c_int), parameter :: GL_RGB                = int(z'1907')
    integer(kind=c_int), parameter :: GL_RGBA               = int(z'1908')

    ! Implementation limits
    integer(kind=c_int), parameter :: GL_MAX_LIST_NESTING               = int(z'0B31')
    integer(kind=c_int), parameter :: GL_MAX_EVAL_ORDER                 = int(z'0D30')
    integer(kind=c_int), parameter :: GL_MAX_LIGHTS                     = int(z'0D31')
    integer(kind=c_int), parameter :: GL_MAX_CLIP_PLANES                = int(z'0D32')
    integer(kind=c_int), parameter :: GL_MAX_TEXTURE_SIZE               = int(z'0D33')
    integer(kind=c_int), parameter :: GL_MAX_PIXEL_MAP_TABLE            = int(z'0D34')
    integer(kind=c_int), parameter :: GL_MAX_ATTRIB_STACK_DEPTH         = int(z'0D35')
    integer(kind=c_int), parameter :: GL_MAX_MODELVIEW_STACK_DEPTH      = int(z'0D36')
    integer(kind=c_int), parameter :: GL_MAX_NAME_STACK_DEPTH           = int(z'0D37')
    integer(kind=c_int), parameter :: GL_MAX_PROJECTION_STACK_DEPTH     = int(z'0D38')
    integer(kind=c_int), parameter :: GL_MAX_TEXTURE_STACK_DEPTH        = int(z'0D39')
    integer(kind=c_int), parameter :: GL_MAX_VIEWPORT_DIMS              = int(z'0D3A')
    integer(kind=c_int), parameter :: GL_MAX_CLIENT_ATTRIB_STACK_DEPTH  = int(z'0D3B')

    ! Gets
    integer(kind=c_int), parameter :: GL_ATTRIB_STACK_DEPTH             = int(z'0BB0')
    integer(kind=c_int), parameter :: GL_CLIENT_ATTRIB_STACK_DEPTH      = int(z'0BB1')
    integer(kind=c_int), parameter :: GL_COLOR_CLEAR_VALUE              = int(z'0C22')
    integer(kind=c_int), parameter :: GL_COLOR_WRITEMASK                = int(z'0C23')
    integer(kind=c_int), parameter :: GL_CURRENT_INDEX                  = int(z'0B01')
    integer(kind=c_int), parameter :: GL_CURRENT_COLOR                  = int(z'0B00')
    integer(kind=c_int), parameter :: GL_CURRENT_NORMAL                 = int(z'0B02')
    integer(kind=c_int), parameter :: GL_CURRENT_RASTER_COLOR           = int(z'0B04')
    integer(kind=c_int), parameter :: GL_CURRENT_RASTER_DISTANCE        = int(z'0B09')
    integer(kind=c_int), parameter :: GL_CURRENT_RASTER_INDEX           = int(z'0B05')
    integer(kind=c_int), parameter :: GL_CURRENT_RASTER_POSITION        = int(z'0B07')
    integer(kind=c_int), parameter :: GL_CURRENT_RASTER_TEXTURE_COORDS  = int(z'0B06')
    integer(kind=c_int), parameter :: GL_CURRENT_RASTER_POSITION_VALID  = int(z'0B08')
    integer(kind=c_int), parameter :: GL_CURRENT_TEXTURE_COORDS         = int(z'0B03')
    integer(kind=c_int), parameter :: GL_INDEX_CLEAR_VALUE              = int(z'0C20')
    integer(kind=c_int), parameter :: GL_INDEX_MODE                     = int(z'0C30')
    integer(kind=c_int), parameter :: GL_INDEX_WRITEMASK                = int(z'0C21')
    integer(kind=c_int), parameter :: GL_MODELVIEW_MATRIX               = int(z'0BA6')
    integer(kind=c_int), parameter :: GL_MODELVIEW_STACK_DEPTH          = int(z'0BA3')
    integer(kind=c_int), parameter :: GL_NAME_STACK_DEPTH               = int(z'0D70')
    integer(kind=c_int), parameter :: GL_PROJECTION_MATRIX              = int(z'0BA7')
    integer(kind=c_int), parameter :: GL_PROJECTION_STACK_DEPTH         = int(z'0BA4')
    integer(kind=c_int), parameter :: GL_RENDER_MODE                    = int(z'0C40')
    integer(kind=c_int), parameter :: GL_RGBA_MODE                      = int(z'0C31')
    integer(kind=c_int), parameter :: GL_TEXTURE_MATRIX                 = int(z'0BA8')
    integer(kind=c_int), parameter :: GL_TEXTURE_STACK_DEPTH            = int(z'0BA5')
    integer(kind=c_int), parameter :: GL_VIEWPORT                       = int(z'0BA2')

    ! Evaluators
    integer(kind=c_int), parameter :: GL_AUTO_NORMAL            = int(z'0D80')
    integer(kind=c_int), parameter :: GL_MAP1_COLOR_4           = int(z'0D90')
    integer(kind=c_int), parameter :: GL_MAP1_INDEX             = int(z'0D91')
    integer(kind=c_int), parameter :: GL_MAP1_NORMAL            = int(z'0D92')
    integer(kind=c_int), parameter :: GL_MAP1_TEXTURE_COORD_1   = int(z'0D93')
    integer(kind=c_int), parameter :: GL_MAP1_TEXTURE_COORD_2   = int(z'0D94')
    integer(kind=c_int), parameter :: GL_MAP1_TEXTURE_COORD_3   = int(z'0D95')
    integer(kind=c_int), parameter :: GL_MAP1_TEXTURE_COORD_4   = int(z'0D96')
    integer(kind=c_int), parameter :: GL_MAP1_VERTEX_3          = int(z'0D97')
    integer(kind=c_int), parameter :: GL_MAP1_VERTEX_4          = int(z'0D98')
    integer(kind=c_int), parameter :: GL_MAP2_COLOR_4           = int(z'0DB0')
    integer(kind=c_int), parameter :: GL_MAP2_INDEX             = int(z'0DB1')
    integer(kind=c_int), parameter :: GL_MAP2_NORMAL            = int(z'0DB2')
    integer(kind=c_int), parameter :: GL_MAP2_TEXTURE_COORD_1   = int(z'0DB3')
    integer(kind=c_int), parameter :: GL_MAP2_TEXTURE_COORD_2   = int(z'0DB4')
    integer(kind=c_int), parameter :: GL_MAP2_TEXTURE_COORD_3   = int(z'0DB5')
    integer(kind=c_int), parameter :: GL_MAP2_TEXTURE_COORD_4   = int(z'0DB6')
    integer(kind=c_int), parameter :: GL_MAP2_VERTEX_3          = int(z'0DB7')
    integer(kind=c_int), parameter :: GL_MAP2_VERTEX_4          = int(z'0DB8')
    integer(kind=c_int), parameter :: GL_MAP1_GRID_DOMAIN       = int(z'0DD0')
    integer(kind=c_int), parameter :: GL_MAP1_GRID_SEGMENTS     = int(z'0DD1')
    integer(kind=c_int), parameter :: GL_MAP2_GRID_DOMAIN       = int(z'0DD2')
    integer(kind=c_int), parameter :: GL_MAP2_GRID_SEGMENTS     = int(z'0DD3')
    integer(kind=c_int), parameter :: GL_COEFF                  = int(z'0A00')
    integer(kind=c_int), parameter :: GL_ORDER                  = int(z'0A01')
    integer(kind=c_int), parameter :: GL_DOMAIN                 = int(z'0A02')

    ! Hints
    integer(kind=c_int), parameter :: GL_PERSPECTIVE_CORRECTION_HINT    = int(z'0C50')
    integer(kind=c_int), parameter :: GL_POINT_SMOOTH_HINT              = int(z'0C51')
    integer(kind=c_int), parameter :: GL_LINE_SMOOTH_HINT               = int(z'0C52')
    integer(kind=c_int), parameter :: GL_POLYGON_SMOOTH_HINT            = int(z'0C53')
    integer(kind=c_int), parameter :: GL_FOG_HINT                       = int(z'0C54')
    integer(kind=c_int), parameter :: GL_DONT_CARE                      = int(z'1100')
    integer(kind=c_int), parameter :: GL_FASTEST                        = int(z'1101')
    integer(kind=c_int), parameter :: GL_NICEST                         = int(z'1102')

    ! Scissor box
    integer(kind=c_int), parameter :: GL_SCISSOR_BOX    = int(z'0C10')
    integer(kind=c_int), parameter :: GL_SCISSOR_TEST   = int(z'0C11')

    ! Pixel Mode / Transfer
    integer(kind=c_int), parameter :: GL_MAP_COLOR              = int(z'0D10')
    integer(kind=c_int), parameter :: GL_MAP_STENCIL            = int(z'0D11')
    integer(kind=c_int), parameter :: GL_INDEX_SHIFT            = int(z'0D12')
    integer(kind=c_int), parameter :: GL_INDEX_OFFSET           = int(z'0D13')
    integer(kind=c_int), parameter :: GL_RED_SCALE              = int(z'0D14')
    integer(kind=c_int), parameter :: GL_RED_BIAS               = int(z'0D15')
    integer(kind=c_int), parameter :: GL_GREEN_SCALE            = int(z'0D18')
    integer(kind=c_int), parameter :: GL_GREEN_BIAS             = int(z'0D19')
    integer(kind=c_int), parameter :: GL_BLUE_SCALE             = int(z'0D1A')
    integer(kind=c_int), parameter :: GL_BLUE_BIAS              = int(z'0D1B')
    integer(kind=c_int), parameter :: GL_ALPHA_SCALE            = int(z'0D1C')
    integer(kind=c_int), parameter :: GL_ALPHA_BIAS             = int(z'0D1D')
    integer(kind=c_int), parameter :: GL_DEPTH_SCALE            = int(z'0D1E')
    integer(kind=c_int), parameter :: GL_DEPTH_BIAS             = int(z'0D1F')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_S_TO_S_SIZE  = int(z'0CB1')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_I_SIZE  = int(z'0CB0')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_R_SIZE  = int(z'0CB2')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_G_SIZE  = int(z'0CB3')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_B_SIZE  = int(z'0CB4')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_A_SIZE  = int(z'0CB5')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_R_TO_R_SIZE  = int(z'0CB6')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_G_TO_G_SIZE  = int(z'0CB7')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_B_TO_B_SIZE  = int(z'0CB8')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_A_TO_A_SIZE  = int(z'0CB9')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_S_TO_S       = int(z'0C71')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_I       = int(z'0C70')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_R       = int(z'0C72')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_G       = int(z'0C73')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_B       = int(z'0C74')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_I_TO_A       = int(z'0C75')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_R_TO_R       = int(z'0C76')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_G_TO_G       = int(z'0C77')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_B_TO_B       = int(z'0C78')
    integer(kind=c_int), parameter :: GL_PIXEL_MAP_A_TO_A       = int(z'0C79')
    integer(kind=c_int), parameter :: GL_PACK_ALIGNMENT         = int(z'0D05')
    integer(kind=c_int), parameter :: GL_PACK_LSB_FIRST         = int(z'0D01')
    integer(kind=c_int), parameter :: GL_PACK_ROW_LENGTH        = int(z'0D02')
    integer(kind=c_int), parameter :: GL_PACK_SKIP_PIXELS       = int(z'0D04')
    integer(kind=c_int), parameter :: GL_PACK_SKIP_ROWS         = int(z'0D03')
    integer(kind=c_int), parameter :: GL_PACK_SWAP_BYTES        = int(z'0D00')
    integer(kind=c_int), parameter :: GL_UNPACK_ALIGNMENT       = int(z'0CF5')
    integer(kind=c_int), parameter :: GL_UNPACK_LSB_FIRST       = int(z'0CF1')
    integer(kind=c_int), parameter :: GL_UNPACK_ROW_LENGTH      = int(z'0CF2')
    integer(kind=c_int), parameter :: GL_UNPACK_SKIP_PIXELS     = int(z'0CF4')
    integer(kind=c_int), parameter :: GL_UNPACK_SKIP_ROWS       = int(z'0CF3')
    integer(kind=c_int), parameter :: GL_UNPACK_SWAP_BYTES      = int(z'0CF0')
    integer(kind=c_int), parameter :: GL_ZOOM_X                 = int(z'0D16')
    integer(kind=c_int), parameter :: GL_ZOOM_Y                 = int(z'0D17')

    ! Texture mapping
    integer(kind=c_int), parameter :: GL_TEXTURE_ENV            = int(z'2300')
    integer(kind=c_int), parameter :: GL_TEXTURE_ENV_MODE       = int(z'2200')
    integer(kind=c_int), parameter :: GL_TEXTURE_1D             = int(z'0DE0')
    integer(kind=c_int), parameter :: GL_TEXTURE_2D             = int(z'0DE1')
    integer(kind=c_int), parameter :: GL_TEXTURE_WRAP_S         = int(z'2802')
    integer(kind=c_int), parameter :: GL_TEXTURE_WRAP_T         = int(z'2803')
    integer(kind=c_int), parameter :: GL_TEXTURE_MAG_FILTER     = int(z'2800')
    integer(kind=c_int), parameter :: GL_TEXTURE_MIN_FILTER     = int(z'2801')
    integer(kind=c_int), parameter :: GL_TEXTURE_ENV_COLOR      = int(z'2201')
    integer(kind=c_int), parameter :: GL_TEXTURE_GEN_S          = int(z'0C60')
    integer(kind=c_int), parameter :: GL_TEXTURE_GEN_T          = int(z'0C61')
    integer(kind=c_int), parameter :: GL_TEXTURE_GEN_R          = int(z'0C62')
    integer(kind=c_int), parameter :: GL_TEXTURE_GEN_Q          = int(z'0C63')
    integer(kind=c_int), parameter :: GL_TEXTURE_GEN_MODE       = int(z'2500')
    integer(kind=c_int), parameter :: GL_TEXTURE_BORDER_COLOR   = int(z'1004')
    integer(kind=c_int), parameter :: GL_TEXTURE_WIDTH          = int(z'1000')
    integer(kind=c_int), parameter :: GL_TEXTURE_HEIGHT         = int(z'1001')
    integer(kind=c_int), parameter :: GL_TEXTURE_BORDER         = int(z'1005')
    integer(kind=c_int), parameter :: GL_TEXTURE_COMPONENTS     = int(z'1003')
    integer(kind=c_int), parameter :: GL_TEXTURE_RED_SIZE       = int(z'805C')
    integer(kind=c_int), parameter :: GL_TEXTURE_GREEN_SIZE     = int(z'805D')
    integer(kind=c_int), parameter :: GL_TEXTURE_BLUE_SIZE      = int(z'805E')
    integer(kind=c_int), parameter :: GL_TEXTURE_ALPHA_SIZE     = int(z'805F')
    integer(kind=c_int), parameter :: GL_TEXTURE_LUMINANCE_SIZE = int(z'8060')
    integer(kind=c_int), parameter :: GL_TEXTURE_INTENSITY_SIZE = int(z'8061')
    integer(kind=c_int), parameter :: GL_NEAREST_MIPMAP_NEAREST = int(z'2700')
    integer(kind=c_int), parameter :: GL_NEAREST_MIPMAP_LINEAR  = int(z'2702')
    integer(kind=c_int), parameter :: GL_LINEAR_MIPMAP_NEAREST  = int(z'2701')
    integer(kind=c_int), parameter :: GL_LINEAR_MIPMAP_LINEAR   = int(z'2703')
    integer(kind=c_int), parameter :: GL_OBJECT_LINEAR          = int(z'2401')
    integer(kind=c_int), parameter :: GL_OBJECT_PLANE           = int(z'2501')
    integer(kind=c_int), parameter :: GL_EYE_LINEAR             = int(z'2400')
    integer(kind=c_int), parameter :: GL_EYE_PLANE              = int(z'2502')
    integer(kind=c_int), parameter :: GL_SPHERE_MAP             = int(z'2402')
    integer(kind=c_int), parameter :: GL_DECAL                  = int(z'2101')
    integer(kind=c_int), parameter :: GL_MODULATE               = int(z'2100')
    integer(kind=c_int), parameter :: GL_NEAREST                = int(z'2600')
    integer(kind=c_int), parameter :: GL_REPEAT                 = int(z'2901')
    integer(kind=c_int), parameter :: GL_CLAMP                  = int(z'2900')
    integer(kind=c_int), parameter :: GL_S                      = int(z'2000')
    integer(kind=c_int), parameter :: GL_T                      = int(z'2001')
    integer(kind=c_int), parameter :: GL_R                      = int(z'2002')
    integer(kind=c_int), parameter :: GL_Q                      = int(z'2003')

    ! Utility
    integer(kind=c_int), parameter :: GL_VENDOR     = int(z'1F00')
    integer(kind=c_int), parameter :: GL_RENDERER   = int(z'1F01')
    integer(kind=c_int), parameter :: GL_VERSION    = int(z'1F02')
    integer(kind=c_int), parameter :: GL_EXTENSIONS = int(z'1F03')

    ! Errors
    integer(kind=c_int), parameter :: GL_NO_ERROR           = 0
    integer(kind=c_int), parameter :: GL_INVALID_ENUM       = int(z'0500')
    integer(kind=c_int), parameter :: GL_INVALID_VALUE      = int(z'0501')
    integer(kind=c_int), parameter :: GL_INVALID_OPERATION  = int(z'0502')
    integer(kind=c_int), parameter :: GL_STACK_OVERFLOW     = int(z'0503')
    integer(kind=c_int), parameter :: GL_STACK_UNDERFLOW    = int(z'0504')
    integer(kind=c_int), parameter :: GL_OUT_OF_MEMORY      = int(z'0505')

    ! glPush/PopAttrib bits
    integer(kind=c_int), parameter :: GL_CURRENT_BIT            = int(z'00000001')
    integer(kind=c_int), parameter :: GL_POINT_BIT              = int(z'00000002')
    integer(kind=c_int), parameter :: GL_LINE_BIT               = int(z'00000004')
    integer(kind=c_int), parameter :: GL_POLYGON_BIT            = int(z'00000008')
    integer(kind=c_int), parameter :: GL_POLYGON_STIPPLE_BIT    = int(z'00000010')
    integer(kind=c_int), parameter :: GL_PIXEL_MODE_BIT         = int(z'00000020')
    integer(kind=c_int), parameter :: GL_LIGHTING_BIT           = int(z'00000040')
    integer(kind=c_int), parameter :: GL_FOG_BIT                = int(z'00000080')
    integer(kind=c_int), parameter :: GL_DEPTH_BUFFER_BIT       = int(z'00000100')
    integer(kind=c_int), parameter :: GL_ACCUM_BUFFER_BIT       = int(z'00000200')
    integer(kind=c_int), parameter :: GL_STENCIL_BUFFER_BIT     = int(z'00000400')
    integer(kind=c_int), parameter :: GL_VIEWPORT_BIT           = int(z'00000800')
    integer(kind=c_int), parameter :: GL_TRANSFORM_BIT          = int(z'00001000')
    integer(kind=c_int), parameter :: GL_ENABLE_BIT             = int(z'00002000')
    integer(kind=c_int), parameter :: GL_COLOR_BUFFER_BIT       = int(z'00004000')
    integer(kind=c_int), parameter :: GL_HINT_BIT               = int(z'00008000')
    integer(kind=c_int), parameter :: GL_EVAL_BIT               = int(z'00010000')
    integer(kind=c_int), parameter :: GL_LIST_BIT               = int(z'00020000')
    integer(kind=c_int), parameter :: GL_TEXTURE_BIT            = int(z'00040000')
    integer(kind=c_int), parameter :: GL_SCISSOR_BIT            = int(z'00080000')
    integer(kind=c_int), parameter :: GL_ALL_ATTRIB_BITS        = int(z'000FFFFF')

    ! OpenGL 1.1
    integer(kind=c_int), parameter :: GL_PROXY_TEXTURE_1D           = int(z'8063')
    integer(kind=c_int), parameter :: GL_PROXY_TEXTURE_2D           = int(z'8064')
    integer(kind=c_int), parameter :: GL_TEXTURE_PRIORITY           = int(z'8066')
    integer(kind=c_int), parameter :: GL_TEXTURE_RESIDENT           = int(z'8067')
    integer(kind=c_int), parameter :: GL_TEXTURE_BINDING_1D         = int(z'8068')
    integer(kind=c_int), parameter :: GL_TEXTURE_BINDING_2D         = int(z'8069')
    integer(kind=c_int), parameter :: GL_TEXTURE_INTERNAL_FORMAT    = int(z'1003')
    integer(kind=c_int), parameter :: GL_ALPHA4                     = int(z'803B')
    integer(kind=c_int), parameter :: GL_ALPHA8                     = int(z'803C')
    integer(kind=c_int), parameter :: GL_ALPHA12                    = int(z'803D')
    integer(kind=c_int), parameter :: GL_ALPHA16                    = int(z'803E')
    integer(kind=c_int), parameter :: GL_LUMINANCE4                 = int(z'803F')
    integer(kind=c_int), parameter :: GL_LUMINANCE8                 = int(z'8040')
    integer(kind=c_int), parameter :: GL_LUMINANCE12                = int(z'8041')
    integer(kind=c_int), parameter :: GL_LUMINANCE16                = int(z'8042')
    integer(kind=c_int), parameter :: GL_LUMINANCE4_ALPHA4          = int(z'8043')
    integer(kind=c_int), parameter :: GL_LUMINANCE6_ALPHA2          = int(z'8044')
    integer(kind=c_int), parameter :: GL_LUMINANCE8_ALPHA8          = int(z'8045')
    integer(kind=c_int), parameter :: GL_LUMINANCE12_ALPHA4         = int(z'8046')
    integer(kind=c_int), parameter :: GL_LUMINANCE12_ALPHA12        = int(z'8047')
    integer(kind=c_int), parameter :: GL_LUMINANCE16_ALPHA16        = int(z'8048')
    integer(kind=c_int), parameter :: GL_INTENSITY                  = int(z'8049')
    integer(kind=c_int), parameter :: GL_INTENSITY4                 = int(z'804A')
    integer(kind=c_int), parameter :: GL_INTENSITY8                 = int(z'804B')
    integer(kind=c_int), parameter :: GL_INTENSITY12                = int(z'804C')
    integer(kind=c_int), parameter :: GL_INTENSITY16                = int(z'804D')
    integer(kind=c_int), parameter :: GL_R3_G3_B2                   = int(z'2A10')
    integer(kind=c_int), parameter :: GL_RGB4                       = int(z'804F')
    integer(kind=c_int), parameter :: GL_RGB5                       = int(z'8050')
    integer(kind=c_int), parameter :: GL_RGB8                       = int(z'8051')
    integer(kind=c_int), parameter :: GL_RGB10                      = int(z'8052')
    integer(kind=c_int), parameter :: GL_RGB12                      = int(z'8053')
    integer(kind=c_int), parameter :: GL_RGB16                      = int(z'8054')
    integer(kind=c_int), parameter :: GL_RGBA2                      = int(z'8055')
    integer(kind=c_int), parameter :: GL_RGBA4                      = int(z'8056')
    integer(kind=c_int), parameter :: GL_RGB5_A1                    = int(z'8057')
    integer(kind=c_int), parameter :: GL_RGBA8                      = int(z'8058')
    integer(kind=c_int), parameter :: GL_RGB10_A2                   = int(z'8059')
    integer(kind=c_int), parameter :: GL_RGBA12                     = int(z'805A')
    integer(kind=c_int), parameter :: GL_RGBA16                     = int(z'805B')

    integer(kind=c_long), parameter :: GL_CLIENT_PIXEL_STORE_BIT    = int(z'00000001', kind=c_long)
    integer(kind=c_long), parameter :: GL_CLIENT_VERTEX_ARRAY_BIT   = int(z'00000002', kind=c_long)
    integer(kind=c_long), parameter :: GL_ALL_CLIENT_ATTRIB_BITS    = int(z'FFFFFFFF', kind=c_long)
    integer(kind=c_long), parameter :: GL_CLIENT_ALL_ATTRIB_BITS    = int(z'FFFFFFFF', kind=c_long)

    public :: glisenabled
    public :: glislist
    public :: glaretexturesresident
    public :: glistexture
    public :: glgeterror
    public :: glrendermode
    public :: glgetstring
    public :: glgenlists
    public :: glclearindex
    public :: glclearcolor
    public :: glclear
    public :: glindexmask
    public :: glcolormask
    public :: glalphafunc
    public :: glblendfunc
    public :: gllogicop
    public :: glcullface
    public :: glfrontface
    public :: glpointsize
    public :: gllinewidth
    public :: gllinestipple
    public :: glpolygonmode
    public :: glpolygonoffset
    public :: glpolygonstipple
    public :: glgetpolygonstipple
    public :: gledgeflag
    public :: gledgeflagv
    public :: glscissor
    public :: glclipplane
    public :: glgetclipplane
    public :: gldrawbuffer
    public :: glreadbuffer
    public :: glenable
    public :: gldisable
    public :: glenableclientstate
    public :: gldisableclientstate
    public :: glgetbooleanv
    public :: glgetdoublev
    public :: glgetfloatv
    public :: glgetintegerv
    public :: glpushattrib
    public :: glpopattrib
    public :: glpushclientattrib
    public :: glpopclientattrib
    public :: glfinish
    public :: glflush
    public :: glhint
    public :: glcleardepth
    public :: gldepthfunc
    public :: gldepthmask
    public :: gldepthrange
    public :: glclearaccum
    public :: glaccum
    public :: glmatrixmode
    public :: glortho
    public :: glfrustum
    public :: glviewport
    public :: glpushmatrix
    public :: glpopmatrix
    public :: glloadidentity
    public :: glloadmatrixd
    public :: glloadmatrixf
    public :: glmultmatrixd
    public :: glmultmatrixf
    public :: glrotated
    public :: glrotatef
    public :: glscaled
    public :: glscalef
    public :: gltranslated
    public :: gltranslatef
    public :: gldeletelists
    public :: glnewlist
    public :: glendlist
    public :: glcalllist
    public :: glcalllists
    public :: gllistbase
    public :: glbegin
    public :: glend
    public :: glvertex2d
    public :: glvertex2f
    public :: glvertex2i
    public :: glvertex2s
    public :: glvertex3d
    public :: glvertex3f
    public :: glvertex3i
    public :: glvertex3s
    public :: glvertex4d
    public :: glvertex4f
    public :: glvertex4i
    public :: glvertex4s
    public :: glvertex2dv
    public :: glvertex2fv
    public :: glvertex2iv
    public :: glvertex2sv
    public :: glvertex3dv
    public :: glvertex3fv
    public :: glvertex3iv
    public :: glvertex3sv
    public :: glvertex4dv
    public :: glvertex4fv
    public :: glvertex4iv
    public :: glvertex4sv
    public :: glnormal3b
    public :: glnormal3d
    public :: glnormal3f
    public :: glnormal3i
    public :: glnormal3s
    public :: glnormal3bv
    public :: glnormal3dv
    public :: glnormal3fv
    public :: glnormal3iv
    public :: glnormal3sv
    public :: glindexd
    public :: glindexf
    public :: glindexi
    public :: glindexs
    public :: glindexub
    public :: glindexdv
    public :: glindexfv
    public :: glindexiv
    public :: glindexsv
    public :: glindexubv
    public :: glcolor3b
    public :: glcolor3d
    public :: glcolor3f
    public :: glcolor3i
    public :: glcolor3s
    public :: glcolor3ub
    public :: glcolor3ui
    public :: glcolor3us
    public :: glcolor4b
    public :: glcolor4d
    public :: glcolor4f
    public :: glcolor4i
    public :: glcolor4s
    public :: glcolor4ub
    public :: glcolor4ui
    public :: glcolor4us
    public :: glcolor3bv
    public :: glcolor3dv
    public :: glcolor3fv
    public :: glcolor3iv
    public :: glcolor3sv
    public :: glcolor3ubv
    public :: glcolor3uiv
    public :: glcolor3usv
    public :: glcolor4bv
    public :: glcolor4dv
    public :: glcolor4fv
    public :: glcolor4iv
    public :: glcolor4sv
    public :: glcolor4ubv
    public :: glcolor4uiv
    public :: glcolor4usv
    public :: gltexcoord1d
    public :: gltexcoord1f
    public :: gltexcoord1i
    public :: gltexcoord1s
    public :: gltexcoord2d
    public :: gltexcoord2f
    public :: gltexcoord2i
    public :: gltexcoord2s
    public :: gltexcoord3d
    public :: gltexcoord3f
    public :: gltexcoord3i
    public :: gltexcoord3s
    public :: gltexcoord4d
    public :: gltexcoord4f
    public :: gltexcoord4i
    public :: gltexcoord4s
    public :: gltexcoord1dv
    public :: gltexcoord1fv
    public :: gltexcoord1iv
    public :: gltexcoord1sv
    public :: gltexcoord2dv
    public :: gltexcoord2fv
    public :: gltexcoord2iv
    public :: gltexcoord2sv
    public :: gltexcoord3dv
    public :: gltexcoord3fv
    public :: gltexcoord3iv
    public :: gltexcoord3sv
    public :: gltexcoord4dv
    public :: gltexcoord4fv
    public :: gltexcoord4iv
    public :: gltexcoord4sv
    public :: glrasterpos2d
    public :: glrasterpos2f
    public :: glrasterpos2i
    public :: glrasterpos2s
    public :: glrasterpos3d
    public :: glrasterpos3f
    public :: glrasterpos3i
    public :: glrasterpos3s
    public :: glrasterpos4d
    public :: glrasterpos4f
    public :: glrasterpos4i
    public :: glrasterpos4s
    public :: glrasterpos2dv
    public :: glrasterpos2fv
    public :: glrasterpos2iv
    public :: glrasterpos2sv
    public :: glrasterpos3dv
    public :: glrasterpos3fv
    public :: glrasterpos3iv
    public :: glrasterpos3sv
    public :: glrasterpos4dv
    public :: glrasterpos4fv
    public :: glrasterpos4iv
    public :: glrasterpos4sv
    public :: glrectd
    public :: glrectf
    public :: glrecti
    public :: glrects
    public :: glrectdv
    public :: glrectfv
    public :: glrectiv
    public :: glrectsv
    public :: glvertexpointer
    public :: glnormalpointer
    public :: glcolorpointer
    public :: glindexpointer
    public :: gltexcoordpointer
    public :: gledgeflagpointer
    public :: glgetpointerv
    public :: glarrayelement
    public :: gldrawarrays
    public :: gldrawelements
    public :: glinterleavedarrays
    public :: glshademodel
    public :: gllightf
    public :: gllighti
    public :: gllightfv
    public :: gllightiv
    public :: glgetlightfv
    public :: glgetlightiv
    public :: gllightmodelf
    public :: gllightmodeli
    public :: gllightmodelfv
    public :: gllightmodeliv
    public :: glmaterialf
    public :: glmateriali
    public :: glmaterialfv
    public :: glmaterialiv
    public :: glgetmaterialfv
    public :: glgetmaterialiv
    public :: glcolormaterial
    public :: glpixelzoom
    public :: glpixelstoref
    public :: glpixelstorei
    public :: glpixeltransferf
    public :: glpixeltransferi
    public :: glpixelmapfv
    public :: glpixelmapuiv
    public :: glpixelmapusv
    public :: glgetpixelmapfv
    public :: glgetpixelmapuiv
    public :: glgetpixelmapusv
    public :: glbitmap
    public :: glreadpixels
    public :: gldrawpixels
    public :: glcopypixels
    public :: glstencilfunc
    public :: glstencilmask
    public :: glstencilop
    public :: glclearstencil
    public :: gltexgend
    public :: gltexgenf
    public :: gltexgeni
    public :: gltexgendv
    public :: gltexgenfv
    public :: gltexgeniv
    public :: glgettexgendv
    public :: glgettexgenfv
    public :: glgettexgeniv
    public :: gltexenvf
    public :: gltexenvi
    public :: gltexenvfv
    public :: gltexenviv
    public :: glgettexenvfv
    public :: glgettexenviv
    public :: gltexparameterf
    public :: gltexparameteri
    public :: gltexparameterfv
    public :: gltexparameteriv
    public :: glgettexparameterfv
    public :: glgettexparameteriv
    public :: glgettexlevelparameterfv
    public :: glgettexlevelparameteriv
    public :: glteximage1d
    public :: glteximage2d
    public :: glgetteximage
    public :: glgentextures
    public :: gldeletetextures
    public :: glbindtexture
    public :: glprioritizetextures
    public :: gltexsubimage1d
    public :: gltexsubimage2d
    public :: glcopyteximage1d
    public :: glcopyteximage2d
    public :: glcopytexsubimage1d
    public :: glcopytexsubimage2d
    public :: glmap1d
    public :: glmap1f
    public :: glmap2d
    public :: glmap2f
    public :: glgetmapdv
    public :: glgetmapfv
    public :: glgetmapiv
    public :: glevalcoord1d
    public :: glevalcoord1f
    public :: glevalcoord1dv
    public :: glevalcoord1fv
    public :: glevalcoord2d
    public :: glevalcoord2f
    public :: glevalcoord2dv
    public :: glevalcoord2fv
    public :: glmapgrid1d
    public :: glmapgrid1f
    public :: glmapgrid2d
    public :: glmapgrid2f
    public :: glevalpoint1
    public :: glevalpoint2
    public :: glevalmesh1
    public :: glevalmesh2
    public :: glfogf
    public :: glfogi
    public :: glfogfv
    public :: glfogiv
    public :: glfeedbackbuffer
    public :: glpassthrough
    public :: glselectbuffer
    public :: glinitnames
    public :: glloadname
    public :: glpushname
    public :: glpopname

    interface
        ! GLboolean glIsEnabled(GLenum cap)
        function glisenabled(cap) bind(c, name='glIsEnabled')
            import :: GLboolean, GLenum
            integer(kind=GLenum), intent(in), value :: cap
            integer(kind=GLboolean) :: glisenabled
        end function glisenabled

        ! GLboolean glIsList(GLuint list)
        function glislist(list) bind(c, name='glIsList')
            import :: GLboolean, GLuint
            integer(kind=GLuint), intent(in), value :: list
            integer(kind=GLboolean) :: glislist
        end function glislist

        ! GLboolean glAreTexturesResident(GLsizei n, const GLuint *textures, GLboolean *residences)
        function glaretexturesresident(n, textures, residences) bind(c, name='glAreTexturesResident')
            import :: GLboolean, GLsizei, GLuint
            integer(kind=GLsizei), intent(in), value :: n
            integer(kind=GLuint), intent(in) :: textures
            integer(kind=GLboolean), intent(in) :: residences
            integer(kind=GLboolean) :: glaretexturesresident
        end function glaretexturesresident

        ! GLboolean glIsTexture(GLuint texture)
        function glistexture(texture) bind(c, name='glIsTexture')
            import :: GLboolean, GLuint
            integer(kind=GLuint), intent(in), value :: texture
            integer(kind=GLboolean) :: glistexture
        end function glistexture

        ! GLenum glGetError(void)
        function glgeterror() bind(c, name='glGetError')
            import :: GLenum
            integer(kind=GLenum) :: glgeterror
        end function glgeterror

        ! GLint glRenderMode(GLenum mode)
        function glrendermode(mode) bind(c, name='glRenderMode')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: mode
            integer(kind=GLint) :: glrendermode
        end function glrendermode

        ! const GLubyte *glGetString(GLenum name)
        function glgetstring(name) bind(c, name='glGetString')
            import :: GLenum, GLubyte, c_ptr
            integer(kind=GLenum), intent(in), value :: name
            type(c_ptr) :: glgetstring
        end function glgetstring

        ! GLuint glGenLists(GLsizei range)
        function glgenlists(range) bind(c, name='glGenLists')
            import :: GLsizei, GLuint
            integer(kind=GLsizei), intent(in), value :: range
            integer(kind=GLuint) :: glgenlists
        end function glgenlists

        ! void glClearIndex(GLfloat c)
        subroutine glclearindex(c) bind(c, name='glClearIndex')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: c
        end subroutine glclearindex

        ! void glClearColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha)
        subroutine glclearcolor(red, green, blue, alpha) bind(c, name='glClearColor')
            import :: GLclampf
            real(kind=GLclampf), intent(in), value :: red
            real(kind=GLclampf), intent(in), value :: green
            real(kind=GLclampf), intent(in), value :: blue
            real(kind=GLclampf), intent(in), value :: alpha
        end subroutine glclearcolor

        ! void glClear(GLbitfield mask)
        subroutine glclear(mask) bind(c, name='glClear')
            import :: GLbitfield
            integer(kind=GLbitfield), intent(in), value :: mask
        end subroutine glclear

        ! void glIndexMask(GLuint mask)
        subroutine glindexmask(mask) bind(c, name='glIndexMask')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: mask
        end subroutine glindexmask

        ! void glColorMask(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha)
        subroutine glcolormask(red, green, blue, alpha) bind(c, name='glColorMask')
            import :: GLboolean
            integer(kind=GLboolean), intent(in), value :: red
            integer(kind=GLboolean), intent(in), value :: green
            integer(kind=GLboolean), intent(in), value :: blue
            integer(kind=GLboolean), intent(in), value :: alpha
        end subroutine glcolormask

        ! void glAlphaFunc(GLenum func, GLclampf ref)
        subroutine glalphafunc(func, ref) bind(c, name='glAlphaFunc')
            import :: GLclampf, GLenum
            integer(kind=GLenum), intent(in), value :: func
            real(kind=GLclampf), intent(in), value :: ref
        end subroutine glalphafunc

        ! void glBlendFunc(GLenum sfactor, GLenum dfactor)
        subroutine glblendfunc(sfactor, dfactor) bind(c, name='glBlendFunc')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: sfactor
            integer(kind=GLenum), intent(in), value :: dfactor
        end subroutine glblendfunc

        ! void glLogicOp(GLenum opcode)
        subroutine gllogicop(opcode) bind(c, name='glLogicOp')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: opcode
        end subroutine gllogicop

        ! void glCullFace(GLenum mode)
        subroutine glcullface(mode) bind(c, name='glCullFace')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glcullface

        ! void glFrontFace(GLenum mode)
        subroutine glfrontface(mode) bind(c, name='glFrontFace')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glfrontface

        ! void glPointSize(GLfloat size)
        subroutine glpointsize(size) bind(c, name='glPointSize')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: size
        end subroutine glpointsize

        ! void glLineWidth(GLfloat width)
        subroutine gllinewidth(width) bind(c, name='glLineWidth')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: width
        end subroutine gllinewidth

        ! void glLineStipple(GLint factor, GLushort pattern)
        subroutine gllinestipple(factor, pattern) bind(c, name='glLineStipple')
            import :: GLint, GLushort
            integer(kind=GLint), intent(in), value :: factor
            integer(kind=GLushort), intent(in), value :: pattern
        end subroutine gllinestipple

        ! void glPolygonMode(GLenum face, GLenum mode)
        subroutine glpolygonmode(face, mode) bind(c, name='glPolygonMode')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glpolygonmode

        ! void glPolygonOffset(GLfloat factor, GLfloat units)
        subroutine glpolygonoffset(factor, units) bind(c, name='glPolygonOffset')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: factor
            real(kind=GLfloat), intent(in), value :: units
        end subroutine glpolygonoffset

        ! void glPolygonStipple(const GLubyte *mask)
        subroutine glpolygonstipple(mask) bind(c, name='glPolygonStipple')
            import :: GLubyte
            integer(kind=GLubyte), intent(in) :: mask
        end subroutine glpolygonstipple

        ! void glGetPolygonStipple(GLubyte *mask)
        subroutine glgetpolygonstipple(mask) bind(c, name='glGetPolygonStipple')
            import :: GLubyte
            integer(kind=GLubyte), intent(in) :: mask
        end subroutine glgetpolygonstipple

        ! void glEdgeFlag(GLboolean flag)
        subroutine gledgeflag(flag) bind(c, name='glEdgeFlag')
            import :: GLboolean
            integer(kind=GLboolean), intent(in), value :: flag
        end subroutine gledgeflag

        ! void glEdgeFlagv(const GLboolean *flag)
        subroutine gledgeflagv(flag) bind(c, name='glEdgeFlagv')
            import :: GLboolean
            integer(kind=GLboolean), intent(in) :: flag
        end subroutine gledgeflagv

        ! void glScissor(GLint x, GLint y, GLsizei width, GLsizei height)
        subroutine glscissor(x, y, width, height) bind(c, name='glScissor')
            import :: GLint, GLsizei
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
        end subroutine glscissor

        ! void glClipPlane(GLenum plane, const GLdouble *equation)
        subroutine glclipplane(plane, equation) bind(c, name='glClipPlane')
            import :: GLdouble, GLenum
            integer(kind=GLenum), intent(in), value :: plane
            real(kind=GLdouble), intent(in) :: equation
        end subroutine glclipplane

        ! void glGetClipPlane(GLenum plane, GLdouble *equation)
        subroutine glgetclipplane(plane, equation) bind(c, name='glGetClipPlane')
            import :: GLdouble, GLenum
            integer(kind=GLenum), intent(in), value :: plane
            real(kind=GLdouble), intent(in) :: equation
        end subroutine glgetclipplane

        ! void glDrawBuffer(GLenum mode)
        subroutine gldrawbuffer(mode) bind(c, name='glDrawBuffer')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine gldrawbuffer

        ! void glReadBuffer(GLenum mode)
        subroutine glreadbuffer(mode) bind(c, name='glReadBuffer')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glreadbuffer

        ! void glEnable(GLenum cap)
        subroutine glenable(cap) bind(c, name='glEnable')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: cap
        end subroutine glenable

        ! void glDisable(GLenum cap)
        subroutine gldisable(cap) bind(c, name='glDisable')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: cap
        end subroutine gldisable

        ! void glEnableClientState(GLenum cap)
        subroutine glenableclientstate(cap) bind(c, name='glEnableClientState')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: cap
        end subroutine glenableclientstate

        ! void glDisableClientState(GLenum cap)
        subroutine gldisableclientstate(cap) bind(c, name='glDisableClientState')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: cap
        end subroutine gldisableclientstate

        ! void glGetBooleanv(GLenum pname, GLboolean *params)
        subroutine glgetbooleanv(pname, params) bind(c, name='glGetBooleanv')
            import :: GLboolean, GLenum
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLboolean), intent(in) :: params
        end subroutine glgetbooleanv

        ! void glGetDoublev(GLenum pname, GLdouble *params)
        subroutine glgetdoublev(pname, params) bind(c, name='glGetDoublev')
            import :: GLdouble, GLenum
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLdouble), intent(in) :: params
        end subroutine glgetdoublev

        ! void glGetFloatv(GLenum pname, GLfloat *params)
        subroutine glgetfloatv(pname, params) bind(c, name='glGetFloatv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glgetfloatv

        ! void glGetIntegerv(GLenum pname, GLint *params)
        subroutine glgetintegerv(pname, params) bind(c, name='glGetIntegerv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glgetintegerv

        ! void glPushAttrib(GLbitfield mask)
        subroutine glpushattrib(mask) bind(c, name='glPushAttrib')
            import :: GLbitfield
            integer(kind=GLbitfield), intent(in), value :: mask
        end subroutine glpushattrib

        ! void glPopAttrib(void)
        subroutine glpopattrib() bind(c, name='glPopAttrib')
        end subroutine glpopattrib

        ! void glPushClientAttrib(GLbitfield mask)
        subroutine glpushclientattrib(mask) bind(c, name='glPushClientAttrib')
            import :: GLbitfield
            integer(kind=GLbitfield), intent(in), value :: mask
        end subroutine glpushclientattrib

        ! void glPopClientAttrib(void)
        subroutine glpopclientattrib() bind(c, name='glPopClientAttrib')
        end subroutine glpopclientattrib

        ! void glFinish(void)
        subroutine glfinish() bind(c, name='glFinish')
        end subroutine glfinish

        ! void glFlush(void)
        subroutine glflush() bind(c, name='glFlush')
        end subroutine glflush

        ! void glHint(GLenum target, GLenum mode)
        subroutine glhint(target, mode) bind(c, name='glHint')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glhint

        ! void glClearDepth(GLclampd depth)
        subroutine glcleardepth(depth) bind(c, name='glClearDepth')
            import :: GLclampd
            real(kind=GLclampd), intent(in), value :: depth
        end subroutine glcleardepth

        ! void glDepthFunc(GLenum func)
        subroutine gldepthfunc(func) bind(c, name='glDepthFunc')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: func
        end subroutine gldepthfunc

        ! void glDepthMask(GLboolean flag)
        subroutine gldepthmask(flag) bind(c, name='glDepthMask')
            import :: GLboolean
            integer(kind=GLboolean), intent(in), value :: flag
        end subroutine gldepthmask

        ! void glDepthRange(GLclampd near_val, GLclampd far_val)
        subroutine gldepthrange(near_val, far_val) bind(c, name='glDepthRange')
            import :: GLclampd
            real(kind=GLclampd), intent(in), value :: near_val
            real(kind=GLclampd), intent(in), value :: far_val
        end subroutine gldepthrange

        ! void glClearAccum(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha)
        subroutine glclearaccum(red, green, blue, alpha) bind(c, name='glClearAccum')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: red
            real(kind=GLfloat), intent(in), value :: green
            real(kind=GLfloat), intent(in), value :: blue
            real(kind=GLfloat), intent(in), value :: alpha
        end subroutine glclearaccum

        ! void glAccum(GLenum op, GLfloat value)
        subroutine glaccum(op, value) bind(c, name='glAccum')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: op
            real(kind=GLfloat), intent(in), value :: value
        end subroutine glaccum

        ! void glMatrixMode(GLenum mode)
        subroutine glmatrixmode(mode) bind(c, name='glMatrixMode')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glmatrixmode

        ! void glOrtho(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble near_val, GLdouble far_val)
        subroutine glortho(left, right, bottom, top, near_val, far_val) bind(c, name='glOrtho')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: left
            real(kind=GLdouble), intent(in), value :: right
            real(kind=GLdouble), intent(in), value :: bottom
            real(kind=GLdouble), intent(in), value :: top
            real(kind=GLdouble), intent(in), value :: near_val
            real(kind=GLdouble), intent(in), value :: far_val
        end subroutine glortho

        ! void glFrustum(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble near_val, GLdouble far_val)
        subroutine glfrustum(left, right, bottom, top, near_val, far_val) bind(c, name='glFrustum')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: left
            real(kind=GLdouble), intent(in), value :: right
            real(kind=GLdouble), intent(in), value :: bottom
            real(kind=GLdouble), intent(in), value :: top
            real(kind=GLdouble), intent(in), value :: near_val
            real(kind=GLdouble), intent(in), value :: far_val
        end subroutine glfrustum

        ! void glViewport(GLint x, GLint y, GLsizei width, GLsizei height)
        subroutine glviewport(x, y, width, height) bind(c, name='glViewport')
            import :: GLint, GLsizei
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
        end subroutine glviewport

        ! void glPushMatrix(void)
        subroutine glpushmatrix() bind(c, name='glPushMatrix')
        end subroutine glpushmatrix

        ! void glPopMatrix(void)
        subroutine glpopmatrix() bind(c, name='glPopMatrix')
        end subroutine glpopmatrix

        ! void glLoadIdentity(void)
        subroutine glloadidentity() bind(c, name='glLoadIdentity')
        end subroutine glloadidentity

        ! void glLoadMatrixd(const GLdouble *m)
        subroutine glloadmatrixd(m) bind(c, name='glLoadMatrixd')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: m
        end subroutine glloadmatrixd

        ! void glLoadMatrixf(const GLfloat *m)
        subroutine glloadmatrixf(m) bind(c, name='glLoadMatrixf')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: m
        end subroutine glloadmatrixf

        ! void glMultMatrixd(const GLdouble *m)
        subroutine glmultmatrixd(m) bind(c, name='glMultMatrixd')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: m
        end subroutine glmultmatrixd

        ! void glMultMatrixf(const GLfloat *m)
        subroutine glmultmatrixf(m) bind(c, name='glMultMatrixf')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: m
        end subroutine glmultmatrixf

        ! void glRotated(GLdouble angle, GLdouble x, GLdouble y, GLdouble z)
        subroutine glrotated(angle, x, y, z) bind(c, name='glRotated')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: angle
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
            real(kind=GLdouble), intent(in), value :: z
        end subroutine glrotated

        ! void glRotatef(GLfloat angle, GLfloat x, GLfloat y, GLfloat z)
        subroutine glrotatef(angle, x, y, z) bind(c, name='glRotatef')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: angle
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
            real(kind=GLfloat), intent(in), value :: z
        end subroutine glrotatef

        ! void glScaled(GLdouble x, GLdouble y, GLdouble z)
        subroutine glscaled(x, y, z) bind(c, name='glScaled')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
            real(kind=GLdouble), intent(in), value :: z
        end subroutine glscaled

        ! void glScalef(GLfloat x, GLfloat y, GLfloat z)
        subroutine glscalef(x, y, z) bind(c, name='glScalef')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
            real(kind=GLfloat), intent(in), value :: z
        end subroutine glscalef

        ! void glTranslated(GLdouble x, GLdouble y, GLdouble z)
        subroutine gltranslated(x, y, z) bind(c, name='glTranslated')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
            real(kind=GLdouble), intent(in), value :: z
        end subroutine gltranslated

        ! void glTranslatef(GLfloat x, GLfloat y, GLfloat z)
        subroutine gltranslatef(x, y, z) bind(c, name='glTranslatef')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
            real(kind=GLfloat), intent(in), value :: z
        end subroutine gltranslatef

        ! void glDeleteLists(GLuint list, GLsizei range)
        subroutine gldeletelists(list, range) bind(c, name='glDeleteLists')
            import :: GLsizei, GLuint
            integer(kind=GLuint), intent(in), value :: list
            integer(kind=GLsizei), intent(in), value :: range
        end subroutine gldeletelists

        ! void glNewList(GLuint list, GLenum mode)
        subroutine glnewlist(list, mode) bind(c, name='glNewList')
            import :: GLenum, GLuint
            integer(kind=GLuint), intent(in), value :: list
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glnewlist

        ! void glEndList(void)
        subroutine glendlist() bind(c, name='glEndList')
        end subroutine glendlist

        ! void glCallList(GLuint list)
        subroutine glcalllist(list) bind(c, name='glCallList')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: list
        end subroutine glcalllist

        ! void glCallLists(GLsizei n, GLenum type, const GLvoid *lists)
        subroutine glcalllists(n, type, lists) bind(c, name='glCallLists')
            import :: GLenum, GLsizei, c_ptr
            integer(kind=GLsizei), intent(in), value :: n
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: lists
        end subroutine glcalllists

        ! void glListBase(GLuint base)
        subroutine gllistbase(base) bind(c, name='glListBase')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: base
        end subroutine gllistbase

        ! void glBegin(GLenum mode)
        subroutine glbegin(mode) bind(c, name='glBegin')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glbegin

        ! void glEnd(void)
        subroutine glend() bind(c, name='glEnd')
        end subroutine glend

        ! void glVertex2d(GLdouble x, GLdouble y)
        subroutine glvertex2d(x, y) bind(c, name='glVertex2d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
        end subroutine glvertex2d

        ! void glVertex2f(GLfloat x, GLfloat y)
        subroutine glvertex2f(x, y) bind(c, name='glVertex2f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
        end subroutine glvertex2f

        ! void glVertex2i(GLint x, GLint y)
        subroutine glvertex2i(x, y) bind(c, name='glVertex2i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
        end subroutine glvertex2i

        ! void glVertex2s(GLshort x, GLshort y)
        subroutine glvertex2s(x, y) bind(c, name='glVertex2s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: x
            integer(kind=GLshort), intent(in), value :: y
        end subroutine glvertex2s

        ! void glVertex3d(GLdouble x, GLdouble y, GLdouble z)
        subroutine glvertex3d(x, y, z) bind(c, name='glVertex3d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
            real(kind=GLdouble), intent(in), value :: z
        end subroutine glvertex3d

        ! void glVertex3f(GLfloat x, GLfloat y, GLfloat z)
        subroutine glvertex3f(x, y, z) bind(c, name='glVertex3f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
            real(kind=GLfloat), intent(in), value :: z
        end subroutine glvertex3f

        ! void glVertex3i(GLint x, GLint y, GLint z)
        subroutine glvertex3i(x, y, z) bind(c, name='glVertex3i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLint), intent(in), value :: z
        end subroutine glvertex3i

        ! void glVertex3s(GLshort x, GLshort y, GLshort z)
        subroutine glvertex3s(x, y, z) bind(c, name='glVertex3s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: x
            integer(kind=GLshort), intent(in), value :: y
            integer(kind=GLshort), intent(in), value :: z
        end subroutine glvertex3s

        ! void glVertex4d(GLdouble x, GLdouble y, GLdouble z, GLdouble w)
        subroutine glvertex4d(x, y, z, w) bind(c, name='glVertex4d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
            real(kind=GLdouble), intent(in), value :: z
            real(kind=GLdouble), intent(in), value :: w
        end subroutine glvertex4d

        ! void glVertex4f(GLfloat x, GLfloat y, GLfloat z, GLfloat w)
        subroutine glvertex4f(x, y, z, w) bind(c, name='glVertex4f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
            real(kind=GLfloat), intent(in), value :: z
            real(kind=GLfloat), intent(in), value :: w
        end subroutine glvertex4f

        ! void glVertex4i(GLint x, GLint y, GLint z, GLint w)
        subroutine glvertex4i(x, y, z, w) bind(c, name='glVertex4i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLint), intent(in), value :: z
            integer(kind=GLint), intent(in), value :: w
        end subroutine glvertex4i

        ! void glVertex4s(GLshort x, GLshort y, GLshort z, GLshort w)
        subroutine glvertex4s(x, y, z, w) bind(c, name='glVertex4s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: x
            integer(kind=GLshort), intent(in), value :: y
            integer(kind=GLshort), intent(in), value :: z
            integer(kind=GLshort), intent(in), value :: w
        end subroutine glvertex4s

        ! void glVertex2dv(const GLdouble *v)
        subroutine glvertex2dv(v) bind(c, name='glVertex2dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glvertex2dv

        ! void glVertex2fv(const GLfloat *v)
        subroutine glvertex2fv(v) bind(c, name='glVertex2fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glvertex2fv

        ! void glVertex2iv(const GLint *v)
        subroutine glvertex2iv(v) bind(c, name='glVertex2iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glvertex2iv

        ! void glVertex2sv(const GLshort *v)
        subroutine glvertex2sv(v) bind(c, name='glVertex2sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glvertex2sv

        ! void glVertex3dv(const GLdouble *v)
        subroutine glvertex3dv(v) bind(c, name='glVertex3dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glvertex3dv

        ! void glVertex3fv(const GLfloat *v)
        subroutine glvertex3fv(v) bind(c, name='glVertex3fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glvertex3fv

        ! void glVertex3iv(const GLint *v)
        subroutine glvertex3iv(v) bind(c, name='glVertex3iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glvertex3iv

        ! void glVertex3sv(const GLshort *v)
        subroutine glvertex3sv(v) bind(c, name='glVertex3sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glvertex3sv

        ! void glVertex4dv(const GLdouble *v)
        subroutine glvertex4dv(v) bind(c, name='glVertex4dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glvertex4dv

        ! void glVertex4fv(const GLfloat *v)
        subroutine glvertex4fv(v) bind(c, name='glVertex4fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glvertex4fv

        ! void glVertex4iv(const GLint *v)
        subroutine glvertex4iv(v) bind(c, name='glVertex4iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glvertex4iv

        ! void glVertex4sv(const GLshort *v)
        subroutine glvertex4sv(v) bind(c, name='glVertex4sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glvertex4sv

        ! void glNormal3b(GLbyte nx, GLbyte ny, GLbyte nz)
        subroutine glnormal3b(nx, ny, nz) bind(c, name='glNormal3b')
            import :: GLbyte
            integer(kind=GLbyte), intent(in), value :: nx
            integer(kind=GLbyte), intent(in), value :: ny
            integer(kind=GLbyte), intent(in), value :: nz
        end subroutine glnormal3b

        ! void glNormal3d(GLdouble nx, GLdouble ny, GLdouble nz)
        subroutine glnormal3d(nx, ny, nz) bind(c, name='glNormal3d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: nx
            real(kind=GLdouble), intent(in), value :: ny
            real(kind=GLdouble), intent(in), value :: nz
        end subroutine glnormal3d

        ! void glNormal3f(GLfloat nx, GLfloat ny, GLfloat nz)
        subroutine glnormal3f(nx, ny, nz) bind(c, name='glNormal3f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: nx
            real(kind=GLfloat), intent(in), value :: ny
            real(kind=GLfloat), intent(in), value :: nz
        end subroutine glnormal3f

        ! void glNormal3i(GLint nx, GLint ny, GLint nz)
        subroutine glnormal3i(nx, ny, nz) bind(c, name='glNormal3i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: nx
            integer(kind=GLint), intent(in), value :: ny
            integer(kind=GLint), intent(in), value :: nz
        end subroutine glnormal3i

        ! void glNormal3s(GLshort nx, GLshort ny, GLshort nz)
        subroutine glnormal3s(nx, ny, nz) bind(c, name='glNormal3s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: nx
            integer(kind=GLshort), intent(in), value :: ny
            integer(kind=GLshort), intent(in), value :: nz
        end subroutine glnormal3s

        ! void glNormal3bv(const GLbyte *v)
        subroutine glnormal3bv(v) bind(c, name='glNormal3bv')
            import :: GLbyte
            integer(kind=GLbyte), intent(in) :: v
        end subroutine glnormal3bv

        ! void glNormal3dv(const GLdouble *v)
        subroutine glnormal3dv(v) bind(c, name='glNormal3dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glnormal3dv

        ! void glNormal3fv(const GLfloat *v)
        subroutine glnormal3fv(v) bind(c, name='glNormal3fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glnormal3fv

        ! void glNormal3iv(const GLint *v)
        subroutine glnormal3iv(v) bind(c, name='glNormal3iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glnormal3iv

        ! void glNormal3sv(const GLshort *v)
        subroutine glnormal3sv(v) bind(c, name='glNormal3sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glnormal3sv

        ! void glIndexd(GLdouble c)
        subroutine glindexd(c) bind(c, name='glIndexd')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: c
        end subroutine glindexd

        ! void glIndexf(GLfloat c)
        subroutine glindexf(c) bind(c, name='glIndexf')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: c
        end subroutine glindexf

        ! void glIndexi(GLint c)
        subroutine glindexi(c) bind(c, name='glIndexi')
            import :: GLint
            integer(kind=GLint), intent(in), value :: c
        end subroutine glindexi

        ! void glIndexs(GLshort c)
        subroutine glindexs(c) bind(c, name='glIndexs')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: c
        end subroutine glindexs

        ! void glIndexub(GLubyte c)
        subroutine glindexub(c) bind(c, name='glIndexub')
            import :: GLubyte
            integer(kind=GLubyte), intent(in), value :: c
        end subroutine glindexub

        ! void glIndexdv(const GLdouble *c)
        subroutine glindexdv(c) bind(c, name='glIndexdv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: c
        end subroutine glindexdv

        ! void glIndexfv(const GLfloat *c)
        subroutine glindexfv(c) bind(c, name='glIndexfv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: c
        end subroutine glindexfv

        ! void glIndexiv(const GLint *c)
        subroutine glindexiv(c) bind(c, name='glIndexiv')
            import :: GLint
            integer(kind=GLint), intent(in) :: c
        end subroutine glindexiv

        ! void glIndexsv(const GLshort *c)
        subroutine glindexsv(c) bind(c, name='glIndexsv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: c
        end subroutine glindexsv

        ! void glIndexubv(const GLubyte *c)
        subroutine glindexubv(c) bind(c, name='glIndexubv')
            import :: GLubyte
            integer(kind=GLubyte), intent(in) :: c
        end subroutine glindexubv

        ! void glColor3b(GLbyte red, GLbyte green, GLbyte blue)
        subroutine glcolor3b(red, green, blue) bind(c, name='glColor3b')
            import :: GLbyte
            integer(kind=GLbyte), intent(in), value :: red
            integer(kind=GLbyte), intent(in), value :: green
            integer(kind=GLbyte), intent(in), value :: blue
        end subroutine glcolor3b

        ! void glColor3d(GLdouble red, GLdouble green, GLdouble blue)
        subroutine glcolor3d(red, green, blue) bind(c, name='glColor3d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: red
            real(kind=GLdouble), intent(in), value :: green
            real(kind=GLdouble), intent(in), value :: blue
        end subroutine glcolor3d

        ! void glColor3f(GLfloat red, GLfloat green, GLfloat blue)
        subroutine glcolor3f(red, green, blue) bind(c, name='glColor3f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: red
            real(kind=GLfloat), intent(in), value :: green
            real(kind=GLfloat), intent(in), value :: blue
        end subroutine glcolor3f

        ! void glColor3i(GLint red, GLint green, GLint blue)
        subroutine glcolor3i(red, green, blue) bind(c, name='glColor3i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: red
            integer(kind=GLint), intent(in), value :: green
            integer(kind=GLint), intent(in), value :: blue
        end subroutine glcolor3i

        ! void glColor3s(GLshort red, GLshort green, GLshort blue)
        subroutine glcolor3s(red, green, blue) bind(c, name='glColor3s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: red
            integer(kind=GLshort), intent(in), value :: green
            integer(kind=GLshort), intent(in), value :: blue
        end subroutine glcolor3s

        ! void glColor3ub(GLubyte red, GLubyte green, GLubyte blue)
        subroutine glcolor3ub(red, green, blue) bind(c, name='glColor3ub')
            import :: GLubyte
            integer(kind=GLubyte), intent(in), value :: red
            integer(kind=GLubyte), intent(in), value :: green
            integer(kind=GLubyte), intent(in), value :: blue
        end subroutine glcolor3ub

        ! void glColor3ui(GLuint red, GLuint green, GLuint blue)
        subroutine glcolor3ui(red, green, blue) bind(c, name='glColor3ui')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: red
            integer(kind=GLuint), intent(in), value :: green
            integer(kind=GLuint), intent(in), value :: blue
        end subroutine glcolor3ui

        ! void glColor3us(GLushort red, GLushort green, GLushort blue)
        subroutine glcolor3us(red, green, blue) bind(c, name='glColor3us')
            import :: GLushort
            integer(kind=GLushort), intent(in), value :: red
            integer(kind=GLushort), intent(in), value :: green
            integer(kind=GLushort), intent(in), value :: blue
        end subroutine glcolor3us

        ! void glColor4b(GLbyte red, GLbyte green, GLbyte blue, GLbyte alpha)
        subroutine glcolor4b(red, green, blue, alpha) bind(c, name='glColor4b')
            import :: GLbyte
            integer(kind=GLbyte), intent(in), value :: red
            integer(kind=GLbyte), intent(in), value :: green
            integer(kind=GLbyte), intent(in), value :: blue
            integer(kind=GLbyte), intent(in), value :: alpha
        end subroutine glcolor4b

        ! void glColor4d(GLdouble red, GLdouble green, GLdouble blue, GLdouble alpha)
        subroutine glcolor4d(red, green, blue, alpha) bind(c, name='glColor4d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: red
            real(kind=GLdouble), intent(in), value :: green
            real(kind=GLdouble), intent(in), value :: blue
            real(kind=GLdouble), intent(in), value :: alpha
        end subroutine glcolor4d

        ! void glColor4f(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha)
        subroutine glcolor4f(red, green, blue, alpha) bind(c, name='glColor4f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: red
            real(kind=GLfloat), intent(in), value :: green
            real(kind=GLfloat), intent(in), value :: blue
            real(kind=GLfloat), intent(in), value :: alpha
        end subroutine glcolor4f

        ! void glColor4i(GLint red, GLint green, GLint blue, GLint alpha)
        subroutine glcolor4i(red, green, blue, alpha) bind(c, name='glColor4i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: red
            integer(kind=GLint), intent(in), value :: green
            integer(kind=GLint), intent(in), value :: blue
            integer(kind=GLint), intent(in), value :: alpha
        end subroutine glcolor4i

        ! void glColor4s(GLshort red, GLshort green, GLshort blue, GLshort alpha)
        subroutine glcolor4s(red, green, blue, alpha) bind(c, name='glColor4s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: red
            integer(kind=GLshort), intent(in), value :: green
            integer(kind=GLshort), intent(in), value :: blue
            integer(kind=GLshort), intent(in), value :: alpha
        end subroutine glcolor4s

        ! void glColor4ub(GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha)
        subroutine glcolor4ub(red, green, blue, alpha) bind(c, name='glColor4ub')
            import :: GLubyte
            integer(kind=GLubyte), intent(in), value :: red
            integer(kind=GLubyte), intent(in), value :: green
            integer(kind=GLubyte), intent(in), value :: blue
            integer(kind=GLubyte), intent(in), value :: alpha
        end subroutine glcolor4ub

        ! void glColor4ui(GLuint red, GLuint green, GLuint blue, GLuint alpha)
        subroutine glcolor4ui(red, green, blue, alpha) bind(c, name='glColor4ui')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: red
            integer(kind=GLuint), intent(in), value :: green
            integer(kind=GLuint), intent(in), value :: blue
            integer(kind=GLuint), intent(in), value :: alpha
        end subroutine glcolor4ui

        ! void glColor4us(GLushort red, GLushort green, GLushort blue, GLushort alpha)
        subroutine glcolor4us(red, green, blue, alpha) bind(c, name='glColor4us')
            import :: GLushort
            integer(kind=GLushort), intent(in), value :: red
            integer(kind=GLushort), intent(in), value :: green
            integer(kind=GLushort), intent(in), value :: blue
            integer(kind=GLushort), intent(in), value :: alpha
        end subroutine glcolor4us

        ! void glColor3bv(const GLbyte *v)
        subroutine glcolor3bv(v) bind(c, name='glColor3bv')
            import :: GLbyte
            integer(kind=GLbyte), intent(in) :: v
        end subroutine glcolor3bv

        ! void glColor3dv(const GLdouble *v)
        subroutine glcolor3dv(v) bind(c, name='glColor3dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glcolor3dv

        ! void glColor3fv(const GLfloat *v)
        subroutine glcolor3fv(v) bind(c, name='glColor3fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glcolor3fv

        ! void glColor3iv(const GLint *v)
        subroutine glcolor3iv(v) bind(c, name='glColor3iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glcolor3iv

        ! void glColor3sv(const GLshort *v)
        subroutine glcolor3sv(v) bind(c, name='glColor3sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glcolor3sv

        ! void glColor3ubv(const GLubyte *v)
        subroutine glcolor3ubv(v) bind(c, name='glColor3ubv')
            import :: GLubyte
            integer(kind=GLubyte), intent(in) :: v
        end subroutine glcolor3ubv

        ! void glColor3uiv(const GLuint *v)
        subroutine glcolor3uiv(v) bind(c, name='glColor3uiv')
            import :: GLuint
            integer(kind=GLuint), intent(in) :: v
        end subroutine glcolor3uiv

        ! void glColor3usv(const GLushort *v)
        subroutine glcolor3usv(v) bind(c, name='glColor3usv')
            import :: GLushort
            integer(kind=GLushort), intent(in) :: v
        end subroutine glcolor3usv

        ! void glColor4bv(const GLbyte *v)
        subroutine glcolor4bv(v) bind(c, name='glColor4bv')
            import :: GLbyte
            integer(kind=GLbyte), intent(in) :: v
        end subroutine glcolor4bv

        ! void glColor4dv(const GLdouble *v)
        subroutine glcolor4dv(v) bind(c, name='glColor4dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glcolor4dv

        ! void glColor4fv(const GLfloat *v)
        subroutine glcolor4fv(v) bind(c, name='glColor4fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glcolor4fv

        ! void glColor4iv(const GLint *v)
        subroutine glcolor4iv(v) bind(c, name='glColor4iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glcolor4iv

        ! void glColor4sv(const GLshort *v)
        subroutine glcolor4sv(v) bind(c, name='glColor4sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glcolor4sv

        ! void glColor4ubv(const GLubyte *v)
        subroutine glcolor4ubv(v) bind(c, name='glColor4ubv')
            import :: GLubyte
            integer(kind=GLubyte), intent(in) :: v
        end subroutine glcolor4ubv

        ! void glColor4uiv(const GLuint *v)
        subroutine glcolor4uiv(v) bind(c, name='glColor4uiv')
            import :: GLuint
            integer(kind=GLuint), intent(in) :: v
        end subroutine glcolor4uiv

        ! void glColor4usv(const GLushort *v)
        subroutine glcolor4usv(v) bind(c, name='glColor4usv')
            import :: GLushort
            integer(kind=GLushort), intent(in) :: v
        end subroutine glcolor4usv

        ! void glTexCoord1d(GLdouble s)
        subroutine gltexcoord1d(s) bind(c, name='glTexCoord1d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: s
        end subroutine gltexcoord1d

        ! void glTexCoord1f(GLfloat s)
        subroutine gltexcoord1f(s) bind(c, name='glTexCoord1f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: s
        end subroutine gltexcoord1f

        ! void glTexCoord1i(GLint s)
        subroutine gltexcoord1i(s) bind(c, name='glTexCoord1i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: s
        end subroutine gltexcoord1i

        ! void glTexCoord1s(GLshort s)
        subroutine gltexcoord1s(s) bind(c, name='glTexCoord1s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: s
        end subroutine gltexcoord1s

        ! void glTexCoord2d(GLdouble s, GLdouble t)
        subroutine gltexcoord2d(s, t) bind(c, name='glTexCoord2d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: s
            real(kind=GLdouble), intent(in), value :: t
        end subroutine gltexcoord2d

        ! void glTexCoord2f(GLfloat s, GLfloat t)
        subroutine gltexcoord2f(s, t) bind(c, name='glTexCoord2f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: s
            real(kind=GLfloat), intent(in), value :: t
        end subroutine gltexcoord2f

        ! void glTexCoord2i(GLint s, GLint t)
        subroutine gltexcoord2i(s, t) bind(c, name='glTexCoord2i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: s
            integer(kind=GLint), intent(in), value :: t
        end subroutine gltexcoord2i

        ! void glTexCoord2s(GLshort s, GLshort t)
        subroutine gltexcoord2s(s, t) bind(c, name='glTexCoord2s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: s
            integer(kind=GLshort), intent(in), value :: t
        end subroutine gltexcoord2s

        ! void glTexCoord3d(GLdouble s, GLdouble t, GLdouble r)
        subroutine gltexcoord3d(s, t, r) bind(c, name='glTexCoord3d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: s
            real(kind=GLdouble), intent(in), value :: t
            real(kind=GLdouble), intent(in), value :: r
        end subroutine gltexcoord3d

        ! void glTexCoord3f(GLfloat s, GLfloat t, GLfloat r)
        subroutine gltexcoord3f(s, t, r) bind(c, name='glTexCoord3f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: s
            real(kind=GLfloat), intent(in), value :: t
            real(kind=GLfloat), intent(in), value :: r
        end subroutine gltexcoord3f

        ! void glTexCoord3i(GLint s, GLint t, GLint r)
        subroutine gltexcoord3i(s, t, r) bind(c, name='glTexCoord3i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: s
            integer(kind=GLint), intent(in), value :: t
            integer(kind=GLint), intent(in), value :: r
        end subroutine gltexcoord3i

        ! void glTexCoord3s(GLshort s, GLshort t, GLshort r)
        subroutine gltexcoord3s(s, t, r) bind(c, name='glTexCoord3s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: s
            integer(kind=GLshort), intent(in), value :: t
            integer(kind=GLshort), intent(in), value :: r
        end subroutine gltexcoord3s

        ! void glTexCoord4d(GLdouble s, GLdouble t, GLdouble r, GLdouble q)
        subroutine gltexcoord4d(s, t, r, q) bind(c, name='glTexCoord4d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: s
            real(kind=GLdouble), intent(in), value :: t
            real(kind=GLdouble), intent(in), value :: r
            real(kind=GLdouble), intent(in), value :: q
        end subroutine gltexcoord4d

        ! void glTexCoord4f(GLfloat s, GLfloat t, GLfloat r, GLfloat q)
        subroutine gltexcoord4f(s, t, r, q) bind(c, name='glTexCoord4f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: s
            real(kind=GLfloat), intent(in), value :: t
            real(kind=GLfloat), intent(in), value :: r
            real(kind=GLfloat), intent(in), value :: q
        end subroutine gltexcoord4f

        ! void glTexCoord4i(GLint s, GLint t, GLint r, GLint q)
        subroutine gltexcoord4i(s, t, r, q) bind(c, name='glTexCoord4i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: s
            integer(kind=GLint), intent(in), value :: t
            integer(kind=GLint), intent(in), value :: r
            integer(kind=GLint), intent(in), value :: q
        end subroutine gltexcoord4i

        ! void glTexCoord4s(GLshort s, GLshort t, GLshort r, GLshort q)
        subroutine gltexcoord4s(s, t, r, q) bind(c, name='glTexCoord4s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: s
            integer(kind=GLshort), intent(in), value :: t
            integer(kind=GLshort), intent(in), value :: r
            integer(kind=GLshort), intent(in), value :: q
        end subroutine gltexcoord4s

        ! void glTexCoord1dv(const GLdouble *v)
        subroutine gltexcoord1dv(v) bind(c, name='glTexCoord1dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine gltexcoord1dv

        ! void glTexCoord1fv(const GLfloat *v)
        subroutine gltexcoord1fv(v) bind(c, name='glTexCoord1fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine gltexcoord1fv

        ! void glTexCoord1iv(const GLint *v)
        subroutine gltexcoord1iv(v) bind(c, name='glTexCoord1iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine gltexcoord1iv

        ! void glTexCoord1sv(const GLshort *v)
        subroutine gltexcoord1sv(v) bind(c, name='glTexCoord1sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine gltexcoord1sv

        ! void glTexCoord2dv(const GLdouble *v)
        subroutine gltexcoord2dv(v) bind(c, name='glTexCoord2dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine gltexcoord2dv

        ! void glTexCoord2fv(const GLfloat *v)
        subroutine gltexcoord2fv(v) bind(c, name='glTexCoord2fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine gltexcoord2fv

        ! void glTexCoord2iv(const GLint *v)
        subroutine gltexcoord2iv(v) bind(c, name='glTexCoord2iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine gltexcoord2iv

        ! void glTexCoord2sv(const GLshort *v)
        subroutine gltexcoord2sv(v) bind(c, name='glTexCoord2sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine gltexcoord2sv

        ! void glTexCoord3dv(const GLdouble *v)
        subroutine gltexcoord3dv(v) bind(c, name='glTexCoord3dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine gltexcoord3dv

        ! void glTexCoord3fv(const GLfloat *v)
        subroutine gltexcoord3fv(v) bind(c, name='glTexCoord3fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine gltexcoord3fv

        ! void glTexCoord3iv(const GLint *v)
        subroutine gltexcoord3iv(v) bind(c, name='glTexCoord3iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine gltexcoord3iv

        ! void glTexCoord3sv(const GLshort *v)
        subroutine gltexcoord3sv(v) bind(c, name='glTexCoord3sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine gltexcoord3sv

        ! void glTexCoord4dv(const GLdouble *v)
        subroutine gltexcoord4dv(v) bind(c, name='glTexCoord4dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine gltexcoord4dv

        ! void glTexCoord4fv(const GLfloat *v)
        subroutine gltexcoord4fv(v) bind(c, name='glTexCoord4fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine gltexcoord4fv

        ! void glTexCoord4iv(const GLint *v)
        subroutine gltexcoord4iv(v) bind(c, name='glTexCoord4iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine gltexcoord4iv

        ! void glTexCoord4sv(const GLshort *v)
        subroutine gltexcoord4sv(v) bind(c, name='glTexCoord4sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine gltexcoord4sv

        ! void glRasterPos2d(GLdouble x, GLdouble y)
        subroutine glrasterpos2d(x, y) bind(c, name='glRasterPos2d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
        end subroutine glrasterpos2d

        ! void glRasterPos2f(GLfloat x, GLfloat y)
        subroutine glrasterpos2f(x, y) bind(c, name='glRasterPos2f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
        end subroutine glrasterpos2f

        ! void glRasterPos2i(GLint x, GLint y)
        subroutine glrasterpos2i(x, y) bind(c, name='glRasterPos2i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
        end subroutine glrasterpos2i

        ! void glRasterPos2s(GLshort x, GLshort y)
        subroutine glrasterpos2s(x, y) bind(c, name='glRasterPos2s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: x
            integer(kind=GLshort), intent(in), value :: y
        end subroutine glrasterpos2s

        ! void glRasterPos3d(GLdouble x, GLdouble y, GLdouble z)
        subroutine glrasterpos3d(x, y, z) bind(c, name='glRasterPos3d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
            real(kind=GLdouble), intent(in), value :: z
        end subroutine glrasterpos3d

        ! void glRasterPos3f(GLfloat x, GLfloat y, GLfloat z)
        subroutine glrasterpos3f(x, y, z) bind(c, name='glRasterPos3f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
            real(kind=GLfloat), intent(in), value :: z
        end subroutine glrasterpos3f

        ! void glRasterPos3i(GLint x, GLint y, GLint z)
        subroutine glrasterpos3i(x, y, z) bind(c, name='glRasterPos3i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLint), intent(in), value :: z
        end subroutine glrasterpos3i

        ! void glRasterPos3s(GLshort x, GLshort y, GLshort z)
        subroutine glrasterpos3s(x, y, z) bind(c, name='glRasterPos3s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: x
            integer(kind=GLshort), intent(in), value :: y
            integer(kind=GLshort), intent(in), value :: z
        end subroutine glrasterpos3s

        ! void glRasterPos4d(GLdouble x, GLdouble y, GLdouble z, GLdouble w)
        subroutine glrasterpos4d(x, y, z, w) bind(c, name='glRasterPos4d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x
            real(kind=GLdouble), intent(in), value :: y
            real(kind=GLdouble), intent(in), value :: z
            real(kind=GLdouble), intent(in), value :: w
        end subroutine glrasterpos4d

        ! void glRasterPos4f(GLfloat x, GLfloat y, GLfloat z, GLfloat w)
        subroutine glrasterpos4f(x, y, z, w) bind(c, name='glRasterPos4f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x
            real(kind=GLfloat), intent(in), value :: y
            real(kind=GLfloat), intent(in), value :: z
            real(kind=GLfloat), intent(in), value :: w
        end subroutine glrasterpos4f

        ! void glRasterPos4i(GLint x, GLint y, GLint z, GLint w)
        subroutine glrasterpos4i(x, y, z, w) bind(c, name='glRasterPos4i')
            import :: GLint
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLint), intent(in), value :: z
            integer(kind=GLint), intent(in), value :: w
        end subroutine glrasterpos4i

        ! void glRasterPos4s(GLshort x, GLshort y, GLshort z, GLshort w)
        subroutine glrasterpos4s(x, y, z, w) bind(c, name='glRasterPos4s')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: x
            integer(kind=GLshort), intent(in), value :: y
            integer(kind=GLshort), intent(in), value :: z
            integer(kind=GLshort), intent(in), value :: w
        end subroutine glrasterpos4s

        ! void glRasterPos2dv(const GLdouble *v)
        subroutine glrasterpos2dv(v) bind(c, name='glRasterPos2dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glrasterpos2dv

        ! void glRasterPos2fv(const GLfloat *v)
        subroutine glrasterpos2fv(v) bind(c, name='glRasterPos2fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glrasterpos2fv

        ! void glRasterPos2iv(const GLint *v)
        subroutine glrasterpos2iv(v) bind(c, name='glRasterPos2iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glrasterpos2iv

        ! void glRasterPos2sv(const GLshort *v)
        subroutine glrasterpos2sv(v) bind(c, name='glRasterPos2sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glrasterpos2sv

        ! void glRasterPos3dv(const GLdouble *v)
        subroutine glrasterpos3dv(v) bind(c, name='glRasterPos3dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glrasterpos3dv

        ! void glRasterPos3fv(const GLfloat *v)
        subroutine glrasterpos3fv(v) bind(c, name='glRasterPos3fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glrasterpos3fv

        ! void glRasterPos3iv(const GLint *v)
        subroutine glrasterpos3iv(v) bind(c, name='glRasterPos3iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glrasterpos3iv

        ! void glRasterPos3sv(const GLshort *v)
        subroutine glrasterpos3sv(v) bind(c, name='glRasterPos3sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glrasterpos3sv

        ! void glRasterPos4dv(const GLdouble *v)
        subroutine glrasterpos4dv(v) bind(c, name='glRasterPos4dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v
        end subroutine glrasterpos4dv

        ! void glRasterPos4fv(const GLfloat *v)
        subroutine glrasterpos4fv(v) bind(c, name='glRasterPos4fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v
        end subroutine glrasterpos4fv

        ! void glRasterPos4iv(const GLint *v)
        subroutine glrasterpos4iv(v) bind(c, name='glRasterPos4iv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v
        end subroutine glrasterpos4iv

        ! void glRasterPos4sv(const GLshort *v)
        subroutine glrasterpos4sv(v) bind(c, name='glRasterPos4sv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v
        end subroutine glrasterpos4sv

        ! void glRectd(GLdouble x1, GLdouble y1, GLdouble x2, GLdouble y2)
        subroutine glrectd(x1, y1, x2, y2) bind(c, name='glRectd')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: x1
            real(kind=GLdouble), intent(in), value :: y1
            real(kind=GLdouble), intent(in), value :: x2
            real(kind=GLdouble), intent(in), value :: y2
        end subroutine glrectd

        ! void glRectf(GLfloat x1, GLfloat y1, GLfloat x2, GLfloat y2)
        subroutine glrectf(x1, y1, x2, y2) bind(c, name='glRectf')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: x1
            real(kind=GLfloat), intent(in), value :: y1
            real(kind=GLfloat), intent(in), value :: x2
            real(kind=GLfloat), intent(in), value :: y2
        end subroutine glrectf

        ! void glRecti(GLint x1, GLint y1, GLint x2, GLint y2)
        subroutine glrecti(x1, y1, x2, y2) bind(c, name='glRecti')
            import :: GLint
            integer(kind=GLint), intent(in), value :: x1
            integer(kind=GLint), intent(in), value :: y1
            integer(kind=GLint), intent(in), value :: x2
            integer(kind=GLint), intent(in), value :: y2
        end subroutine glrecti

        ! void glRects(GLshort x1, GLshort y1, GLshort x2, GLshort y2)
        subroutine glrects(x1, y1, x2, y2) bind(c, name='glRects')
            import :: GLshort
            integer(kind=GLshort), intent(in), value :: x1
            integer(kind=GLshort), intent(in), value :: y1
            integer(kind=GLshort), intent(in), value :: x2
            integer(kind=GLshort), intent(in), value :: y2
        end subroutine glrects

        ! void glRectdv(const GLdouble *v1, const GLdouble *v2)
        subroutine glrectdv(v1, v2) bind(c, name='glRectdv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: v1
            real(kind=GLdouble), intent(in) :: v2
        end subroutine glrectdv

        ! void glRectfv(const GLfloat *v1, const GLfloat *v2)
        subroutine glrectfv(v1, v2) bind(c, name='glRectfv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: v1
            real(kind=GLfloat), intent(in) :: v2
        end subroutine glrectfv

        ! void glRectiv(const GLint *v1, const GLint *v2)
        subroutine glrectiv(v1, v2) bind(c, name='glRectiv')
            import :: GLint
            integer(kind=GLint), intent(in) :: v1
            integer(kind=GLint), intent(in) :: v2
        end subroutine glrectiv

        ! void glRectsv(const GLshort *v1, const GLshort *v2)
        subroutine glrectsv(v1, v2) bind(c, name='glRectsv')
            import :: GLshort
            integer(kind=GLshort), intent(in) :: v1
            integer(kind=GLshort), intent(in) :: v2
        end subroutine glrectsv

        ! void glVertexPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr)
        subroutine glvertexpointer(size, type, stride, ptr) bind(c, name='glVertexPointer')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLint), intent(in), value :: size
            integer(kind=GLenum), intent(in), value :: type
            integer(kind=GLsizei), intent(in), value :: stride
            type(c_ptr), intent(in) :: ptr
        end subroutine glvertexpointer

        ! void glNormalPointer(GLenum type, GLsizei stride, const GLvoid *ptr)
        subroutine glnormalpointer(type, stride, ptr) bind(c, name='glNormalPointer')
            import :: GLenum, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: type
            integer(kind=GLsizei), intent(in), value :: stride
            type(c_ptr), intent(in) :: ptr
        end subroutine glnormalpointer

        ! void glColorPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr)
        subroutine glcolorpointer(size, type, stride, ptr) bind(c, name='glColorPointer')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLint), intent(in), value :: size
            integer(kind=GLenum), intent(in), value :: type
            integer(kind=GLsizei), intent(in), value :: stride
            type(c_ptr), intent(in) :: ptr
        end subroutine glcolorpointer

        ! void glIndexPointer(GLenum type, GLsizei stride, const GLvoid *ptr)
        subroutine glindexpointer(type, stride, ptr) bind(c, name='glIndexPointer')
            import :: GLenum, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: type
            integer(kind=GLsizei), intent(in), value :: stride
            type(c_ptr), intent(in) :: ptr
        end subroutine glindexpointer

        ! void glTexCoordPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr)
        subroutine gltexcoordpointer(size, type, stride, ptr) bind(c, name='glTexCoordPointer')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLint), intent(in), value :: size
            integer(kind=GLenum), intent(in), value :: type
            integer(kind=GLsizei), intent(in), value :: stride
            type(c_ptr), intent(in) :: ptr
        end subroutine gltexcoordpointer

        ! void glEdgeFlagPointer(GLsizei stride, const GLvoid *ptr)
        subroutine gledgeflagpointer(stride, ptr) bind(c, name='glEdgeFlagPointer')
            import :: GLsizei, c_ptr
            integer(kind=GLsizei), intent(in), value :: stride
            type(c_ptr), intent(in) :: ptr
        end subroutine gledgeflagpointer

        ! void glGetPointerv(GLenum pname, GLvoid **params)
        subroutine glgetpointerv(pname, params) bind(c, name='glGetPointerv')
            import :: GLenum, c_ptr
            integer(kind=GLenum), intent(in), value :: pname
            type(c_ptr), intent(in) :: params
        end subroutine glgetpointerv

        ! void glArrayElement(GLint i)
        subroutine glarrayelement(i) bind(c, name='glArrayElement')
            import :: GLint
            integer(kind=GLint), intent(in), value :: i
        end subroutine glarrayelement

        ! void glDrawArrays(GLenum mode, GLint first, GLsizei count)
        subroutine gldrawarrays(mode, first, count) bind(c, name='glDrawArrays')
            import :: GLenum, GLint, GLsizei
            integer(kind=GLenum), intent(in), value :: mode
            integer(kind=GLint), intent(in), value :: first
            integer(kind=GLsizei), intent(in), value :: count
        end subroutine gldrawarrays

        ! void glDrawElements(GLenum mode, GLsizei count, GLenum type, const GLvoid *indices)
        subroutine gldrawelements(mode, count, type, indices) bind(c, name='glDrawElements')
            import :: GLenum, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: mode
            integer(kind=GLsizei), intent(in), value :: count
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: indices
        end subroutine gldrawelements

        ! void glInterleavedArrays(GLenum format, GLsizei stride, const GLvoid *pointer)
        subroutine glinterleavedarrays(format, stride, pointer) bind(c, name='glInterleavedArrays')
            import :: GLenum, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLsizei), intent(in), value :: stride
            type(c_ptr), intent(in) :: pointer
        end subroutine glinterleavedarrays

        ! void glShadeModel(GLenum mode)
        subroutine glshademodel(mode) bind(c, name='glShadeModel')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glshademodel

        ! void glLightf(GLenum light, GLenum pname, GLfloat param)
        subroutine gllightf(light, pname, param) bind(c, name='glLightf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: light
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine gllightf

        ! void glLighti(GLenum light, GLenum pname, GLint param)
        subroutine gllighti(light, pname, param) bind(c, name='glLighti')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: light
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine gllighti

        ! void glLightfv(GLenum light, GLenum pname, const GLfloat *params)
        subroutine gllightfv(light, pname, params) bind(c, name='glLightfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: light
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine gllightfv

        ! void glLightiv(GLenum light, GLenum pname, const GLint *params)
        subroutine gllightiv(light, pname, params) bind(c, name='glLightiv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: light
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine gllightiv

        ! void glGetLightfv(GLenum light, GLenum pname, GLfloat *params)
        subroutine glgetlightfv(light, pname, params) bind(c, name='glGetLightfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: light
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glgetlightfv

        ! void glGetLightiv(GLenum light, GLenum pname, GLint *params)
        subroutine glgetlightiv(light, pname, params) bind(c, name='glGetLightiv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: light
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glgetlightiv

        ! void glLightModelf(GLenum pname, GLfloat param)
        subroutine gllightmodelf(pname, param) bind(c, name='glLightModelf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine gllightmodelf

        ! void glLightModeli(GLenum pname, GLint param)
        subroutine gllightmodeli(pname, param) bind(c, name='glLightModeli')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine gllightmodeli

        ! void glLightModelfv(GLenum pname, const GLfloat *params)
        subroutine gllightmodelfv(pname, params) bind(c, name='glLightModelfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine gllightmodelfv

        ! void glLightModeliv(GLenum pname, const GLint *params)
        subroutine gllightmodeliv(pname, params) bind(c, name='glLightModeliv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine gllightmodeliv

        ! void glMaterialf(GLenum face, GLenum pname, GLfloat param)
        subroutine glmaterialf(face, pname, param) bind(c, name='glMaterialf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine glmaterialf

        ! void glMateriali(GLenum face, GLenum pname, GLint param)
        subroutine glmateriali(face, pname, param) bind(c, name='glMateriali')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine glmateriali

        ! void glMaterialfv(GLenum face, GLenum pname, const GLfloat *params)
        subroutine glmaterialfv(face, pname, params) bind(c, name='glMaterialfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glmaterialfv

        ! void glMaterialiv(GLenum face, GLenum pname, const GLint *params)
        subroutine glmaterialiv(face, pname, params) bind(c, name='glMaterialiv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glmaterialiv

        ! void glGetMaterialfv(GLenum face, GLenum pname, GLfloat *params)
        subroutine glgetmaterialfv(face, pname, params) bind(c, name='glGetMaterialfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glgetmaterialfv

        ! void glGetMaterialiv(GLenum face, GLenum pname, GLint *params)
        subroutine glgetmaterialiv(face, pname, params) bind(c, name='glGetMaterialiv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glgetmaterialiv

        ! void glColorMaterial(GLenum face, GLenum mode)
        subroutine glcolormaterial(face, mode) bind(c, name='glColorMaterial')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: face
            integer(kind=GLenum), intent(in), value :: mode
        end subroutine glcolormaterial

        ! void glPixelZoom(GLfloat xfactor, GLfloat yfactor)
        subroutine glpixelzoom(xfactor, yfactor) bind(c, name='glPixelZoom')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: xfactor
            real(kind=GLfloat), intent(in), value :: yfactor
        end subroutine glpixelzoom

        ! void glPixelStoref(GLenum pname, GLfloat param)
        subroutine glpixelstoref(pname, param) bind(c, name='glPixelStoref')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine glpixelstoref

        ! void glPixelStorei(GLenum pname, GLint param)
        subroutine glpixelstorei(pname, param) bind(c, name='glPixelStorei')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine glpixelstorei

        ! void glPixelTransferf(GLenum pname, GLfloat param)
        subroutine glpixeltransferf(pname, param) bind(c, name='glPixelTransferf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine glpixeltransferf

        ! void glPixelTransferi(GLenum pname, GLint param)
        subroutine glpixeltransferi(pname, param) bind(c, name='glPixelTransferi')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine glpixeltransferi

        ! void glPixelMapfv(GLenum map, GLsizei mapsize, const GLfloat *values)
        subroutine glpixelmapfv(map, mapsize, values) bind(c, name='glPixelMapfv')
            import :: GLenum, GLfloat, GLsizei
            integer(kind=GLenum), intent(in), value :: map
            integer(kind=GLsizei), intent(in), value :: mapsize
            real(kind=GLfloat), intent(in) :: values
        end subroutine glpixelmapfv

        ! void glPixelMapuiv(GLenum map, GLsizei mapsize, const GLuint *values)
        subroutine glpixelmapuiv(map, mapsize, values) bind(c, name='glPixelMapuiv')
            import :: GLenum, GLsizei, GLuint
            integer(kind=GLenum), intent(in), value :: map
            integer(kind=GLsizei), intent(in), value :: mapsize
            integer(kind=GLuint), intent(in) :: values
        end subroutine glpixelmapuiv

        ! void glPixelMapusv(GLenum map, GLsizei mapsize, const GLushort *values)
        subroutine glpixelmapusv(map, mapsize, values) bind(c, name='glPixelMapusv')
            import :: GLenum, GLsizei, GLushort
            integer(kind=GLenum), intent(in), value :: map
            integer(kind=GLsizei), intent(in), value :: mapsize
            integer(kind=GLushort), intent(in) :: values
        end subroutine glpixelmapusv

        ! void glGetPixelMapfv(GLenum map, GLfloat *values)
        subroutine glgetpixelmapfv(map, values) bind(c, name='glGetPixelMapfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: map
            real(kind=GLfloat), intent(in) :: values
        end subroutine glgetpixelmapfv

        ! void glGetPixelMapuiv(GLenum map, GLuint *values)
        subroutine glgetpixelmapuiv(map, values) bind(c, name='glGetPixelMapuiv')
            import :: GLenum, GLuint
            integer(kind=GLenum), intent(in), value :: map
            integer(kind=GLuint), intent(in) :: values
        end subroutine glgetpixelmapuiv

        ! void glGetPixelMapusv(GLenum map, GLushort *values)
        subroutine glgetpixelmapusv(map, values) bind(c, name='glGetPixelMapusv')
            import :: GLenum, GLushort
            integer(kind=GLenum), intent(in), value :: map
            integer(kind=GLushort), intent(in) :: values
        end subroutine glgetpixelmapusv

        ! void glBitmap(GLsizei width, GLsizei height, GLfloat xorig, GLfloat yorig, GLfloat xmove, GLfloat ymove, const GLubyte *bitmap)
        subroutine glbitmap(width, height, xorig, yorig, xmove, ymove, bitmap) bind(c, name='glBitmap')
            import :: GLfloat, GLsizei, GLubyte
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
            real(kind=GLfloat), intent(in), value :: xorig
            real(kind=GLfloat), intent(in), value :: yorig
            real(kind=GLfloat), intent(in), value :: xmove
            real(kind=GLfloat), intent(in), value :: ymove
            integer(kind=GLubyte), intent(in) :: bitmap
        end subroutine glbitmap

        ! void glReadPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels)
        subroutine glreadpixels(x, y, width, height, format, type, pixels) bind(c, name='glReadPixels')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: pixels
        end subroutine glreadpixels

        ! void glDrawPixels(GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels)
        subroutine gldrawpixels(width, height, format, type, pixels) bind(c, name='glDrawPixels')
            import :: GLenum, GLsizei, c_ptr
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: pixels
        end subroutine gldrawpixels

        ! void glCopyPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum type)
        subroutine glcopypixels(x, y, width, height, type) bind(c, name='glCopyPixels')
            import :: GLenum, GLint, GLsizei
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
            integer(kind=GLenum), intent(in), value :: type
        end subroutine glcopypixels

        ! void glStencilFunc(GLenum func, GLint ref, GLuint mask)
        subroutine glstencilfunc(func, ref, mask) bind(c, name='glStencilFunc')
            import :: GLenum, GLint, GLuint
            integer(kind=GLenum), intent(in), value :: func
            integer(kind=GLint), intent(in), value :: ref
            integer(kind=GLuint), intent(in), value :: mask
        end subroutine glstencilfunc

        ! void glStencilMask(GLuint mask)
        subroutine glstencilmask(mask) bind(c, name='glStencilMask')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: mask
        end subroutine glstencilmask

        ! void glStencilOp(GLenum fail, GLenum zfail, GLenum zpass)
        subroutine glstencilop(fail, zfail, zpass) bind(c, name='glStencilOp')
            import :: GLenum
            integer(kind=GLenum), intent(in), value :: fail
            integer(kind=GLenum), intent(in), value :: zfail
            integer(kind=GLenum), intent(in), value :: zpass
        end subroutine glstencilop

        ! void glClearStencil(GLint s)
        subroutine glclearstencil(s) bind(c, name='glClearStencil')
            import :: GLint
            integer(kind=GLint), intent(in), value :: s
        end subroutine glclearstencil

        ! void glTexGend(GLenum coord, GLenum pname, GLdouble param)
        subroutine gltexgend(coord, pname, param) bind(c, name='glTexGend')
            import :: GLdouble, GLenum
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLdouble), intent(in), value :: param
        end subroutine gltexgend

        ! void glTexGenf(GLenum coord, GLenum pname, GLfloat param)
        subroutine gltexgenf(coord, pname, param) bind(c, name='glTexGenf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine gltexgenf

        ! void glTexGeni(GLenum coord, GLenum pname, GLint param)
        subroutine gltexgeni(coord, pname, param) bind(c, name='glTexGeni')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine gltexgeni

        ! void glTexGendv(GLenum coord, GLenum pname, const GLdouble *params)
        subroutine gltexgendv(coord, pname, params) bind(c, name='glTexGendv')
            import :: GLdouble, GLenum
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLdouble), intent(in) :: params
        end subroutine gltexgendv

        ! void glTexGenfv(GLenum coord, GLenum pname, const GLfloat *params)
        subroutine gltexgenfv(coord, pname, params) bind(c, name='glTexGenfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine gltexgenfv

        ! void glTexGeniv(GLenum coord, GLenum pname, const GLint *params)
        subroutine gltexgeniv(coord, pname, params) bind(c, name='glTexGeniv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine gltexgeniv

        ! void glGetTexGendv(GLenum coord, GLenum pname, GLdouble *params)
        subroutine glgettexgendv(coord, pname, params) bind(c, name='glGetTexGendv')
            import :: GLdouble, GLenum
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLdouble), intent(in) :: params
        end subroutine glgettexgendv

        ! void glGetTexGenfv(GLenum coord, GLenum pname, GLfloat *params)
        subroutine glgettexgenfv(coord, pname, params) bind(c, name='glGetTexGenfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glgettexgenfv

        ! void glGetTexGeniv(GLenum coord, GLenum pname, GLint *params)
        subroutine glgettexgeniv(coord, pname, params) bind(c, name='glGetTexGeniv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: coord
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glgettexgeniv

        ! void glTexEnvf(GLenum target, GLenum pname, GLfloat param)
        subroutine gltexenvf(target, pname, param) bind(c, name='glTexEnvf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine gltexenvf

        ! void glTexEnvi(GLenum target, GLenum pname, GLint param)
        subroutine gltexenvi(target, pname, param) bind(c, name='glTexEnvi')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine gltexenvi

        ! void glTexEnvfv(GLenum target, GLenum pname, const GLfloat *params)
        subroutine gltexenvfv(target, pname, params) bind(c, name='glTexEnvfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine gltexenvfv

        ! void glTexEnviv(GLenum target, GLenum pname, const GLint *params)
        subroutine gltexenviv(target, pname, params) bind(c, name='glTexEnviv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine gltexenviv

        ! void glGetTexEnvfv(GLenum target, GLenum pname, GLfloat *params)
        subroutine glgettexenvfv(target, pname, params) bind(c, name='glGetTexEnvfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glgettexenvfv

        ! void glGetTexEnviv(GLenum target, GLenum pname, GLint *params)
        subroutine glgettexenviv(target, pname, params) bind(c, name='glGetTexEnviv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glgettexenviv

        ! void glTexParameterf(GLenum target, GLenum pname, GLfloat param)
        subroutine gltexparameterf(target, pname, param) bind(c, name='glTexParameterf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine gltexparameterf

        ! void glTexParameteri(GLenum target, GLenum pname, GLint param)
        subroutine gltexparameteri(target, pname, param) bind(c, name='glTexParameteri')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine gltexparameteri

        ! void glTexParameterfv(GLenum target, GLenum pname, const GLfloat *params)
        subroutine gltexparameterfv(target, pname, params) bind(c, name='glTexParameterfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine gltexparameterfv

        ! void glTexParameteriv(GLenum target, GLenum pname, const GLint *params)
        subroutine gltexparameteriv(target, pname, params) bind(c, name='glTexParameteriv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine gltexparameteriv

        ! void glGetTexParameterfv(GLenum target, GLenum pname, GLfloat *params)
        subroutine glgettexparameterfv(target, pname, params) bind(c, name='glGetTexParameterfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glgettexparameterfv

        ! void glGetTexParameteriv(GLenum target, GLenum pname, GLint *params)
        subroutine glgettexparameteriv(target, pname, params) bind(c, name='glGetTexParameteriv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glgettexparameteriv

        ! void glGetTexLevelParameterfv(GLenum target, GLint level, GLenum pname, GLfloat *params)
        subroutine glgettexlevelparameterfv(target, level, pname, params) bind(c, name='glGetTexLevelParameterfv')
            import :: GLenum, GLfloat, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glgettexlevelparameterfv

        ! void glGetTexLevelParameteriv(GLenum target, GLint level, GLenum pname, GLint *params)
        subroutine glgettexlevelparameteriv(target, level, pname, params) bind(c, name='glGetTexLevelParameteriv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glgettexlevelparameteriv

        ! void glTexImage1D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels)
        subroutine glteximage1d(target, level, internalFormat, width, border, format, type, pixels) bind(c, name='glTexImage1D')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLint), intent(in), value :: internalFormat
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLint), intent(in), value :: border
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: pixels
        end subroutine glteximage1d

        ! void glTexImage2D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels)
        subroutine glteximage2d(target, level, internalFormat, width, height, border, format, type, pixels) &
                bind(c, name='glTexImage2D')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLint), intent(in), value :: internalFormat
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
            integer(kind=GLint), intent(in), value :: border
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: pixels
        end subroutine glteximage2d

        ! void glGetTexImage(GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels)
        subroutine glgetteximage(target, level, format, type, pixels) bind(c, name='glGetTexImage')
            import :: GLenum, GLint, c_ptr
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: pixels
        end subroutine glgetteximage

        ! void glGenTextures(GLsizei n, GLuint *textures)
        subroutine glgentextures(n, textures) bind(c, name='glGenTextures')
            import :: GLsizei, GLuint
            integer(kind=GLsizei), intent(in), value :: n
            integer(kind=GLuint), intent(in) :: textures
        end subroutine glgentextures

        ! void glDeleteTextures(GLsizei n, const GLuint *textures)
        subroutine gldeletetextures(n, textures) bind(c, name='glDeleteTextures')
            import :: GLsizei, GLuint
            integer(kind=GLsizei), intent(in), value :: n
            integer(kind=GLuint), intent(in) :: textures
        end subroutine gldeletetextures

        ! void glBindTexture(GLenum target, GLuint texture)
        subroutine glbindtexture(target, texture) bind(c, name='glBindTexture')
            import :: GLenum, GLuint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLuint), intent(in), value :: texture
        end subroutine glbindtexture

        ! void glPrioritizeTextures(GLsizei n, const GLuint *textures, const GLclampf *priorities)
        subroutine glprioritizetextures(n, textures, priorities) bind(c, name='glPrioritizeTextures')
            import :: GLclampf, GLsizei, GLuint
            integer(kind=GLsizei), intent(in), value :: n
            integer(kind=GLuint), intent(in) :: textures
            real(kind=GLclampf), intent(in) :: priorities
        end subroutine glprioritizetextures

        ! void glTexSubImage1D(GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels)
        subroutine gltexsubimage1d(target, level, xoffset, width, format, type, pixels) bind(c, name='glTexSubImage1D')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLint), intent(in), value :: xoffset
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: pixels
        end subroutine gltexsubimage1d

        ! void glTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels)
        subroutine gltexsubimage2d(target, level, xoffset, yoffset, width, height, format, type, pixels) &
                bind(c, name='glTexSubImage2D')
            import :: GLenum, GLint, GLsizei, c_ptr
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLint), intent(in), value :: xoffset
            integer(kind=GLint), intent(in), value :: yoffset
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
            integer(kind=GLenum), intent(in), value :: format
            integer(kind=GLenum), intent(in), value :: type
            type(c_ptr), intent(in) :: pixels
        end subroutine gltexsubimage2d

        ! void glCopyTexImage1D(GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border)
        subroutine glcopyteximage1d(target, level, internalformat, x, y, width, border) bind(c, name='glCopyTexImage1D')
            import :: GLenum, GLint, GLsizei
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLenum), intent(in), value :: internalformat
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLint), intent(in), value :: border
        end subroutine glcopyteximage1d

        ! void glCopyTexImage2D(GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border)
        subroutine glcopyteximage2d(target, level, internalformat, x, y, width, height, border) bind(c, name='glCopyTexImage2D')
            import :: GLenum, GLint, GLsizei
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLenum), intent(in), value :: internalformat
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
            integer(kind=GLint), intent(in), value :: border
        end subroutine glcopyteximage2d

        ! void glCopyTexSubImage1D(GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width)
        subroutine glcopytexsubimage1d(target, level, xoffset, x, y, width) bind(c, name='glCopyTexSubImage1D')
            import :: GLenum, GLint, GLsizei
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLint), intent(in), value :: xoffset
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
        end subroutine glcopytexsubimage1d

        ! void glCopyTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height)
        subroutine glcopytexsubimage2d(target, level, xoffset, yoffset, x, y, width, height) bind(c, name='glCopyTexSubImage2D')
            import :: GLenum, GLint, GLsizei
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLint), intent(in), value :: level
            integer(kind=GLint), intent(in), value :: xoffset
            integer(kind=GLint), intent(in), value :: yoffset
            integer(kind=GLint), intent(in), value :: x
            integer(kind=GLint), intent(in), value :: y
            integer(kind=GLsizei), intent(in), value :: width
            integer(kind=GLsizei), intent(in), value :: height
        end subroutine glcopytexsubimage2d

        ! void glMap1d(GLenum target, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points)
        subroutine glmap1d(target, u1, u2, stride, order, points) bind(c, name='glMap1d')
            import :: GLdouble, GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            real(kind=GLdouble), intent(in), value :: u1
            real(kind=GLdouble), intent(in), value :: u2
            integer(kind=GLint), intent(in), value :: stride
            integer(kind=GLint), intent(in), value :: order
            real(kind=GLdouble), intent(in) :: points
        end subroutine glmap1d

        ! void glMap1f(GLenum target, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points)
        subroutine glmap1f(target, u1, u2, stride, order, points) bind(c, name='glMap1f')
            import :: GLenum, GLfloat, GLint
            integer(kind=GLenum), intent(in), value :: target
            real(kind=GLfloat), intent(in), value :: u1
            real(kind=GLfloat), intent(in), value :: u2
            integer(kind=GLint), intent(in), value :: stride
            integer(kind=GLint), intent(in), value :: order
            real(kind=GLfloat), intent(in) :: points
        end subroutine glmap1f

        ! void glMap2d(GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points)
        subroutine glmap2d(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points) bind(c, name='glMap2d')
            import :: GLdouble, GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            real(kind=GLdouble), intent(in), value :: u1
            real(kind=GLdouble), intent(in), value :: u2
            integer(kind=GLint), intent(in), value :: ustride
            integer(kind=GLint), intent(in), value :: uorder
            real(kind=GLdouble), intent(in), value :: v1
            real(kind=GLdouble), intent(in), value :: v2
            integer(kind=GLint), intent(in), value :: vstride
            integer(kind=GLint), intent(in), value :: vorder
            real(kind=GLdouble), intent(in) :: points
        end subroutine glmap2d

        ! void glMap2f(GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points)
        subroutine glmap2f(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points) bind(c, name='glMap2f')
            import :: GLenum, GLfloat, GLint
            integer(kind=GLenum), intent(in), value :: target
            real(kind=GLfloat), intent(in), value :: u1
            real(kind=GLfloat), intent(in), value :: u2
            integer(kind=GLint), intent(in), value :: ustride
            integer(kind=GLint), intent(in), value :: uorder
            real(kind=GLfloat), intent(in), value :: v1
            real(kind=GLfloat), intent(in), value :: v2
            integer(kind=GLint), intent(in), value :: vstride
            integer(kind=GLint), intent(in), value :: vorder
            real(kind=GLfloat), intent(in) :: points
        end subroutine glmap2f

        ! void glGetMapdv(GLenum target, GLenum query, GLdouble *v)
        subroutine glgetmapdv(target, query, v) bind(c, name='glGetMapdv')
            import :: GLdouble, GLenum
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: query
            real(kind=GLdouble), intent(in) :: v
        end subroutine glgetmapdv

        ! void glGetMapfv(GLenum target, GLenum query, GLfloat *v)
        subroutine glgetmapfv(target, query, v) bind(c, name='glGetMapfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: query
            real(kind=GLfloat), intent(in) :: v
        end subroutine glgetmapfv

        ! void glGetMapiv(GLenum target, GLenum query, GLint *v)
        subroutine glgetmapiv(target, query, v) bind(c, name='glGetMapiv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: target
            integer(kind=GLenum), intent(in), value :: query
            integer(kind=GLint), intent(in) :: v
        end subroutine glgetmapiv

        ! void glEvalCoord1d(GLdouble u)
        subroutine glevalcoord1d(u) bind(c, name='glEvalCoord1d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: u
        end subroutine glevalcoord1d

        ! void glEvalCoord1f(GLfloat u)
        subroutine glevalcoord1f(u) bind(c, name='glEvalCoord1f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: u
        end subroutine glevalcoord1f

        ! void glEvalCoord1dv(const GLdouble *u)
        subroutine glevalcoord1dv(u) bind(c, name='glEvalCoord1dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: u
        end subroutine glevalcoord1dv

        ! void glEvalCoord1fv(const GLfloat *u)
        subroutine glevalcoord1fv(u) bind(c, name='glEvalCoord1fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: u
        end subroutine glevalcoord1fv

        ! void glEvalCoord2d(GLdouble u, GLdouble v)
        subroutine glevalcoord2d(u, v) bind(c, name='glEvalCoord2d')
            import :: GLdouble
            real(kind=GLdouble), intent(in), value :: u
            real(kind=GLdouble), intent(in), value :: v
        end subroutine glevalcoord2d

        ! void glEvalCoord2f(GLfloat u, GLfloat v)
        subroutine glevalcoord2f(u, v) bind(c, name='glEvalCoord2f')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: u
            real(kind=GLfloat), intent(in), value :: v
        end subroutine glevalcoord2f

        ! void glEvalCoord2dv(const GLdouble *u)
        subroutine glevalcoord2dv(u) bind(c, name='glEvalCoord2dv')
            import :: GLdouble
            real(kind=GLdouble), intent(in) :: u
        end subroutine glevalcoord2dv

        ! void glEvalCoord2fv(const GLfloat *u)
        subroutine glevalcoord2fv(u) bind(c, name='glEvalCoord2fv')
            import :: GLfloat
            real(kind=GLfloat), intent(in) :: u
        end subroutine glevalcoord2fv

        ! void glMapGrid1d(GLint un, GLdouble u1, GLdouble u2)
        subroutine glmapgrid1d(un, u1, u2) bind(c, name='glMapGrid1d')
            import :: GLdouble, GLint
            integer(kind=GLint), intent(in), value :: un
            real(kind=GLdouble), intent(in), value :: u1
            real(kind=GLdouble), intent(in), value :: u2
        end subroutine glmapgrid1d

        ! void glMapGrid1f(GLint un, GLfloat u1, GLfloat u2)
        subroutine glmapgrid1f(un, u1, u2) bind(c, name='glMapGrid1f')
            import :: GLfloat, GLint
            integer(kind=GLint), intent(in), value :: un
            real(kind=GLfloat), intent(in), value :: u1
            real(kind=GLfloat), intent(in), value :: u2
        end subroutine glmapgrid1f

        ! void glMapGrid2d(GLint un, GLdouble u1, GLdouble u2, GLint vn, GLdouble v1, GLdouble v2)
        subroutine glmapgrid2d(un, u1, u2, vn, v1, v2) bind(c, name='glMapGrid2d')
            import :: GLdouble, GLint
            integer(kind=GLint), intent(in), value :: un
            real(kind=GLdouble), intent(in), value :: u1
            real(kind=GLdouble), intent(in), value :: u2
            integer(kind=GLint), intent(in), value :: vn
            real(kind=GLdouble), intent(in), value :: v1
            real(kind=GLdouble), intent(in), value :: v2
        end subroutine glmapgrid2d

        ! void glMapGrid2f(GLint un, GLfloat u1, GLfloat u2, GLint vn, GLfloat v1, GLfloat v2)
        subroutine glmapgrid2f(un, u1, u2, vn, v1, v2) bind(c, name='glMapGrid2f')
            import :: GLfloat, GLint
            integer(kind=GLint), intent(in), value :: un
            real(kind=GLfloat), intent(in), value :: u1
            real(kind=GLfloat), intent(in), value :: u2
            integer(kind=GLint), intent(in), value :: vn
            real(kind=GLfloat), intent(in), value :: v1
            real(kind=GLfloat), intent(in), value :: v2
        end subroutine glmapgrid2f

        ! void glEvalPoint1(GLint i)
        subroutine glevalpoint1(i) bind(c, name='glEvalPoint1')
            import :: GLint
            integer(kind=GLint), intent(in), value :: i
        end subroutine glevalpoint1

        ! void glEvalPoint2(GLint i, GLint j)
        subroutine glevalpoint2(i, j) bind(c, name='glEvalPoint2')
            import :: GLint
            integer(kind=GLint), intent(in), value :: i
            integer(kind=GLint), intent(in), value :: j
        end subroutine glevalpoint2

        ! void glEvalMesh1(GLenum mode, GLint i1, GLint i2)
        subroutine glevalmesh1(mode, i1, i2) bind(c, name='glEvalMesh1')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: mode
            integer(kind=GLint), intent(in), value :: i1
            integer(kind=GLint), intent(in), value :: i2
        end subroutine glevalmesh1

        ! void glEvalMesh2(GLenum mode, GLint i1, GLint i2, GLint j1, GLint j2)
        subroutine glevalmesh2(mode, i1, i2, j1, j2) bind(c, name='glEvalMesh2')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: mode
            integer(kind=GLint), intent(in), value :: i1
            integer(kind=GLint), intent(in), value :: i2
            integer(kind=GLint), intent(in), value :: j1
            integer(kind=GLint), intent(in), value :: j2
        end subroutine glevalmesh2

        ! void glFogf(GLenum pname, GLfloat param)
        subroutine glfogf(pname, param) bind(c, name='glFogf')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in), value :: param
        end subroutine glfogf

        ! void glFogi(GLenum pname, GLint param)
        subroutine glfogi(pname, param) bind(c, name='glFogi')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in), value :: param
        end subroutine glfogi

        ! void glFogfv(GLenum pname, const GLfloat *params)
        subroutine glfogfv(pname, params) bind(c, name='glFogfv')
            import :: GLenum, GLfloat
            integer(kind=GLenum), intent(in), value :: pname
            real(kind=GLfloat), intent(in) :: params
        end subroutine glfogfv

        ! void glFogiv(GLenum pname, const GLint *params)
        subroutine glfogiv(pname, params) bind(c, name='glFogiv')
            import :: GLenum, GLint
            integer(kind=GLenum), intent(in), value :: pname
            integer(kind=GLint), intent(in) :: params
        end subroutine glfogiv

        ! void glFeedbackBuffer(GLsizei size, GLenum type, GLfloat *buffer)
        subroutine glfeedbackbuffer(size, type, buffer) bind(c, name='glFeedbackBuffer')
            import :: GLenum, GLfloat, GLsizei
            integer(kind=GLsizei), intent(in), value :: size
            integer(kind=GLenum), intent(in), value :: type
            real(kind=GLfloat), intent(in) :: buffer
        end subroutine glfeedbackbuffer

        ! void glPassThrough(GLfloat token)
        subroutine glpassthrough(token) bind(c, name='glPassThrough')
            import :: GLfloat
            real(kind=GLfloat), intent(in), value :: token
        end subroutine glpassthrough

        ! void glSelectBuffer(GLsizei size, GLuint *buffer)
        subroutine glselectbuffer(size, buffer) bind(c, name='glSelectBuffer')
            import :: GLsizei, GLuint
            integer(kind=GLsizei), intent(in), value :: size
            integer(kind=GLuint), intent(in) :: buffer
        end subroutine glselectbuffer

        ! void glInitNames(void)
        subroutine glinitnames() bind(c, name='glInitNames')
        end subroutine glinitnames

        ! void glLoadName(GLuint name)
        subroutine glloadname(name) bind(c, name='glLoadName')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: name
        end subroutine glloadname

        ! void glPushName(GLuint name)
        subroutine glpushname(name) bind(c, name='glPushName')
            import :: GLuint
            integer(kind=GLuint), intent(in), value :: name
        end subroutine glpushname

        ! void glPopName(void)
        subroutine glpopname() bind(c, name='glPopName')
        end subroutine glpopname
     end interface
end module sdl2_opengl
