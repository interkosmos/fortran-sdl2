add_rules("mode.debug", "mode.release")
set_default(false)
set_languages("fortran")
set_targetdir("build")
add_fcflags("-Wall -std=f2008 -fmax-errors=1")

-- libsdl2.a
target("sdl2")
    set_default(true)
    set_kind("static")
    add_files("src/c_util.f90")
    add_files("src/sdl2/sdl2_stdinc.f90")
    add_files("src/sdl2/sdl2_audio.f90")
    add_files("src/sdl2/sdl2_blendmode.f90")
    add_files("src/sdl2/sdl2_cpuinfo.f90")
    add_files("src/sdl2/sdl2_error.f90")
    add_files("src/sdl2/sdl2_events.f90")
    add_files("src/sdl2/sdl2_filesystem.f90")
    add_files("src/sdl2/sdl2_hints.f90")
    add_files("src/sdl2/sdl2_gamecontroller.f90")
    add_files("src/sdl2/sdl2_keyboard.f90")
    add_files("src/sdl2/sdl2_joystick.f90")
    add_files("src/sdl2/sdl2_log.f90")
    add_files("src/sdl2/sdl2_messagebox.f90")
    add_files("src/sdl2/sdl2_rect.f90")
    add_files("src/sdl2/sdl2_pixels.f90")
    add_files("src/sdl2/sdl2_platform.f90")
    add_files("src/sdl2/sdl2_scancode.f90")
    add_files("src/sdl2/sdl2_surface.f90")
    add_files("src/sdl2/sdl2_render.f90")
    add_files("src/sdl2/sdl2_keycode.f90")
    add_files("src/sdl2/sdl2_mouse.f90")
    add_files("src/sdl2/sdl2_rwops.f90")
    add_files("src/sdl2/sdl2_thread.f90")
    add_files("src/sdl2/sdl2_timer.f90")
    add_files("src/sdl2/sdl2_version.f90")
    add_files("src/sdl2/sdl2_video.f90")
    add_files("src/sdl2/sdl2_opengl.f90")
    add_files("src/sdl2.f90")

-- libsdl2_image.a
target("sdl2_image")
    set_default(true)
    set_kind("static")
    add_deps("sdl2")
    add_files("src/sdl2_image.f90")

-- libsdl2_mixer.a
target("sdl2_mixer")
    set_default(true)
    set_kind("static")
    add_deps("sdl2")
    add_files("src/c_util.f90")
    add_files("src/sdl2_mixer.f90")

-- libsdl2_ttf.a
target("sdl2_ttf")
    set_default(true)
    set_kind("static")
    add_deps("sdl2")
    add_files("src/sdl2_ttf.f90")

-- libglu.a
target("glu")
    set_default(true)
    set_kind("static")
    add_deps("sdl2")
    add_files("src/glu.f90")

-- libfortran-sdl2.a
target("fortran-sdl2")
    set_default(true)
    set_kind("static")
    add_files("src/c_util.f90")
    add_files("src/sdl2/sdl2_stdinc.f90")
    add_files("src/sdl2/sdl2_audio.f90")
    add_files("src/sdl2/sdl2_blendmode.f90")
    add_files("src/sdl2/sdl2_cpuinfo.f90")
    add_files("src/sdl2/sdl2_error.f90")
    add_files("src/sdl2/sdl2_events.f90")
    add_files("src/sdl2/sdl2_filesystem.f90")
    add_files("src/sdl2/sdl2_gamecontroller.f90")
    add_files("src/sdl2/sdl2_hints.f90")
    add_files("src/sdl2/sdl2_keyboard.f90")
    add_files("src/sdl2/sdl2_joystick.f90")
    add_files("src/sdl2/sdl2_log.f90")
    add_files("src/sdl2/sdl2_messagebox.f90")
    add_files("src/sdl2/sdl2_rect.f90")
    add_files("src/sdl2/sdl2_pixels.f90")
    add_files("src/sdl2/sdl2_platform.f90")
    add_files("src/sdl2/sdl2_scancode.f90")
    add_files("src/sdl2/sdl2_surface.f90")
    add_files("src/sdl2/sdl2_render.f90")
    add_files("src/sdl2/sdl2_keycode.f90")
    add_files("src/sdl2/sdl2_mouse.f90")
    add_files("src/sdl2/sdl2_rwops.f90")
    add_files("src/sdl2/sdl2_thread.f90")
    add_files("src/sdl2/sdl2_timer.f90")
    add_files("src/sdl2/sdl2_version.f90")
    add_files("src/sdl2/sdl2_video.f90")
    add_files("src/sdl2/sdl2_opengl.f90")
    add_files("src/sdl2.f90")
    add_files("src/sdl2_image.f90")
    add_files("src/sdl2_mixer.f90")
    add_files("src/sdl2_ttf.f90")
    add_files("src/glu.f90")

