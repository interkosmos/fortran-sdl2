# fortran-sdl2
A collection of ISO C binding interfaces to
[Simple DirectMedia Layer 2.0](https://www.libsdl.org/) (SDL 2.0), for
2D and 3D game programming in Fortran. SDL versions tested against:

Library   | Version
----------|--------
SDL       | 2.0.12_3
SDL_image | 2.0.5
SDL_mixer | 2.0.4_2
SDL_ttf   | 2.0.15

The interface bindings have been built successfully with GNU Fortran 10 on
FreeBSD 12 and IFORT 19.1 on CentOS 8, but other Fortran 2008 compilers should
work as well. On Microsoft Windows, you may want to install GNU Fortran through
[MSYS2](https://www.msys2.org/).

## Build Instructions
If not present already, install SDL 2.0 with development headers (and
optionally: [SDL_image 2.0](https://www.libsdl.org/projects/SDL_image/),
[SDL_mixer 2.0](https://www.libsdl.org/projects/SDL_mixer/), and/or
[SDL_ttf 2.0](https://www.libsdl.org/projects/SDL_ttf/)). On FreeBSD, run:

```
# pkg install devel/sdl20 graphics/sdl2_image audio/sdl2_mixer graphics/sdl2_ttf
```

Either use GNU/BSD make or [xmake](https://xmake.io/) to build *fortran-sdl2*.

### Make
Run `make sdl2` to compile the static library `libsdl2.a`:

```
$ git clone https://github.com/interkosmos/fortran-sdl2
$ cd fortran-sdl2/
$ make sdl2
```

On Microsoft Windows, you have to set `LIBGL` and `LIBGLU`:

```
$ make all LIBGL=-lopengl32 LIBGLU=-lglu32
```

You can override the default compiler (`gfortran`) by passing the `FC`
argument, for example:

```
$ make all FC=/opt/intel/bin/ifort
```

Link your Fortran project with `libsdl2.a` and (optionally) `libsdl2_*.a`, or
simply with `libfortran-sdl2.a`:

| Library           | Compilation         | Linking                                                         |
|-------------------|---------------------|-----------------------------------------------------------------|
| SDL2              | `make sdl2`         | `libsdl2.a -lSDL2`                                              |
| SDL2_image        | `make sdl2_image`   | `libsdl2.a libsdl2_image.a -lSDL2 -lSDL2_image`                 |
| SDL2_mixer        | `make sdl2_mixer`   | `libsdl2.a libsdl2_mixer.a -lSDL2 -lSDL2_mixer`                 |
| SDL2_ttf          | `make sdl2_ttf`     | `libsdl2.a libsdl2_ttf.a -lSDL2 -lSDL2_ttf`                     |
| *all*             | `make all`          | `libfortran-sdl2.a -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf` |

### xmake
Build all static libraries with:

```
$ xmake
```

Build a particular library with:

```
$ xmake build <name>
```

The default output directory is `build/`.

## Example
The following example shows how to fill a rectangle, using the hardware renderer.

```fortran
! example.f90
program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_null_char, c_ptr
    use, intrinsic :: iso_fortran_env, only: stdout => output_unit, stderr => error_unit
    use :: sdl2
    implicit none

    integer, parameter :: SCREEN_WIDTH  = 640
    integer, parameter :: SCREEN_HEIGHT = 480

    type(c_ptr)     :: window
    type(c_ptr)     :: renderer
    type(sdl_event) :: event
    type(sdl_rect)  :: rect
    integer         :: rc
    logical         :: is_running = .true.

    ! Initialise SDL.
    if (sdl_init(SDL_INIT_VIDEO) < 0) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the SDL window.
    window = sdl_create_window('Fortran SDL 2.0' // c_null_char, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SDL_WINDOWPOS_UNDEFINED, &
                               SCREEN_WIDTH, &
                               SCREEN_HEIGHT, &
                               SDL_WINDOW_SHOWN)

    if (.not. c_associated(window)) then
        write (stderr, *) 'SDL Error: ', sdl_get_error()
        stop
    end if

    ! Create the renderer.
    renderer = sdl_create_renderer(window, -1, 0)

    ! Set position and size of the rectangle.
    rect = sdl_rect(50, 50, 250, 250)

    ! Event loop.
    do while (is_running)
        ! Catch events.
        do while (sdl_poll_event(event) > 0)
            select case (event%type)
                case (SDL_QUITEVENT)
                    is_running = .false.
            end select
        end do

        ! Fill screen black.
        rc = sdl_set_render_draw_color(renderer, &
                                       uint8(0), &
                                       uint8(0), &
                                       uint8(0), &
                                       uint8(SDL_ALPHA_OPAQUE))
        rc = sdl_render_clear(renderer)

        ! Fill the rectangle.
        rc = sdl_set_render_draw_color(renderer, &
                                       uint8(127), &
                                       uint8(255), &
                                       uint8(0), &
                                       uint8(SDL_ALPHA_OPAQUE))
        rc = sdl_render_fill_rect(renderer, rect)

        ! Render to screen and wait 20 ms.
        call sdl_render_present(renderer)
        call sdl_delay(20)
    end do

    ! Quit gracefully.
    call sdl_destroy_renderer(renderer)
    call sdl_destroy_window(window)
    call sdl_quit()
end program main
```

Compile the source code with GNU Fortran:

```
$ gfortran `sdl2-config --cflags` -o example example.f90 libsdl2.a `sdl2-config --libs`
```

## Further Examples
Some demo applications can be found in `examples/`:

* [**alpha**](examples/alpha/screenshot.png) makes one color of an image transparent (software renderer).
* [**cyclic**](examples/cyclic/screenshot.png) implements a 2D [cyclic cellular automaton](https://en.wikipedia.org/wiki/Cyclic_cellular_automaton) (hardware renderer).
* [**draw**](examples/draw/screenshot.png) draws some shapes (hardware renderer).
* [**dvd**](examples/dvd/screenshot.png) loads a PNG file with SDL_image and lets it bounce on the screen (hardware renderer).
* **events** polls SDL events (software renderer).
* [**fire**](examples/fire/screenshot.png) renders the [DOOM fire effect](http://fabiensanglard.net/doom_fire_psx/) (hardware renderer).
* [**forest**](examples/forest/screenshot.png) implements a cellular automaton, based on the [forest fire model](https://rosettacode.org/wiki/Forest_fire) (hardware renderer).
* [**gl**](examples/gl/screenshot.png) renders a triangle with OpenGL 1.3.
* [**gl3d**](examples/gl3d/screenshot.png) rotates textured cubes with OpenGL 1.3.
* [**glsphere**](examples/glsphere/screenshot.png) rotates the camera around GLU spheres.
* [**image**](examples/image/screenshot.png) loads and displays an image (software renderer).
* **info** prints debug information to console (software renderer).
* **log** prints log messages with `SDL_Log()` (software renderer).
* [**logo**](examples/logo/screenshot.png) lets you fly through a field of Fortran logos (hardware renderer).
* **msgbox** shows a simple message box (software renderer).
* [**opera**](examples/opera/screenshot.png) plays an OGG file with SDL_mixer (software renderer).
* [**pixel**](examples/pixel/screenshot.png) copies an SDL_Surface to an SDL_Texture pixelwise (hardware renderer).
* [**scaling**](examples/scaling/screenshot.png) displays a scaled image (software renderer).
* [**text**](examples/text/screenshot.png) outputs text with SDL_ttf (hardware renderer).
* [**voxel**](examples/voxel/screenshot.png) renders a [voxel space](https://github.com/s-macke/VoxelSpace) with direct pixel manipulation. Use arrow keys and Q, A for camera movement (hardware renderer).
* **window** opens a window and fills rectangles (software renderer).

Compile all examples with:

```
$ make examples
```

Or, use the name of a particular example. Run the examples from within their
respective directory:

```
$ cd examples/<name>/
$ ./<name>
```

If you prefer xmake, build and run an example with:

```
$ xmake build <name>
$ xmake run <name>
```

To compile all examples, simply run:

```
$ xmake build examples
```

## Compatibility
All Fortran interface names are written in snake case. For instance,
`SDL_CreateWindow()` can be accessed by calling Fortran interface
`sdl_create_window()`. The same is valid for derived types and their
components. Enums and constants have kept their original names.

### Null-Termination of Strings
A `c_null_char` must be appended to all strings passed to the interfaces,
except `sdl_set_hint()` and `sdl_log*()`, which are wrappers that terminate the
arguments for convenience.

### SDL_Color
SDL 2.0 stores RGB colour values as `Uint8`. As Fortran does not feature unsigned
types, the intrinsic procedure `transfer()` has to be used to transfer bit
patterns directly. For example:

```fortran
type(sdl_color) :: color

color = sdl_color(r = transfer([255, 1], 1_c_int8_t)
                  g = transfer([127, 1], 1_c_int8_t)
                  b = transfer([  0, 1], 1_c_int8_t)
                  a = transfer([SDL_ALPHA_OPAQUE, 1], 1_c_int8_t))
```

The Fortran bindings provide a utility function `uint8()` that simplifies the
conversion:

```fortran
color = sdl_color(r = uint8(255), &
                  g = uint8(127), &
                  b = uint8(0), &
                  a = uint8(SDL_ALPHA_OPAQUE))
```

### SDL_Surface
C pointers in derived types like `sdl_surface` must be converted to Fortran
types manually by calling the intrinsic procedure `c_f_pointer()`. For instance,
to assign the `sdl_pixel_format` pointer in `sdl_surface`:

```fortran
type(sdl_pixel_format), pointer :: pixel_format
type(sdl_surface),      pointer :: surface

! Convert C pointer to Fortran pointer.
call c_f_pointer(surface%format, pixel_format)
```

The C struct `SDL_Surface` stores RGB pixel values as `Uint8`. Use `transfer()`
and `ichar()` to convert `Uint8` to Fortran signed integer. For example:

```fortran
integer, parameter              :: X = 10
integer, parameter              :: Y = 20
integer(kind=2)                 :: r, g, b
integer(kind=c_int32_t)         :: pixel
integer(kind=c_int8_t), pointer :: pixels(:)
type(sdl_pixel_format), pointer :: pixel_format
type(sdl_surface),      pointer :: surface

! Load BMP file into SDL_Surface.
surface => sdl_load_bmp('image.bmp' // c_null_char)

! Get SDL_PixelFormat.
call c_f_pointer(surface%format, pixel_format)

! Get Fortran array of pixel pointers.
call c_f_pointer(surface%pixels, pixels, shape=[surface%pitch * surface%h])

! Get single pixel of coordinates X and Y. Convert to Fortran integer.
pixel = ichar(transfer(pixels((Y - 1) * surface%pitch + X), 'a'), kind=c_int32_t)

! Get RGB values of pixel.
call sdl_get_rgb(pixel, pixel_format, r, g, b)
```

### SDL_Log
Only a single string message can be passed to `sdl_log()` and `sdl_log_*()`
routines, as Fortran does not support ellipsis arguments. For example:

```fortran
call sdl_log_debug(SDL_LOG_CATEGORY_TEST, 'debug message')
```

You may have to write your log message to a string first:

```fortran
character(len=32) :: msg
integer           :: rc

write (msg, '(a, i0)') 'Error: ', rc
call sdl_log(msg)
```

Log messages will be trimmed and null-terminated by the wrapper routines.

### Events
The SDL event [SDL_QUIT](https://wiki.libsdl.org/SDL_EventType#SDL_QUIT) has
been renamed to `SDL_QUITEVENT` in Fortran to avoid conflict with interface
`sdl_quit()`.

## Documentation
Generate the source code documentation with
[FORD](https://github.com/cmacmackin/ford). Add FORD with `pip`, for example:

```
$ python3 -m venv virtual-environment/
$ source virtual-environment/bin/activate
$ python3 -m pip install ford
```

Or, instead, just install the package in your user directory:

```
$ python3 -m pip install --user ford
```

Then, run:

```
$ ford project.md -d ./src
```

Open `doc/index.html` in a web browser.

## Coverage
See [coverage](coverage.md) for the current status.

## Credits
Thanks go to [angelog0](https://github.com/angelog0).

## Licence
ISC
