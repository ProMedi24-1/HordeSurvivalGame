#include "GLogger.h"

#include <godot_cpp/variant/utility_functions.hpp>

#include <chrono>
#include <imgui-godot.h>
#include <util/Color.h>

#include <format>

using namespace godot;

std::vector<GLogger::logMsg> GLogger::logBuffer;

void GLogger::_bind_methods() { BIND_STATIC_METHOD(GLogger, log, "msg", "msgColor"); }

GLogger::GLogger() = default;

GLogger::~GLogger() = default;

void GLogger::log(const String &msg, const Color &msgColor) {
    const auto now = std::chrono::current_zone()->to_local(std::chrono::system_clock::now());
    const String timeStr = std::format("{:%X}", now).c_str();

    const auto metaColorHex = getConstColor(ConstColor::ORANGE).to_html();
    const auto msgColorHex = msgColor.to_html();

    UtilityFunctions::print_rich("[color=" + metaColorHex + "]" + "[" + timeStr + "]" + "[LOG]" +
                                 "[/color][color=" + msgColorHex + "] " + msg + "[/color]");

    const std::string bufMsg =
        std::format("[{}] {}", timeStr.ascii().get_data(), msg.ascii().get_data());
    logBuffer.push_back((logMsg){bufMsg, msgColor});
}

const std::vector<GLogger::logMsg> &GLogger::getLogBuffer() { return logBuffer; }

void GLogger::clearLogBuffer() { logBuffer.clear(); }
