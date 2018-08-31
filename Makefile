FC           = gfortran8
SDL_CFLAGS   = `sdl2-config --cflags`
SDL_LDFLAGS  = `sdl2-config --libs`
CFLAGS       = -Wl,-rpath=/usr/local/lib/gcc8/ $(SDL_CFLAGS)
LDFLAGS      = $(SDL_LDFLAGS)

SDL_SRC      = sdl2.f90
SDL_OBJ      = sdl2.o

IMG_SRC      = sdl2_image.f90
IMG_OBJ      = sdl2_image.o

MIX_SRC      = sdl2_mixer.f90
MIX_OBJ      = sdl2_mixer.o

TTF_SRC      = sdl2_ttf.f90
TTF_OBJ      = sdl2_ttf.o

DIR          = examples

WINDOW       = window
IMAGE        = image
EVENTS       = events
SCALING      = scaling
TRANSLUCENCE = translucence
BOUNCE       = bounce
MUSIC        = music
TEXT         = text

all: $(SDL_OBJ) $(IMG_OBJ) $(MIX_OBJ) $(TTF_OBJ)

sdl2: $(SDL_OBJ)

sdl2_image: $(IMG_OBJ)

sdl2_mixer: $(MIX_OBJ)

sdl2_ttf: $(TTF_OBJ)

$(SDL_OBJ):
	$(FC) -c $(SDL_SRC)

$(IMG_OBJ):
	$(FC) -c $(IMG_SRC)

$(MIX_OBJ):
	$(FC) -c $(MIX_SRC)

$(TTF_OBJ):
	$(FC) -c $(TTF_SRC)

$(WINDOW): $(DIR)/$*/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(IMAGE): $(DIR)/$*/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(EVENTS): $(DIR)/$*/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(SCALING): $(DIR)/$*/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(TRANSLUCENCE): $(DIR)/$*/$*.f90 $(SDL_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS)

$(BOUNCE): $(DIR)/$*/$*.f90 $(SDL_OBJ) $(IMG_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS) -lSDL2_image

$(MUSIC): $(DIR)/$*/$*.f90 $(SDL_OBJ) $(MIX_OBJ) $(TTF_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS) -lSDL2_mixer -lSDL2_ttf

$(TEXT): $(DIR)/$*/$*.f90 $(SDL_OBJ) $(TTF_OBJ)
	$(FC) $(CFLAGS) -o $@ $? $(LDFLAGS) -lSDL2_ttf

.PHONY: clean

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
