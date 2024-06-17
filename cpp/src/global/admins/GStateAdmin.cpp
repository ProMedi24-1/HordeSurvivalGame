#include "GStateAdmin.h"
// #include "godot_cpp/classes/input_event.hpp"

#include <godot_cpp/classes/node.hpp>
#include <godot_cpp/core/binder_common.hpp>

#include <global/GGameGlobals.h>

using namespace godot;

bool GStateAdmin::gamePaused = false;
GStateAdmin::GameState GStateAdmin::gameState = GameState::NONE;

void GStateAdmin::_bind_methods() {
    BIND_STATIC_METHOD(GStateAdmin, pauseGame);
    BIND_STATIC_METHOD(GStateAdmin, unpauseGame);
    BIND_STATIC_METHOD(GStateAdmin, togglePauseGame);

    BIND_STATIC_METHOD(GStateAdmin, setGamePaused, "value");
    BIND_STATIC_METHOD(GStateAdmin, getGamePaused);
    BIND_PROPERTY(gamePaused, setGamePaused, getGamePaused);

    BIND_STATIC_METHOD(GStateAdmin, setGameState, "value");
    BIND_STATIC_METHOD(GStateAdmin, getGameState);
    BIND_PROPERTY_ENUM(gameState, setGameState, getGameState,
                       "NONE, TITLE_SCREEN, MAIN_MENU, LEVEL_SELECT, PLAYING");
    BIND_ENUM_CONSTANT(NONE)
    BIND_ENUM_CONSTANT(TITLE_SCREEN)
    BIND_ENUM_CONSTANT(MAIN_MENU)
    BIND_ENUM_CONSTANT(LEVEL_SELECT)
    BIND_ENUM_CONSTANT(PLAYING)
}

GStateAdmin::GStateAdmin() {
    disableEditorProcess(this);
    set_name("GStateAdmin");
}

GStateAdmin::~GStateAdmin() = default;

void GStateAdmin::pauseGame() {
    if (gameState == GameState::PLAYING) {
        GSceneAdmin::getSceneRoot()->set_process_mode(Node::ProcessMode::PROCESS_MODE_DISABLED);
        gamePaused = true;
    }
}

void GStateAdmin::unpauseGame() {
    if (gameState == GameState::PLAYING) {
        GSceneAdmin::getSceneRoot()->set_process_mode(Node::ProcessMode::PROCESS_MODE_INHERIT);
        gamePaused = false;
    }
}

void GStateAdmin::togglePauseGame() {
    if (gameState == GameState::PLAYING) {
        if (gamePaused) {
            unpauseGame();
        } else {
            pauseGame();
        }
    }
}

void GStateAdmin::_input(const Ref<InputEvent> &event) {
    if (event->is_action_pressed("PauseMenu") && gameState == GameState::PLAYING) {
        togglePauseGame();
    }
}

void GStateAdmin::_ready() {
    GLogger::log("GStateAdmin ready", getConstColor(ConstColor::GREEN_YELLOW));
}

void GStateAdmin::_process(double delta) {
    // Intentionally left blank.
}

void GStateAdmin::_physics_process(double delta) {
    // Intentionally left blank.
}
