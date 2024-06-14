#include <util/Common.h>

inline std::string godotToStdString(const godot::String &godotStr) {
    return godotStr.utf8().get_data();
}

inline godot::String stdStringToGodot(const std::string &stdStr) {
    return godot::String(stdStr.c_str());
}