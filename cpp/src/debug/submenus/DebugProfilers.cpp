#include "DebugProfilers.h"

#include <godot_cpp/classes/performance.hpp>
#include <imgui-godot.h>
#include <implot.h>

#include <util/Color.h>
#include <global/GLogger.h>


void showFrameWindow(bool *p_open) {
    
    ImGui::SetNextWindowSize(ImVec2(280, 240), ImGuiCond_Once);
    ImGui::SetNextWindowPos(ImVec2(850, 130), ImGuiCond_Once);

    ImGui::Begin("Frame", p_open);
    
    static u32 fpsCurrent;
    fpsCurrent = Engine::get_singleton()->get_frames_per_second();
    static u32 fpsAverage;
    static u32 fpsMax; 
    fpsMax = Engine::get_singleton()->get_max_fps();
    
    static f32 frameTime = 0.0f;
    frameTime = Performance::get_singleton()->get_monitor(Performance::TIME_PROCESS) * 1000;

    ImGui::Text("FPS:");
    ImGui::SameLine();
    ImGui::Text("Current: %d", fpsCurrent);
    ImGui::SameLine();
    ImGui::Text("Average: %d", fpsAverage);
    ImGui::SameLine();
    ImGui::Text("Max: %d", fpsMax);

    static profilerBuffer<float> buf(50);
    //buf.buffer = {0, 1, 2, 3, 4};
    buf.addData(fpsCurrent);

    fpsAverage = buf.getAverage();
    std::vector<float> avg(buf.size, buf.getAverage());

    
    static const float ftBudget = 8.0f;

    const int ftFlags = ImGuiTableFlags_SizingFixedFit | ImGuiTableFlags_NoHostExtendX;
    if (ImGui::BeginTable("fttable", 2)) {
        ImGui::TableSetupColumn("", ImGuiTableColumnFlags_WidthFixed, 125.0f);
      
        ImGui::TableNextRow();
        ImGui::TableNextColumn();
        ImGui::Text("Frametime: %.2fms", frameTime);

        ImGui::TableNextColumn();
        ImGui::ProgressBar(frameTime / ftBudget, ImVec2(-1, 15), "/8ms");
        ImGui::EndTable();
    }
    
    ImGui::Separator();
                
    if (ImPlot::BeginPlot("##My Plot", ImVec2(-1, -1), ImPlotFlags_NoFrame)) {

        const int axisFlags = ImPlotAxisFlags_NoLabel | ImPlotAxisFlags_Lock;    
        ImPlot::SetupAxes(NULL, NULL, axisFlags | ImPlotAxisFlags_NoTickLabels, axisFlags);

        ImPlot::SetupAxisLimits(ImAxis_X1, 0, buf.size);
        ImPlot::SetupAxisLimits(ImAxis_Y1, 0, fpsMax + 10);

        ImPlot::PlotLine("Current", buf.buffer.data(), buf.size, 1, 0, ImPlotLineFlags_NoClip);
        ImPlot::PlotLine("Average", avg.data(), buf.size, 1, 0, ImPlotLineFlags_NoClip);

        ImPlot::EndPlot();
    }

    ImGui::End();
}

void showMemoryWindow(bool *p_open) {
    ImGui::SetNextWindowSize(ImVec2(300, 200), ImGuiCond_Once);
    ImGui::SetNextWindowPos(ImVec2(830, 390), ImGuiCond_Once);
    ImGui::Begin("Memory", p_open);

    ImGui::Text("Memory Usage");

    static bool showStatic = false;
    static bool showRendering = false;
    if (ImGui::BeginTable("memtable", 2, ImGuiTableFlags_Borders | ImGuiTableFlags_RowBg)) {

        ImGui::TableSetupColumn("Static");

        ImGui::TableNextRow();
        ImGui::TableNextColumn();
        showStatic = ImGui::CollapsingHeader("Static", ImGuiTreeNodeFlags_DefaultOpen);
        ImGui::TableNextColumn();
        ImGui::Text("");


        const int bToMiB = 1024 * 1024;
        if (showStatic) {
            ImGui::TableNextRow();
            ImGui::TableNextColumn();
            ImGui::Text("Memory Static:");
            ImGui::TableNextColumn();
            ImGui::Text("%.2f MiB", Performance::get_singleton()->get_monitor(Performance::MEMORY_STATIC) / bToMiB);

            ImGui::TableNextRow();
            ImGui::TableNextColumn();
            ImGui::Text("Memory Static Max:");
            ImGui::TableNextColumn();
            ImGui::Text("%.2f MiB", Performance::get_singleton()->get_monitor(Performance::MEMORY_STATIC_MAX) / bToMiB);
        }


        ImGui::TableNextRow();
        ImGui::TableNextColumn();
        showRendering = ImGui::CollapsingHeader("Rendering", ImGuiTreeNodeFlags_DefaultOpen);
        ImGui::TableNextColumn();
        ImGui::Text("");


        if (showRendering) {
            ImGui::TableNextRow();
            ImGui::TableNextColumn();
            ImGui::Text("Memory Video:");
            ImGui::TableNextColumn();
            ImGui::Text("%.2f MiB", Performance::get_singleton()->get_monitor(Performance::RENDER_VIDEO_MEM_USED) / bToMiB);

            ImGui::TableNextRow();
            ImGui::TableNextColumn();
            ImGui::Text("Memory Texture:");
            ImGui::TableNextColumn();
            ImGui::Text("%.2f MiB", Performance::get_singleton()->get_monitor(Performance::RENDER_TEXTURE_MEM_USED) / bToMiB);

            ImGui::TableNextRow();
            ImGui::TableNextColumn();
            ImGui::Text("Memory Buffer:");
            ImGui::TableNextColumn();
            ImGui::Text("%.2f MiB", Performance::get_singleton()->get_monitor(Performance::RENDER_BUFFER_MEM_USED) / bToMiB);
        }
        ImGui::EndTable();
    }    
    
    ImGui::End();
}

void showLoggerWindow(bool *p_open) {
    ImGui::SetNextWindowSize(ImVec2(320, 250), ImGuiCond_Once);
    ImGui::SetNextWindowPos(ImVec2(430, 380), ImGuiCond_Once);
    ImGui::Begin("Logger", p_open);

   
    if (ImGui::Button("Clear Log")) {
        GLogger::clearLogBuffer();
    }

    ImGui::SameLine();
    if (ImGui::Button("Test Log")) {
        GLogger::log("Test Log 1!");
        GLogger::log("Test Log 2!", getConstColor(ConstColor::YELLOW));
        GLogger::log("Test Log 3!", getConstColor(ConstColor::RED));
    }

    ImGui::SameLine();
    static bool scrollToBottom = true;
    ImGui::Checkbox("Scroll To Bottom", &scrollToBottom);

    ImGui::Separator();

    if (ImGui::BeginChild("ScrollingRegion", ImVec2(0, 0), false)) {
        ImGui::PushTextWrapPos();

        for (const auto &log : GLogger::getLogBuffer()) {
            ImGui::TextColored(log.msgColor, "%s", log.msg.c_str());
        }

        ImGui::PopTextWrapPos();

        if (scrollToBottom) {
            ImGui::SetScrollHereY(1.0f);
        }

        ImGui::EndChild();
    }

    ImGui::End();
}
