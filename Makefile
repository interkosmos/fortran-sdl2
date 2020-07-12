.POSIX:
.SUFFIXES:

FC         = gfortran
SDL_CFLAGS = `sdl2-config --cflags`
SDL_LDLIBS = `sdl2-config --libs`
FFLAGS     = -Wall -std=f2008 -fmax-errors=1 $(SDL_CFLAGS)
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
          src/sdl2/sdl2_opengl.f90 \
          src/sdl2.f90
IMG_SRC = src/sdl2_image.f90
MIX_SRC = src/c_util.f90 \
          src/sdl2_mixer.f90
TTF_SRC = src/sdl2_ttf.f90
GLU_SRC = src/glu.f90

SDL_LIB = sdl2.a
IMG_LIB = sdl2_image.a
MIX_LIB = sdl2_mixer.a
TTF_LIB = sdl2_ttf.a
GLU_LIB = glu.a
LIBRARY = fortran-sdl2.a

ALPHA   = examples/alpha/alpha
CYCLIC  = examples/cyclic/cyclic
DRAW    = examples/draw/draw
DVD     = examples/dvd/dvd
EVENTS  = examples/events/events
FIRE    = examples/fire/fire
FOREST  = examples/forest/forest
IMAGE   = examples/image/image
INFO    = examples/info/info
MSGBOX  = examples/msgbox/msgbox
GL      = examples/gl/gl
GL3D    = examples/gl3d/gl3d
OPERA   = examples/opera/opera
PIXEL   = examples/pixel/pixel
SCALING = examples/scaling/scaling
TEXT    = examples/text/text
VOXEL   = examples/voxel/voxel
WINDOW  = examples/window/window

.PHONY: all clean examples \
        sdl2 sdl2_image sdl2_mixer sdl2_ttf \
        glu \
        alpha cyclic draw dvd events fire forest gl gl3d image info msgbox \
        opera pixel scaling text voxel window

all: $(LIBRARY) $(GLU_LIB)

examples: $(ALPHA) $(CYCLIC) $(DRAW) $(DVD) $(EVENTS) $(FIRE) $(FOREST) $(GL) $(GL3D) \
          $(INFO) $(IMAGE) $(MSGBOX) $(OPERA) $(PIXEL) $(SCALING) $(TEXT) $(VOXEL) \
          $(WINDOW)

# Build targets of examples.
alpha: $(ALPHA)
cyclic: $(CYCLIC)
draw: $(DRAW)
dvd: $(DVD)
events: $(EVENTS)
fire: $(FIRE)
forest: $(FOREST)
gl: $(GL)
gl3d: $(GL3D)
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
sdl2: $(SDL_LIB)
sdl2_image: $(IMG_LIB)
sdl2_mixer: $(MIX_LIB)
sdl2_ttf: $(TTF_LIB)

# Build targets for additional OpenGL interfaces.
glu: $(GLU_LIB)

# SDL 2.0 interfaces.
$(SDL_LIB):
	$(FC) $(FFLAGS) -fPIC -c $(SDL_SRC)
	ar rcs $(SDL_LIB) sdl2.o

$(IMG_LIB):
	$(FC) $(FFLAGS) -fPIC -c $(IMG_SRC)
	ar rcs $(IMG_LIB) sdl2_image.o

$(MIX_LIB):
	$(FC) $(FFLAGS) -fPIC -c $(MIX_SRC)
	ar rcs $(MIX_LIB) sdl2_mixer.o

$(TTF_LIB):
	$(FC) $(FFLAGS) -fPIC -c $(TTF_SRC)
	ar rcs $(TTF_LIB) sdl2_ttf.o

$(LIBRARY): $(SDL_LIB) $(IMG_LIB) $(MIX_LIB) $(TTF_LIB)
	ar rcs $(LIBRARY) sdl2.o sdl2_image.o sdl2_mixer.o sdl2_ttf.o

# OpenGL.
$(GLU_LIB):
	$(FC) $(FFLAGS) -fPIC -c $(GLU_SRC)
	ar rcs $(GLU_LIB) glu.o

# Examples.
$(ALPHA): $(ALPHA).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(CYCLIC): $(CYCLIC).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(DRAW): $(DRAW).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(DVD): $(DVD).f90 $(SDL_LIB) $(IMG_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_image

$(EVENTS): $(EVENTS).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(FIRE): $(FIRE).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(FOREST): $(FOREST).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(GL): $(GL).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lGL

$(GL3D): $(GL3D).f90 $(SDL_LIB) $(GLU_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lGL

$(IMAGE): $(IMAGE).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(INFO): $(INFO).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(OPERA): $(OPERA).f90 $(SDL_LIB) $(MIX_LIB) $(TTF_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_mixer -lSDL2_ttf

$(PIXEL): $(PIXEL).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(MSGBOX): $(MSGBOX).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(SCALING): $(SCALING).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(TEXT): $(TEXT).f90 $(SDL_LIB) $(TTF_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_ttf

$(VOXEL): $(VOXEL).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

$(WINDOW): $(WINDOW).f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

# Delete *.mod, *.a, *.o, and all compiled examples.
clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ `ls -1 *.a 2>/dev/null | wc -l` -gt 0 ]; then rm *.a; fi
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e $(ALPHA) ]; then rm $(ALPHA); fi
	if [ -e $(CYCLIC) ]; then rm $(CYCLIC); fi
	if [ -e $(DRAW) ]; then rm $(DRAW); fi
	if [ -e $(DVD) ]; then rm $(DVD); fi
	if [ -e $(EVENTS) ]; then rm $(EVENTS); fi
	if [ -e $(FIRE) ]; then rm $(FIRE); fi
	if [ -e $(FOREST) ]; then rm $(FOREST); fi
	if [ -e $(GL) ]; then rm $(GL); fi
	if [ -e $(GL3D) ]; then rm $(GL3D); fi
	if [ -e $(IMAGE) ]; then rm $(IMAGE); fi
	if [ -e $(INFO) ]; then rm $(INFO); fi
	if [ -e $(MSGBOX) ]; then rm $(MSGBOX); fi
	if [ -e $(OPERA) ]; then rm $(OPERA); fi
	if [ -e $(PIXEL) ]; then rm $(PIXEL); fi
	if [ -e $(SCALING) ]; then rm $(SCALING); fi
	if [ -e $(TEXT) ]; then rm $(TEXT); fi
	if [ -e $(VOXEL) ]; then rm $(VOXEL); fi
	if [ -e $(WINDOW) ]; then rm $(WINDOW); fi
