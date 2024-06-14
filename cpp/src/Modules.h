#pragma once

#include <godot_cpp/core/class_db.hpp>
#include <imgui-godot.h>
#include <implot.h>

// Include all additional Classes here.
#include <template/GDExample.h>

#include <global/GLogger.h>
#include <global/GGameGlobals.h>
#include <global/admins/GSceneAdmin.h>
#include <global/admins/GStateAdmin.h>
#include <global/admins/GEntityAdmin.h>

#include <debug/DebugMenuBar.h>
//...
//...
//...

using namespace godot;

namespace Modules {

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

    GDREGISTER_CLASS(DebugMenuBar)

    //...
    //...
    //...
}

inline void uninitModules() {
	ImPlot::DestroyContext();
}

} // namespace Modules