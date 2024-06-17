#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>

#include <vector>

namespace godot {

class GEntityAdmin : public Node {
    GDCLASS(GEntityAdmin, Node)

  private:
    static std::vector<Node *> entities;
    static Node *player;

  protected:
    static void _bind_methods();

  public:
    GEntityAdmin();
    ~GEntityAdmin() override;

    static void registerEntity(Node *entity);
    static void unregisterEntity(Node *entity);

    static void registerPlayer(Node *player);

    static Node *getPlayer();

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};

} // namespace godot
