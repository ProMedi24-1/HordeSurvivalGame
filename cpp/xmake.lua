extension_name = "gamecore"
godot_cpp_version = "4.2"

target(extension_name)
    set_kind("shared")
    --set_plat(os.host()) -- set platform: "windows", "linux", "macosx"
    set_arch(os.arch()) -- set arch: "64", "86", "arm64"

    set_targetdir("../project/bin/")
    set_basename(extension_name .. "_$(plat)_$(mode)_$(arch)")

    -- set compiler and c++ standard
    set_toolchains("clang")
    set_languages("cxx23")

    -- add our source files
    add_files("src/**.cpp")
    add_includedirs("src/")
    
    -- add includes for third party libs
    add_includedirs("lib/")

    -- ImGui Godot
    add_includedirs("../project/addons/imgui-godot/include")
    add_defines('IMGUI_USER_CONFIG="imconfig-godot.h"')

    -- ImGui
    add_includedirs("lib/imgui")
    add_files("lib/imgui/*.cpp")

    add_includedirs("lib/implot")
    add_files("lib/implot/*.cpp")
    
   
    -- Godot CPP
    add_includedirs("godot-cpp/gdextension")
    add_includedirs("godot-cpp/include")
    add_includedirs("godot-cpp/gen/include")

    -- linking to static library
    add_linkdirs("godot-cpp/bin")
    add_links("libgodot-cpp.windows.template_debug.x86_64")
  
    
  