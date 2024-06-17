#pragma once

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/classes/object.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>
#include <vector>

namespace godot {

class GLogger : public Object {
    GDCLASS(GLogger, Object)

  private:
    struct logMsg {
        std::string msg;
        Color msgColor;
    };

    static std::vector<logMsg> logBuffer;

  protected:
    static void _bind_methods();

  public:
    GLogger();
    ~GLogger() override;

    static void log(const String &msg, const Color &msgColor = Color(1, 1, 1));

    static std::vector<logMsg> const &getLogBuffer();
    static void clearLogBuffer();
};

} // namespace godot
