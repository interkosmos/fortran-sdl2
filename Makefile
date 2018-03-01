FC          = gfortran8

SDL_CFLAGS  = `sdl2-config --cflags`
SDL_LDFLAGS = `sdl2-config --libs`

CFLAGS      = -fcheck=all -Ofast -march=native -Wl,-rpath=/usr/local/lib/gcc8/ $(SDL_CFLAGS)
LDFLAGS     = $(SDL_LDFLAGS)

SRC         = sdl2.f90
OBJ         = sdl2.o

DIR         = examples

WINDOW      = window
IMAGE       = image
EVENTS      = events

all: $(OBJ)

sdl2: $(OBJ)

$(OBJ):
	$(FC) -c $(SRC)

$(WINDOW): $(DIR)/$*.f90 $(OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(IMAGE): $(DIR)/$*.f90 $(OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(EVENTS): $(DIR)/$*.f90 $(OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

.PHONY: clean

clean:
	rm *.mod $(OBJ) $(WINDOW) $(IMAGE) $(EVENTS)