-- examples/alpha/alpha
target("alpha")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/alpha/alpha.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/alpha/")

-- examples/cyclic/cyclic
target("cyclic")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/cyclic/cyclic.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/cyclic/")

-- examples/draw/draw
target("draw")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/draw/draw.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/draw/")

-- examples/dvd/dvd
target("dvd")
    set_kind("binary")
    add_deps("sdl2", "sdl2_image")
    add_files("examples/dvd/dvd.f90")
    add_syslinks("SDL2", "SDL2_image")
    set_targetdir("examples/dvd/")

-- examples/events/events
target("events")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/events/events.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/events/")

-- examples/fire/fire
target("fire")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/fire/fire.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/fire/")

-- examples/forest/forest
target("forest")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/forest/forest.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/forest/")

-- examples/gl/gl
target("gl")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/gl/gl.f90")
    add_syslinks("SDL2")
    if is_os("windows") then
        add_syslinks("opengl32")
    else
        add_syslinks("GL")
    end
    set_targetdir("examples/gl/")

-- examples/gl3d/gl3d
target("gl3d")
    set_kind("binary")
    add_deps("sdl2", "sdl2_image", "glu")
    add_files("examples/gl3d/gl3d.f90")
    add_syslinks("SDL2", "SDL2_image")
    if is_os("windows") then
        add_syslinks("opengl32", "glu32")
    else
        add_syslinks("GL", "GLU")
    end
    set_targetdir("examples/gl3d/")

-- examples/glsphere
target("glsphere")
    set_kind("binary")
    add_deps("sdl2", "glu")
    add_files("examples/glsphere/glsphere.f90")
    add_syslinks("SDL2")
    if is_os("windows") then
        add_syslinks("opengl32", "glu32")
    else
        add_syslinks("GL", "GLU")
    end
    set_targetdir("examples/glsphere/")

-- examples/image/image
target("image")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/image/image.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/image/")

-- examples/info/info
target("info")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/info/info.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/info/")

-- examples/msgbox/msgbox
target("msgbox")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/msgbox/msgbox.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/msgbox/")

-- examples/opera/opera
target("opera")
    set_kind("binary")
    add_deps("sdl2", "sdl2_image", "sdl2_mixer", "sdl2_ttf")
    add_files("examples/opera/opera.f90")
    add_syslinks("SDL2", "SDL2_image", "SDL2_mixer", "SDL2_ttf")
    set_targetdir("examples/opera/")

-- examples/pixel/pixel
target("pixel")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/pixel/pixel.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/pixel/")

-- examples/scaling/scaling
target("scaling")
    set_kind("binary")
    add_deps("sdl2")
    add_files("examples/scaling/scaling.f90")
    add_syslinks("SDL2")
    set_targetdir("examples/scaling/")

-- examples/text/text
target("text")
    set_kind("binary")
    add_deps("sdl2", "sdl2_ttf")
    add_files("examples/text/text.f90")
    add_syslinks("SDL2", "SDL2_ttf")
    set_targetdir("examples/text/")

-- examples/voxel/voxel
target("voxel")
    set_kind("binary")
    add_deps("sdl2", "sdl2_ttf")
    add_files("examples/voxel/voxel.f90")
    add_syslinks("SDL2", "SDL2_ttf")
    set_targetdir("examples/voxel/")

-- examples/window/window
target("window")
    set_kind("binary")
    add_deps("sdl2", "sdl2_ttf")
    add_files("examples/window/window.f90")
    add_syslinks("SDL2", "SDL2_ttf")
    set_targetdir("examples/window/")

-- all examples
target("examples")
    set_kind("phony")
    add_deps("alpha")
    add_deps("cyclic")
    add_deps("draw")
    add_deps("dvd")
    add_deps("events")
    add_deps("fire")
    add_deps("gl")
    add_deps("gl3d")
    add_deps("glsphere")
    add_deps("forest")
    add_deps("image")
    add_deps("info")
    add_deps("msgbox")
    add_deps("opera")
    add_deps("pixel")
    add_deps("scaling")
    add_deps("text")
    add_deps("voxel")
    add_deps("window")
