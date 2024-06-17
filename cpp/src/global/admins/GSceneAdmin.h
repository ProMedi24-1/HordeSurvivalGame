#pragma once

#include <godot_cpp/classes/node.hpp>
#include <unordered_map>
#include <util/ClassHelper.h>
#include <util/Common.h>

#include <global/admins/GStateAdmin.h>
#include <level/LevelBase.h>

namespace godot {

class GSceneAdmin : public Node {
    GDCLASS(GSceneAdmin, Node)

  private:
    static std::unordered_map<std::string, std::pair<GStateAdmin::GameState, std::string>> sceneMap;

    static Node *sceneRoot;
    static LevelBase *levelBase;

  protected:
    static void _bind_methods();

  public:
    GSceneAdmin();
    ~GSceneAdmin() override;

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;

    static auto getSceneMap() { return sceneMap; }

    static void addSceneToMap(const String &name, int state, const String &scenePath);

    static void switchScene(const String &name);

    static void reloadScene();

    static Node *getSceneRoot() { return sceneRoot; }
    static LevelBase *getLevelBase() { return levelBase; }

    static void setLevelData();
};

} // namespace godot
