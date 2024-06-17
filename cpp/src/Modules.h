#pragma once

#include <godot_cpp/core/class_db.hpp>
#include <imgui-godot.h>
#include <implot.h>

// Include all additional Classes here.
#include <template/GDExample.h>

#include <global/GGameGlobals.h>
#include <global/GLogger.h>
#include <global/admins/GEntityAdmin.h>
#include <global/admins/GSceneAdmin.h>
#include <global/admins/GStateAdmin.h>

#include <level/LevelBase.h>

#include <debug/DebugMenuBar.h>

//...
//...
//...

namespace godot {

inline void initModules() {

    // Initialize ImGui-Godot.
    ImGui::Godot::SyncImGuiPtrs();
    // Initialize ImPlot.
    ImPlot::CreateContext();

    // Register all additional Classes here.
    GDREGISTER_CLASS(GDExample)

    // Global Classes
    GDREGISTER_CLASS(GLogger)
    GDREGISTER_CLASS(GGameGlobals)
    GDREGISTER_CLASS(GSceneAdmin)
    GDREGISTER_CLASS(GStateAdmin)
    GDREGISTER_CLASS(GEntityAdmin)

    // Entities

    // Level specifics
    GDREGISTER_CLASS(LevelBase)

    // Debug Menus
    GDREGISTER_CLASS(DebugMenuBar)

    //...
    //...
    //...
}

inline void uninitModules() { ImPlot::DestroyContext(); }

} // namespace godot
