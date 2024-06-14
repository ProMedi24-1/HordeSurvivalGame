#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>

#include <global/admins/GSceneAdmin.h>
#include <global/admins/GStateAdmin.h>
#include <global/admins/GEntityAdmin.h>

using namespace godot;

class GGameGlobals : public Node {
    GDCLASS(GGameGlobals, Node)

  private:
    static GGameGlobals *instance;

    GSceneAdmin *sceneAdmin = nullptr;
    GStateAdmin *stateAdmin = nullptr;
    GEntityAdmin *entityAdmin = nullptr;

    //std::set<Node *> adminSet = {memnew(GSceneAdmin), memnew(GStateAdmin)};

  protected:
    static void _bind_methods();

  public:
    GGameGlobals();
    ~GGameGlobals();

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;

    static GGameGlobals *getInstance() { return instance; }
    static GSceneAdmin *getSceneAdmin() { return instance->sceneAdmin; }
    static GStateAdmin *getStateAdmin() { return instance->stateAdmin; }

    static void setupImGui();
    void addDebugMenus();
};
