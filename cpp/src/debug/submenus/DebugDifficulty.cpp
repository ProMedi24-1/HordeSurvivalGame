#include "DebugDifficulty.h"

#include <imgui-godot.h>

#include <global/admins/GSceneAdmin.h>
#include <util/Conversion.h>

void showDifficultyWindow(bool *p_open) {

    ImGui::SetNextWindowSize(ImVec2(280, 240), ImGuiCond_Once);
    ImGui::SetNextWindowPos(ImVec2(10, 30), ImGuiCond_Once);

    ImGui::Begin("Difficulty", p_open);

    ImGui::Text("Current Difficulty: %d",
                GSceneAdmin::getLevelBase()->getDifficulty());

    ImGui::End();
}
