# f03sdl2
Interface to [Simple DirectMedia Layer 2](https://www.libsdl.org/) (SDL 2) for
Fortran 2003/2008, using `iso_c_binding`.

## Build SDL2
Use BSD make to build the SDL2 interface:
```
$ make sdl2
```
You can override the default compiler (GNU Fortran 8) by passing the `FC`
argument, for example:
```
$ make sdl2 FC=flang
```
Or just run your favourite Fortran compiler directly:
```
$ flang -c sdl2.f90
```

## Build SDL2_image
Build the SDL2_image interface with:
```
$ make sdl2_image
```
Linking against SDL2_image requires you to add `-lSDL2_image` to your `LD_FLAGS`.

## Examples
Some demo applications are provided in directory `examples`.

* **window** just opens an SDL window.
* **image** loads and displays an image (software renderer).
* **events** polls SDL events.
* **scaling** displays a scaled image (software renderer).
* **translucence** makes one color of an image translucent (software renderer).
* **bounce** loads a PNG file with SDL_image and lets it bounce on the screen (hardware renderer).

Build the examples with:
```
$ make <name>
```

## Licence
ISC
