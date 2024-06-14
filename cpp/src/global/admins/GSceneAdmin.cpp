#include "GSceneAdmin.h"

#include <util/Conversion.h>
#include <utility>

#include <godot_cpp/classes/packed_scene.hpp>
#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/classes/resource_loader.hpp>
#include <godot_cpp/classes/scene_tree.hpp>


#include <global/GGameGlobals.h>

using namespace godot;

std::unordered_map<std::string, std::pair<GStateAdmin::GameState, std::string>>
    GSceneAdmin::sceneMap;
Node *GSceneAdmin::sceneRoot = nullptr;
Node *GSceneAdmin::levelComponent = nullptr;

void GSceneAdmin::_bind_methods() {
    BIND_STATIC_METHOD(GSceneAdmin, addSceneToMap, "name", "state",
                       "scenePath");
    BIND_STATIC_METHOD(GSceneAdmin, reloadScene);
    BIND_STATIC_METHOD(GSceneAdmin, switchScene, "name");
    BIND_STATIC_METHOD(GSceneAdmin, getSceneRoot);
    BIND_STATIC_METHOD(GSceneAdmin, getLevelComponent);
}

GSceneAdmin::GSceneAdmin() {
    disableEditorProcess(this);
    set_name("GSceneAdmin");

    //setLevelData();
}

GSceneAdmin::~GSceneAdmin() {}

void GSceneAdmin::addSceneToMap(const String &name, int state,
                                const String &scenePath) {

    const auto &stdName = godotToStdString(name);
    const auto &stdScenePath = godotToStdString(scenePath);

    const GStateAdmin::GameState enumState =
        static_cast<GStateAdmin::GameState>(state);

    if (sceneMap.find(stdName) != sceneMap.end()) {
        GLogger::log("GSceneAdmin: Scene already in SceneMap",
                     getConstColor(ConstColor::RED));
        return;
    }
    sceneMap.insert({stdName, {enumState, stdScenePath}});
}

void GSceneAdmin::reloadScene() {
    switchScene((GGameGlobals::getSceneAdmin()->sceneRoot->get_name()));
}

void GSceneAdmin::switchScene(const String &name) {
    const auto &stdName = godotToStdString(name);

    if (sceneMap.find(stdName) == sceneMap.end()) {
        GLogger::log("GSceneAdmin: Scene not found",
                     getConstColor(ConstColor::RED));
        return;
    }

    const String &path = stdStringToGodot(sceneMap[stdName].second);
    Ref<PackedScene> sceneResource =
        ResourceLoader::get_singleton()->load(path);

    GGameGlobals::getSceneAdmin()->get_tree()->change_scene_to_packed(
        sceneResource);

    // Only call setLevelData() when the new SceneTree is ready, otherwise it
    // will crash.
    GGameGlobals::getInstance()->get_tree()->connect(
        "node_added",
        callable_mp(GGameGlobals::getSceneAdmin(), &GSceneAdmin::setLevelData),
        ConnectFlags::CONNECT_ONE_SHOT);
}

void GSceneAdmin::setLevelData() {
    sceneRoot = GGameGlobals::getSceneAdmin()->get_tree()->get_current_scene();

    GStateAdmin::setGamePaused(false);

    GLogger::log(
        stdStringToGodot(std::format("GSceneAdmin: SceneRoot: {}",
                                     godotToStdString(sceneRoot->get_name()))),
        getConstColor(ConstColor::GREEN));

    if (sceneMap.find(godotToStdString(sceneRoot->get_name())) ==
        sceneMap.end()) {
        GLogger::log("GSceneAdmin: WARNING Scene not in SceneMap",
                     getConstColor(ConstColor::YELLOW));
        // GStateAdmin::setGameState(GStateAdmin::GameState::PLAYING);
        return;
    }

    if (sceneRoot->has_node("LevelBaseComponent")) {
        levelComponent = sceneRoot->get_node_internal("LevelBaseComponent");
        GLogger::log("GSceneAdmin: Found LevelBaseComponent",
                     getConstColor(ConstColor::GREEN));
    } else {
        GLogger::log("GSceneAdmin: No LevelBaseComponent found",
                     getConstColor(ConstColor::YELLOW));
    }

    GStateAdmin::setGameState(
        sceneMap[godotToStdString(sceneRoot->get_name())].first);
}

Node *GSceneAdmin::getSceneRoot() { return sceneRoot; }
Node *GSceneAdmin::getLevelComponent() { return levelComponent; }

void GSceneAdmin::_ready() {
    // if (isEditor()) {
    //     return;
    // }

    setLevelData();

    GLogger::log("GSceneAdmin: _ready()", getConstColor(ConstColor::GREEN));
  

    // Add current scene to sceneMap
    // addSceneToMap(sceneRoot->get_name(), 4,
    // sceneRoot->get_scene_file_path());
}

void GSceneAdmin::_process(double delta) {}

void GSceneAdmin::_physics_process(double delta) {}
