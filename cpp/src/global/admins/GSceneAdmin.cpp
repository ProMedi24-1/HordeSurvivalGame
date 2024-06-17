#include "GSceneAdmin.h"

#include <util/Conversion.h>
#include <utility>

#include <godot_cpp/classes/packed_scene.hpp>
#include <godot_cpp/classes/resource.hpp>
#include <godot_cpp/classes/resource_loader.hpp>
#include <godot_cpp/classes/scene_tree.hpp>

#include <utility>

#include <global/GGameGlobals.h>

std::unordered_map<std::string, std::pair<GStateAdmin::GameState, std::string>>
    GSceneAdmin::sceneMap;
Node *GSceneAdmin::sceneRoot = nullptr;
LevelBase *GSceneAdmin::levelBase = nullptr;

// static const String test;

void GSceneAdmin::_bind_methods() {
    BIND_STATIC_METHOD(GSceneAdmin, addSceneToMap, "name", "state", "scenePath");
    BIND_STATIC_METHOD(GSceneAdmin, reloadScene);
    BIND_STATIC_METHOD(GSceneAdmin, switchScene, "name");
    BIND_STATIC_METHOD(GSceneAdmin, getSceneRoot);
    BIND_STATIC_METHOD(GSceneAdmin, getLevelBase);
}

GSceneAdmin::GSceneAdmin() {
    disableEditorProcess(this);
    set_name("GSceneAdmin");
}

GSceneAdmin::~GSceneAdmin() = default;

void GSceneAdmin::addSceneToMap(const String &name, int state, const String &scenePath) {

    const auto &stdName = convertStr(name);
    const auto &stdScenePath = convertStr(scenePath);

    auto enumState = static_cast<GStateAdmin::GameState>(state);

    if (!sceneMap.try_emplace(stdName, enumState, stdScenePath).second) {
        GLogger::log("GSceneAdmin: Scene already in SceneMap", getConstColor(ConstColor::RED));
        return;
    }
}

void GSceneAdmin::reloadScene() { switchScene((GSceneAdmin::getSceneRoot()->get_name())); }

void GSceneAdmin::switchScene(const String &name) {
    const auto &stdName = convertStr(name);

    if (!sceneMap.contains(stdName)) {
        GLogger::log("GSceneAdmin: Scene not found", getConstColor(ConstColor::RED));
        return;
    }

    const String &path = convertStr(sceneMap[stdName].second);
    Ref<PackedScene> sceneResource = ResourceLoader::get_singleton()->load(path);

    GGameGlobals::getInstance()->get_tree()->change_scene_to_packed(sceneResource);

    // Only call setLevelData() when the new SceneTree is ready, otherwise it
    // will crash.
    GGameGlobals::getInstance()->get_tree()->connect("node_added",
                                                     callable_mp_static(&GSceneAdmin::setLevelData),
                                                     ConnectFlags::CONNECT_ONE_SHOT);
}

void GSceneAdmin::setLevelData() {
    sceneRoot = GGameGlobals::getInstance()->get_tree()->get_current_scene();
    const auto &rootName = convertStr(sceneRoot->get_name());

    GStateAdmin::setGamePaused(false);

    GLogger::log(convertStr(std::format("GSceneAdmin: SceneRoot: {}", rootName)),
                 getConstColor(ConstColor::GREEN));

    if (!sceneMap.contains(rootName)) {
        GLogger::log("GSceneAdmin: WARNING Scene not in SceneMap",
                     getConstColor(ConstColor::YELLOW));

        // Add to map so we can reload it later. Default to PLAYING gamestate for playtesting of
        // levels.
        addSceneToMap(sceneRoot->get_name(), GStateAdmin::GameState::PLAYING,
                      sceneRoot->get_scene_file_path());
    }

    GStateAdmin::setGameState(sceneMap[rootName].first);

    // Rather than checking by name we just take the first Node which is
    // of type LevelBase.
    for (u32 i = 0; i < sceneRoot->get_child_count(); ++i) {
        if (sceneRoot->get_child(i)->is_class("LevelBase")) {
            levelBase = static_cast<LevelBase *>(sceneRoot->get_child(i));
            GLogger::log("GSceneAdmin: Found LevelBase", getConstColor(ConstColor::GREEN));
            break;
        }
    }

    if (levelBase == nullptr) {
        GLogger::log("GSceneAdmin: No LevelBase found", getConstColor(ConstColor::YELLOW));
    }
}

void GSceneAdmin::_ready() {
    if (isEditor()) {
        return;
    }

    setLevelData();

    GLogger::log("GSceneAdmin ready", getConstColor(ConstColor::GREEN_YELLOW));
}

void GSceneAdmin::_process(double delta) {
    // Intentionally left blank.
}

void GSceneAdmin::_physics_process(double delta) {
    // Intentionally left blank.
}
