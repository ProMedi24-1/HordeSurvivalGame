#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>


using namespace godot;

class GDExample : public Node {
    GDCLASS(GDExample, Node)

  private:
  protected:
    static void _bind_methods();

  public:
    GDExample();
    ~GDExample();

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};
