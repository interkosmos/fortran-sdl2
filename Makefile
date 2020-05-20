.POSIX:
.SUFFIXES:

FC         = gfortran
SDL_CFLAGS = `sdl2-config --cflags`
SDL_LDLIBS = `sdl2-config --libs`
FFLAGS     = -O2 -Wall -std=f2008 -fmax-errors=1 $(SDL_CFLAGS)
LDLIBS     = $(SDL_LDLIBS)

SDL_SRC = src/c_util.f90 \
          src/sdl2/sdl2_stdinc.f90 \
          src/sdl2/sdl2_audio.f90 \
          src/sdl2/sdl2_blendmode.f90 \
          src/sdl2/sdl2_cpuinfo.f90 \
          src/sdl2/sdl2_error.f90 \
          src/sdl2/sdl2_events.f90 \
          src/sdl2/sdl2_filesystem.f90 \
          src/sdl2/sdl2_hints.f90 \
          src/sdl2/sdl2_keyboard.f90 \
          src/sdl2/sdl2_log.f90 \
          src/sdl2/sdl2_messagebox.f90 \
          src/sdl2/sdl2_rect.f90 \
          src/sdl2/sdl2_pixels.f90 \
          src/sdl2/sdl2_platform.f90 \
          src/sdl2/sdl2_scancode.f90 \
          src/sdl2/sdl2_surface.f90 \
          src/sdl2/sdl2_render.f90 \
          src/sdl2/sdl2_keycode.f90 \
          src/sdl2/sdl2_mouse.f90 \
          src/sdl2/sdl2_rwops.f90 \
          src/sdl2/sdl2_thread.f90 \
          src/sdl2/sdl2_timer.f90 \
          src/sdl2/sdl2_version.f90 \
          src/sdl2/sdl2_video.f90 \
          src/sdl2.f90
SDL_OBJ = sdl2.o
IMG_SRC = src/sdl2_image.f90
IMG_OBJ = sdl2_image.o
MIX_SRC = src/c_util.f90 src/sdl2_mixer.f90
MIX_OBJ = sdl2_mixer.o
TTF_SRC = src/sdl2_ttf.f90
TTF_OBJ = sdl2_ttf.o

ALPHA   = examples/alpha/alpha
CIRCLE  = examples/cyclic/cyclic
DRAW    = examples/draw/draw
DVD     = examples/dvd/dvd
EVENTS  = examples/events/events
FIRE    = examples/fire/fire
FOREST  = examples/forest/forest
IMAGE   = examples/image/image
INFO    = examples/info/info
MSGBOX  = examples/msgbox/msgbox
OPERA   = examples/opera/opera
PIXEL   = examples/pixel/pixel
SCALING = examples/scaling/scaling
TEXT    = examples/text/text
VOXEL   = examples/voxel/voxel
WINDOW  = examples/window/window

.PHONY: all clean examples \
        sdl2 sdl2_image sdl2_mixer sdl2_ttf \
        alpha cyclic draw dvd events fire forest image info msgbox opera pixel \
        scaling text voxel window

all: $(SDL_OBJ) $(IMG_OBJ) $(MIX_OBJ) $(TTF_OBJ)

examples: $(ALPHA) $(CIRCLE) $(DRAW) $(DVD) $(EVENTS) $(FIRE) $(FOREST) $(INFO) $(IMAGE) \
          $(MSGBOX) $(OPERA) $(PIXEL) $(SCALING) $(TEXT) $(VOXEL) $(WINDOW)

# Build targets of examples.
alpha: $(ALPHA)
cyclic: $(CIRCLE)
draw: $(DRAW)
dvd: $(DVD)
events: $(EVENTS)
fire: $(FIRE)
forest: $(FOREST)
image: $(IMAGE)
info: $(INFO)
msgbox: $(MSGBOX)
opera: $(OPERA)
pixel: $(PIXEL)
scaling: $(SCALING)
text: $(TEXT)
voxel: $(VOXEL)
window: $(WINDOW)

# Build targets of SDL 2.0 interfaces.
sdl2: $(SDL_OBJ)
sdl2_image: $(IMG_OBJ)
sdl2_mixer: $(MIX_OBJ)
sdl2_ttf: $(TTF_OBJ)

# SDL 2.0 interfaces.
$(SDL_OBJ):
	$(FC) $(FFLAGS) -c $(SDL_SRC)

$(IMG_OBJ):
	$(FC) $(FFLAGS) -c $(IMG_SRC)

$(MIX_OBJ):
	$(FC) $(FFLAGS) -c $(MIX_SRC)

$(TTF_OBJ):
	$(FC) $(FFLAGS) -c $(TTF_SRC)

# Examples.
$(ALPHA): $(ALPHA).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(CIRCLE): $(CIRCLE).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(DRAW): $(DRAW).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(DVD): $(DVD).f90 $(SDL_OBJ) $(IMG_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_image

$(EVENTS): $(EVENTS).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(FIRE): $(FIRE).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(FOREST): $(FOREST).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(IMAGE): $(IMAGE).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(INFO): $(INFO).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(OPERA): $(OPERA).f90 $(SDL_OBJ) $(MIX_OBJ) $(TTF_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_mixer -lSDL2_ttf

$(PIXEL): $(PIXEL).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(MSGBOX): $(MSGBOX).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(SCALING): $(SCALING).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(TEXT): $(TEXT).f90 $(SDL_OBJ) $(TTF_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_ttf

$(VOXEL): $(VOXEL).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(WINDOW): $(WINDOW).f90 $(SDL_OBJ)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

# Delete *.mod, *.o, and all compiled examples.
clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e $(ALPHA) ]; then rm $(ALPHA); fi
	if [ -e $(CIRCLE) ]; then rm $(CIRCLE); fi
	if [ -e $(DRAW) ]; then rm $(DRAW); fi
	if [ -e $(DVD) ]; then rm $(DVD); fi
	if [ -e $(EVENTS) ]; then rm $(EVENTS); fi
	if [ -e $(FIRE) ]; then rm $(FIRE); fi
	if [ -e $(FOREST) ]; then rm $(FOREST); fi
	if [ -e $(IMAGE) ]; then rm $(IMAGE); fi
	if [ -e $(INFO) ]; then rm $(INFO); fi
	if [ -e $(MSGBOX) ]; then rm $(MSGBOX); fi
	if [ -e $(OPERA) ]; then rm $(OPERA); fi
	if [ -e $(PIXEL) ]; then rm $(PIXEL); fi
	if [ -e $(SCALING) ]; then rm $(SCALING); fi
	if [ -e $(TEXT) ]; then rm $(TEXT); fi
	if [ -e $(VOXEL) ]; then rm $(VOXEL); fi
	if [ -e $(WINDOW) ]; then rm $(WINDOW); fi
