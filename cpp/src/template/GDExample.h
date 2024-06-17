#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>


using namespace godot;

class GDExample : public Node {
    GDCLASS(GDExample, Node)

  private:
    double amplitude;

  protected:
    static void _bind_methods();

  public:
    GDExample();
    ~GDExample();

    double get_amplitude() const;

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};
