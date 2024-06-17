#include "GGameGlobals.h"

#include <global/GLogger.h>
#include <godot_cpp/classes/os.hpp>
#include <util/Color.h>

#include <debug/DebugMenuBar.h>

#include <imgui-godot.h>

using namespace godot;

void GGameGlobals::_bind_methods() { BIND_STATIC_METHOD(GGameGlobals, getInstance); }

GGameGlobals *GGameGlobals::instance = nullptr;

GGameGlobals::GGameGlobals() = default;
GGameGlobals::~GGameGlobals() = default;

void GGameGlobals::_ready() {
    if (isEditor()) {
        return;
    }

    GLogger::log("GGameGlobals ready");

    setupImGui();

    const auto isDebug = OS::get_singleton()->is_debug_build();
    const auto &platform = OS::get_singleton()->get_name();

    if (isDebug) {
        GLogger::log("Running Debug-Build", getConstColor(ConstColor::YELLOW));
        addDebugMenus();
    } else {
        GLogger::log("Running Release-Build", getConstColor(ConstColor::YELLOW));
    }

    instance = this;

    const auto &sceneAdmin = memnew(GSceneAdmin);
    add_child(sceneAdmin);

    const auto &stateAdmin = memnew(GStateAdmin);
    add_child(stateAdmin);

    const auto &entityAdmin = memnew(GEntityAdmin);
    add_child(entityAdmin);

    GLogger::log("GGameGlobals ready", getConstColor(ConstColor::GREEN_YELLOW));
}

void GGameGlobals::_process(double delta) {
    // Intentionally left blank.
}

void GGameGlobals::_physics_process(double delta) {
    // Intentionally left blank.
}

void GGameGlobals::addDebugMenus() {
    GLogger::log("Adding Debug-Menus", getConstColor(ConstColor::DODGER_BLUE));

    const auto &debugMenuBar = memnew(DebugMenuBar());
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
