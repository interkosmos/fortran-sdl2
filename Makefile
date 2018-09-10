FC           = gfortran8
SDL_CFLAGS   = `sdl2-config --cflags`
SDL_LDFLAGS  = `sdl2-config --libs`
CFLAGS       = -Wall -Wl,-rpath=/usr/local/lib/gcc8/ -std=f2008 $(SDL_CFLAGS)
LDFLAGS      = $(SDL_LDFLAGS)
EXAMPLES     = examples

SDL_SRC      = sdl2.f90
SDL_OBJ      = sdl2.o
IMG_SRC      = sdl2_image.f90
IMG_OBJ      = sdl2_image.o
MIX_SRC      = sdl2_mixer.f90
MIX_OBJ      = sdl2_mixer.o
TTF_SRC      = sdl2_ttf.f90
TTF_OBJ      = sdl2_ttf.o

WINDOW       = window
IMAGE        = image
EVENTS       = events
SCALING      = scaling
TRANSLUCENCE = translucence
BOUNCE       = bounce
MUSIC        = music
TEXT         = text
DRAW         = draw

.PHONY: all clean

all: $(SDL_OBJ) $(IMG_OBJ) $(MIX_OBJ) $(TTF_OBJ)

sdl2: $(SDL_OBJ)

sdl2_image: $(IMG_OBJ)

sdl2_mixer: $(MIX_OBJ)

sdl2_ttf: $(TTF_OBJ)

$(SDL_OBJ):
	$(FC) -Wall -c $(SDL_SRC)

$(IMG_OBJ):
	$(FC) -Wall -c $(IMG_SRC)

$(MIX_OBJ):
	$(FC) -Wall -c $(MIX_SRC)

$(TTF_OBJ):
	$(FC) -Wall -c $(TTF_SRC)

$(WINDOW): $(EXAMPLES)/$(WINDOW)/$(WINDOW).f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(IMAGE): $(EXAMPLES)/$(IMAGE)/$(IMAGE).f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(EVENTS): $(EXAMPLES)/$(EVENTS)/$(EVENTS).f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(SCALING): $(EXAMPLES)/$(SCALING)/$(SCALING).f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(TRANSLUCENCE): $(EXAMPLES)/$(TRANSLUCENCE)/$(TRANSLUCENCE).f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(BOUNCE): $(EXAMPLES)/$(BOUNCE)/$(BOUNCE).f90 $(SDL_OBJ) $(IMG_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS) -lSDL2_image

$(MUSIC): $(EXAMPLES)/$(MUSIC)/$(MUSIC).f90 $(SDL_OBJ) $(MIX_OBJ) $(TTF_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS) -lSDL2_mixer -lSDL2_ttf

$(TEXT): $(EXAMPLES)/$(TEXT)/$(TEXT).f90 $(SDL_OBJ) $(TTF_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS) -lSDL2_ttf

$(DRAW): $(EXAMPLES)/$(DRAW)/$(DRAW).f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ -e $(SDL_OBJ) ]; then rm $(SDL_OBJ); fi
	if [ -e $(IMG_OBJ) ]; then rm $(IMG_OBJ); fi
	if [ -e $(MIX_OBJ) ]; then rm $(MIX_OBJ); fi
	if [ -e $(TTF_OBJ) ]; then rm $(TTF_OBJ); fi
	if [ -e $(WINDOW) ]; then rm $(WINDOW); fi
	if [ -e $(IMAGE) ]; then rm $(IMAGE); fi
	if [ -e $(EVENTS) ]; then rm $(EVENTS); fi
	if [ -e $(SCALING) ]; then rm $(SCALING); fi
	if [ -e $(TRANSLUCENCE) ]; then rm $(TRANSLUCENCE); fi
	if [ -e $(BOUNCE) ]; then rm $(BOUNCE); fi
	if [ -e $(MUSIC) ]; then rm $(MUSIC); fi
	if [ -e $(TEXT) ]; then rm $(TEXT); fi
	if [ -e $(DRAW) ]; then rm $(DRAW); fi
