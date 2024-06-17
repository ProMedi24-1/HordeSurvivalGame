#include "DebugMenuBar.h"

#include <global/GLogger.h>
#include <godot_cpp/classes/scene_tree.hpp>
#include <imgui-godot.h>
#include <implot.h>

#include <debug/submenus/DebugDifficulty.h>
#include <debug/submenus/DebugOverlay.h>
#include <debug/submenus/DebugProfilers.h>
#include <global/GGameGlobals.h>

#include <util/Conversion.h>

using namespace godot;

void DebugMenuBar::_bind_methods() {
    // No use.
}

DebugMenuBar::DebugMenuBar() {
    disableEditorProcess(this);
    set_name("DebugMenuBar");
}

DebugMenuBar::~DebugMenuBar() = default;

void DebugMenuBar::_ready() {
    // No use.
}

void DebugMenuBar::_process(double delta) {
    ImGui::BeginMainMenuBar();

    showGameMenu();
    showSceneMenu();
    showSettingsMenu();
    showGameplayMenu();
    showLevelMenu();
    showProfilingMenu();

    static bool showDemo = false;
    if (showDemo) {
        ImGui::ShowDemoWindow(&showDemo);
    }

    if (ImGui::BeginMenu("Misc")) {
        if (ImGui::MenuItem("ImGui Demo")) {
            showDemo = true;
        }
        ImGui::EndMenu();
    }

    ImGui::EndMainMenuBar();
}

void DebugMenuBar::_physics_process(double delta) {
    // No use.
}

void DebugMenuBar::showGameMenu() const {
    if (ImGui::BeginMenu("Game")) {
        if (ImGui::MenuItem("Quit Game")) {
            get_tree()->quit();
        }
        ImGui::EndMenu();
    }
}

void DebugMenuBar::showSceneMenu() const {
    auto addMenuItems = [&](const auto &sceneMap) {
        for (const auto &[sceneName, sceneData] : sceneMap) {
            if (ImGui::MenuItem(sceneName.c_str())) {
                GSceneAdmin::switchScene(convertStr(sceneName));
            }
        }
    };

    if (ImGui::BeginMenu("Scenes")) {
        if (ImGui::MenuItem("Reload Scene")) {
            GSceneAdmin::reloadScene();
        }

        if (ImGui::BeginMenu("Quick Change")) {
            addMenuItems(GSceneAdmin::getSceneMap());
            ImGui::EndMenu();
        }
        if (ImGui::MenuItem("Scene Menu")) {
            // TODO: Implement.
        }

        ImGui::EndMenu();
    }
}

void DebugMenuBar::showSettingsMenu() const {
    static bool showOverlay = true;
    if (showOverlay) {
        showOverlayWindow(&showOverlay);
    }

    if (ImGui::BeginMenu("Settings")) {
        ImGui::MenuItem("User Settings");
        if (ImGui::MenuItem("Toggle Overlay")) {
            showOverlay = !showOverlay;
        }
        ImGui::EndMenu();
    }
}

void DebugMenuBar::showGameplayMenu() const {
    if (ImGui::BeginMenu("Gameplay")) {
        ImGui::MenuItem("Player Menu");

        ImGui::EndMenu();
    }
}

void DebugMenuBar::showLevelMenu() const {
    static bool showDifficulty = false;
    static bool showAmbience = false;
    if (showDifficulty) {
        showDifficultyWindow(&showDifficulty);
    }
    if (showAmbience) {
        // TODO: Implement.
    }

    if (ImGui::BeginMenu("Level")) {
        if (ImGui::MenuItem("Difficulty")) {
            showDifficulty = !showDifficulty;
        }

        ImGui::MenuItem("Ambience");
        ImGui::EndMenu();
    }
}

void DebugMenuBar::showProfilingMenu() const {
    static bool showVideo = false;
    static bool showMemory = false;
    static bool showLogger = false;
    if (showVideo) {
        showFrameWindow(&showVideo);
    }
    if (showMemory) {
        showMemoryWindow(&showMemory);
    }
    if (showLogger) {
        showLoggerWindow(&showLogger);
    }

    if (ImGui::BeginMenu("Profiling")) {
        if (ImGui::MenuItem("Frame")) {
            showVideo = !showVideo;
        }
        if (ImGui::MenuItem("Memory")) {
            showMemory = !showMemory;
        }
        if (ImGui::MenuItem("Logger")) {
            showLogger = !showLogger;
        }
        ImGui::EndMenu();
    }
}
