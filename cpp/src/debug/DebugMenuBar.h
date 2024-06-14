#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>
#include <godot_cpp/classes/node.hpp>


using namespace godot;

class DebugMenuBar : public Node {
    GDCLASS(DebugMenuBar, Node)

  private:

  protected:
    static void _bind_methods();

  public:
    DebugMenuBar();
    ~DebugMenuBar();

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};
