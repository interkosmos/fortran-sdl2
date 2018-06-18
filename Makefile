FC           = gfortran8
SDL_CFLAGS   = `sdl2-config --cflags`
SDL_LDFLAGS  = `sdl2-config --libs`
CFLAGS       = -fcheck=all -Ofast -march=native -Wl,-rpath=/usr/local/lib/gcc8/ $(SDL_CFLAGS)
LDFLAGS      = $(SDL_LDFLAGS)

SDL_SRC      = sdl2.f90
SDL_OBJ      = sdl2.o
IMG_SRC      = sdl2_image.f90
IMG_OBJ      = sdl2_image.o

DIR          = examples

WINDOW       = window
IMAGE        = image
EVENTS       = events
SCALING      = scaling
TRANSLUCENCE = translucence
RENDER       = render

all: $(SDL_OBJ) $(IMG_OBJ)

sdl2: $(SDL_OBJ)

sdl2_image: $(IMG_OBJ)

$(SDL_OBJ):
	$(FC) -c $(SDL_SRC)

$(IMG_OBJ):
	$(FC) -c $(IMG_SRC)

$(WINDOW): $(DIR)/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(IMAGE): $(DIR)/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(EVENTS): $(DIR)/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(SCALING): $(DIR)/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(TRANSLUCENCE): $(DIR)/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(RENDER): $(DIR)/$*.f90 $(SDL_OBJ) $(IMG_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS) -lSDL2_image

.PHONY: clean

clean:
	rm *.mod $(SDL_OBJ) $(IMG_OBJ) $(WINDOW) $(IMAGE) $(EVENTS) $(SCALING) $(TRANSLUCENCE) $(RENDER)
