#include <util/Common.h>

inline std::string convertStr(const godot::String &godotStr) {
    return godotStr.utf8().get_data();
}

inline godot::String convertStr(const std::string &stdStr) {
    return godot::String(stdStr.c_str());
}
