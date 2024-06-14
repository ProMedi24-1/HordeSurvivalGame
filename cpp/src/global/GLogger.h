#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>
#include <vector>

using namespace godot;

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
    ~GLogger();

    static void log(const String &msg, const Color &msgColor = Color(1, 1, 1));

    
    static const std::vector<logMsg>& getLogBuffer();
    static void clearLogBuffer();
};
