#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>
#include <unordered_map>

#include <global/admins/GStateAdmin.h>

using namespace godot;

class GSceneAdmin : public Node {
    GDCLASS(GSceneAdmin, Node)

  private:
    static std::unordered_map<std::string, std::pair<GStateAdmin::GameState, std::string>> sceneMap;

    static Node *sceneRoot;
    static Node *levelComponent;
    
  protected:
    static void _bind_methods();

  public:
    GSceneAdmin();
    ~GSceneAdmin();

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;

    static std::unordered_map<std::string, std::pair<GStateAdmin::GameState, std::string>> getSceneMap() {
        return sceneMap;
    }

    static void addSceneToMap(const String &name, int state,
                          const String &scenePath);

    static void switchScene(const String &name);

    static void reloadScene();

    static Node *getSceneRoot();
    static Node *getLevelComponent();

    void setLevelData();

    //static String getSceneName() {
      //return stdStringToGodot(sceneName);
    //}
};
