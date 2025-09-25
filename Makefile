.POSIX:
.SUFFIXES:

FC     = gfortran
FFLAGS = `sdl2-config --cflags`
LDLIBS = `sdl2-config --libs`
LIBGL  = -lGL
LIBGLU = -lGLU

SDL_SRC = src/sdl2/sdl2_c_types.F90 \
          src/sdl2/sdl2_stdinc.f90 \
          src/sdl2/sdl2_audio.f90 \
          src/sdl2/sdl2_blendmode.f90 \
          src/sdl2/sdl2_cpuinfo.f90 \
          src/sdl2/sdl2_gamecontroller.f90 \
          src/sdl2/sdl2_error.f90 \
          src/sdl2/sdl2_events.f90 \
          src/sdl2/sdl2_filesystem.f90 \
          src/sdl2/sdl2_hints.f90 \
          src/sdl2/sdl2_joystick.f90 \
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
MIX_SRC = src/sdl2/sdl2_c_types.F90 \
          src/sdl2_mixer.f90
TTF_SRC = src/sdl2_ttf.f90
GLU_SRC = src/glu.f90

SDL_LIB = libsdl2.a
IMG_LIB = libsdl2_image.a
MIX_LIB = libsdl2_mixer.a
TTF_LIB = libsdl2_ttf.a
GLU_LIB = libglu.a
LIBRARY = libfortran-sdl2.a

.PHONY: all clean doc examples sdl2 sdl2_image sdl2_mixer sdl2_ttf glu

all: $(LIBRARY) $(GLU_LIB)

examples: alpha cyclic draw dvd events fire forest gl gl3d glsphere info \
          log logo image msgbox opera pixel scaling text vertex voxel window

# Build targets of SDL 2.0 interfaces.
sdl2: $(SDL_LIB)
sdl2_image: $(IMG_LIB)
sdl2_mixer: $(MIX_LIB)
sdl2_ttf: $(TTF_LIB)

# Build targets for additional OpenGL interfaces.
glu: $(GLU_LIB)

# OpenGL.
$(GLU_LIB):
	$(FC) $(FFLAGS) -fPIC -c $(GLU_SRC)
	ar rcs $(GLU_LIB) glu.o

# SDL 2.0.
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

$(LIBRARY): $(SDL_LIB) $(IMG_LIB) $(MIX_LIB) $(TTF_LIB) $(GLU_LIB)
	ar rcs $(LIBRARY) sdl2.o sdl2_image.o sdl2_mixer.o sdl2_ttf.o glu.o

# Examples.
alpha: examples/alpha.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

cyclic: examples/cyclic.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

draw: examples/draw.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

dvd: examples/dvd.f90 $(SDL_LIB) $(IMG_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_image

events: examples/events.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

fire: examples/fire.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

forest: examples/forest.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

gl: examples/gl.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) $(LIBGL)

gl3d: examples/gl3d.f90 $(SDL_LIB) $(IMG_LIB) $(GLU_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_image $(LIBGL) $(LIBGLU)

glsphere: examples/glsphere.f90 $(SDL_LIB) $(GLU_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) $(LIBGL) $(LIBGLU)

image: examples/image.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

info: examples/info.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

log: examples/log.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

logo: examples/logo.f90 $(SDL_LIB) $(IMG_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_image

msgbox: examples/msgbox.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

opera: examples/opera.f90 $(SDL_LIB) $(MIX_LIB) $(TTF_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_mixer -lSDL2_ttf

pixel: examples/pixel.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

scaling: examples/scaling.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

text: examples/text.f90 $(SDL_LIB) $(TTF_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS) -lSDL2_ttf

vertex: examples/vertex.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

voxel: examples/voxel.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

window: examples/window.f90 $(SDL_LIB)
	$(FC) $(FFLAGS) -o $@ $? $(LDLIBS)

# Make documentation.
doc:
	ford project.md -d ./src

# Delete *.mod, *.a, *.o, and all compiled examples.
clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ `ls -1 *.a 2>/dev/null | wc -l` -gt 0 ]; then rm *.a; fi
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e alpha ]; then rm alpha; fi
	if [ -e cyclic ]; then rm cyclic; fi
	if [ -e draw ]; then rm draw; fi
	if [ -e dvd ]; then rm dvd; fi
	if [ -e events ]; then rm events; fi
	if [ -e fire ]; then rm fire; fi
	if [ -e forest ]; then rm forest; fi
	if [ -e gl ]; then rm gl; fi
	if [ -e gl3d ]; then rm gl3d; fi
	if [ -e glsphere ]; then rm glsphere; fi
	if [ -e image ]; then rm image; fi
	if [ -e info ]; then rm info; fi
	if [ -e log ]; then rm log; fi
	if [ -e logo ]; then rm logo; fi
	if [ -e msgbox ]; then rm msgbox; fi
	if [ -e opera ]; then rm opera; fi
	if [ -e pixel ]; then rm pixel; fi
	if [ -e scaling ]; then rm scaling; fi
	if [ -e text ]; then rm text; fi
	if [ -e vertex ]; then rm vertex; fi
	if [ -e voxel ]; then rm voxel; fi
	if [ -e window ]; then rm window; fi
