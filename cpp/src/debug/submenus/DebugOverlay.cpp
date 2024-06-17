#include "DebugOverlay.h"

#include <imgui-godot.h>

#include <global/admins/GSceneAdmin.h>
#include <util/Conversion.h>

void showOverlayWindow(bool *p_open) {
    ImGui::SetNextWindowBgAlpha(0.35f);
    ImGui::SetNextWindowPos(ImVec2(10, 30), ImGuiCond_Once);

    ImGui::Begin("Overlay", p_open,
                 ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoDecoration |
                     ImGuiWindowFlags_AlwaysAutoResize);

    ImGui::SeparatorText("Admin Overview");

    // if (ImGui::TreeNode("Scene Admin")) {
    //     if (GSceneAdmin::getSceneRoot() == nullptr) {
    //         ImGui::Text("Current Scene: None");
    //     }
    //     else {
    //         ImGui::Text("Current Scene: %s",
    //         godotToStdString(GSceneAdmin::getSceneRoot()->to_string()).c_str());
    //     }

    //     if (GSceneAdmin::getLevelComponent() != nullptr) {
    //         ImGui::Text("Current LevelComponent: %s",
    //         godotToStdString(GSceneAdmin::getLevelComponent()->to_string()).c_str());
    //     }
    //     else {
    //         ImGui::Text("Current LevelComponent: None");
    //     }
    //     ImGui::TreePop();
    // }

    if (ImGui::TreeNode("State Admin")) {
        ImGui::Text("Current State: %d", GStateAdmin::getGameState());
        ImGui::Text("Game Paused: %s",
                    GStateAdmin::getGamePaused() ? "true" : "false");

        ImGui::TreePop();
    }

    if (ImGui::TreeNode("Entity Admin")) {

        ImGui::TreePop();
    }

    ImGui::End();
}
