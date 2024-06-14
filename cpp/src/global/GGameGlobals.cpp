#include "GGameGlobals.h"

#include <global/GLogger.h>
#include <godot_cpp/classes/os.hpp>
#include <util/Color.h>

#include <debug/DebugMenuBar.h>

#include <imgui-godot.h>

using namespace godot;



void GGameGlobals::_bind_methods() {}

GGameGlobals *GGameGlobals::instance = nullptr;

GGameGlobals::GGameGlobals() { 
    disableEditorProcess(this);
  
}

GGameGlobals::~GGameGlobals() {}

void GGameGlobals::_ready() {
    if (isEditor()) {
        return;
    }

    setupImGui();

    const auto isDebug = OS::get_singleton()->is_debug_build();
    const auto platform = OS::get_singleton()->get_name();

    if (isDebug) {
        GLogger::log("Running Debug-Build", getConstColor(ConstColor::YELLOW));
        addDebugMenus();
    } else {
        GLogger::log("Running Release-Build",
                     getConstColor(ConstColor::YELLOW));
    }

      
    if (instance == nullptr) {
        instance = this;

        sceneAdmin = memnew(GSceneAdmin);
        add_child(sceneAdmin);

        stateAdmin = memnew(GStateAdmin);
        add_child(stateAdmin);

        entityAdmin = memnew(GEntityAdmin);
        add_child(entityAdmin);
    }

    GLogger::log("GGameGlobals ready", getConstColor(ConstColor::GREEN_YELLOW));
}

void GGameGlobals::_process(double delta) {}

void GGameGlobals::_physics_process(double delta) {}

void GGameGlobals::addDebugMenus() {
    GLogger::log("Adding Debug-Menus", getConstColor(ConstColor::DODGER_BLUE));
    
    auto debugMenuBar = memnew(DebugMenuBar());

    add_child(debugMenuBar);
}

void GGameGlobals::setupImGui() {
    // Config
    ImGuiIO &io = ImGui::GetIO();
    io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;

    // Style
    ImGuiStyle &style = ImGui::GetStyle();
    style.WindowRounding = 8.0f;
}