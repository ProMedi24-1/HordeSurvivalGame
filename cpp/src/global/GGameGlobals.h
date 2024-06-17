#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>

#include <global/admins/GEntityAdmin.h>
#include <global/admins/GSceneAdmin.h>
#include <global/admins/GStateAdmin.h>

namespace godot {

class GGameGlobals : public Node {
    GDCLASS(GGameGlobals, Node)

  private:
    static GGameGlobals *instance;

  protected:
    static void _bind_methods();

  public:
    GGameGlobals();
    ~GGameGlobals() override;

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;

    static GGameGlobals *getInstance() { return instance; }

    static void setupImGui();
    void addDebugMenus();
};

} // namespace godot
