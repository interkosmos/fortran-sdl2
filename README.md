# f03sdl2
Interface to [Simple DirectMedia Layer 2](https://www.libsdl.org/) (SDL 2) for
Fortran 2003/2008, using `iso_c_binding`.

## Build
Use the Makefile to build the interface:
```
$ make sdl2
```
Or run your favourite Fortran compiler directly:
```
$ gfortran8 -c sdl2.f90
```

## Examples
Some demo applications are provided in directory `examples`.

* **window** just opens an SDL 2 window.
* **image** loads and displays an image.

Build the examples with:
```
$ make <name>
```

## Licence
ISC
