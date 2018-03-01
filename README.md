# f03sdl2
Interface to [Simple DirectMedia Layer 2](https://www.libsdl.org/) (SDL 2) for
Fortran 2003/2008, using `iso_c_binding`.

## Build
Use the Makefile to build the interface:
```
$ make sdl2
```
You can override the default compiler (GNU Fortran 8) by passing an argument,
for example:
```
$ make sdl2 FC=flang
```
Or just run your favourite Fortran compiler directly:
```
$ flang -c sdl2.f90
```

## Examples
Some demo applications are provided in directory `examples`.

* **window** just opens an SDL 2 window.
* **image** loads and displays an image.
* **events** polls SDL events.

Build the examples with:
```
$ make <name>
```

## Licence
ISC
