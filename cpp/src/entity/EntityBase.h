#pragma once

#include <godot_cpp/classes/node2d.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>

namespace godot {

class EntityBase : public Node2D {
    GDCLASS(EntityBase, Node2D)

  protected:
    static void _bind_methods();

  public:
    EntityBase();
    ~EntityBase() override;

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
    void _exit_tree() override;
};

} // namespace godot
