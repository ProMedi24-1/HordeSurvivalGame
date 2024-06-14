#include "DebugMenuBar.h"

#include <godot_cpp/classes/scene_tree.hpp>
#include <global/GLogger.h>
#include <imgui-godot.h>
#include <implot.h>

#include <global/GGameGlobals.h>
#include <debug/submenus/DebugProfilers.h>
#include <debug/submenus/DebugOverlay.h>

#include <util/Conversion.h>

using namespace godot;

void DebugMenuBar::_bind_methods() {}

DebugMenuBar::DebugMenuBar() { 
    disableEditorProcess(this); 
    set_name("DebugMenuBar");

    
}

DebugMenuBar::~DebugMenuBar() {}

void DebugMenuBar::_ready() {}

void DebugMenuBar::_process(double delta) {
    ImGui::BeginMainMenuBar();

    if (ImGui::BeginMenu("Game")) {
        if (ImGui::MenuItem("Quit Game")) {
            get_tree()->quit();
        }
        ImGui::EndMenu();
    }

    if (ImGui::BeginMenu("Scenes")) {
        if (ImGui::MenuItem("Reload Scene")) {
            // NOTE: Use scene admin to change scene.
            GSceneAdmin::reloadScene();
        }
        if (ImGui::BeginMenu("Quick Change")) {

            for (auto &scene : GGameGlobals::getSceneAdmin()->getSceneMap()) {
                if (ImGui::MenuItem(scene.first.c_str())) {
                    GGameGlobals::getSceneAdmin()->switchScene(stdStringToGodot(scene.first));
                }
            }   
            //GGameGlobals::getSceneAdmin()->switchScene("PrototypeLevel");
            ImGui::EndMenu();
        }
        if (ImGui::MenuItem("Scene Menu")) {
            
        }
        
        ImGui::EndMenu();
    }

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

    if (ImGui::BeginMenu("Gameplay")) {
        ImGui::MenuItem("Player Menu");
        // if (ImGui::MenuItem("Toggle Overlay")) {
        //     showOverlay = !showOverlay;
        // }
        ImGui::EndMenu();
    }

    if (ImGui::BeginMenu("Level")) {
        ImGui::MenuItem("Difficulty");
        ImGui::MenuItem("Ambience");
        ImGui::EndMenu();
    }

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

    // static bool checked = false;
    // ImGui::Begin("test");
    // ImGui::Checkbox("test", &checked);
    // ImGui::End();

    
    
}

void DebugMenuBar::_physics_process(double delta) {}
