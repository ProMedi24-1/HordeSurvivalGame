// #include "register_types.h"

#include <gdextension_interface.h>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/godot.hpp>

#include <implot.h>

#include <Modules.h>

using namespace godot;

void initialize_modules(ModuleInitializationLevel p_level) {
    if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
        return;
    }

    initModules();
}

void uninitialize_modules(ModuleInitializationLevel p_level) {
    if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
        return;
    }

    uninitModules();
}

extern "C" {
// Initialization.
GDExtensionBool GDE_EXPORT
gamecore_init(GDExtensionInterfaceGetProcAddress p_get_proc_address,
              const GDExtensionClassLibraryPtr p_library,
              GDExtensionInitialization *r_initialization) {
    godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address,
                                                   p_library, r_initialization);

    init_obj.register_initializer(initialize_modules);
    init_obj.register_terminator(uninitialize_modules);
    init_obj.set_minimum_library_initialization_level(
        MODULE_INITIALIZATION_LEVEL_SCENE);

    return init_obj.init();
}
}