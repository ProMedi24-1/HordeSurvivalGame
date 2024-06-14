#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>

#include <godot_cpp/classes/input.hpp>
#include <godot_cpp/classes/input_event.hpp>
#include <godot_cpp/classes/input_event_action.hpp>
#include <godot_cpp/classes/ref.hpp>

using namespace godot;



class GStateAdmin : public Node {
    GDCLASS(GStateAdmin, Node)
  public:
    enum GameState {
      NONE,
      TITLE_SCREEN,
      MAIN_MENU,
      LEVEL_SELECT,
      PLAYING,
    };

  

  private:
    static GameState gameState;
    static bool gamePaused; 

  protected:
    static void _bind_methods();

  public:
    GStateAdmin();
    ~GStateAdmin();

    static int getGameState() { return gameState; }
    static void setGameState(int state) { gameState = static_cast<GameState>(state); }

    static bool getGamePaused() { return gamePaused; }
    static void setGamePaused(bool state) { gamePaused = state; }

    static void togglePauseGame();
    static void pauseGame();
    static void unpauseGame();


    void _input(const Ref<InputEvent> &event) override;

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};

VARIANT_ENUM_CAST(GStateAdmin::GameState);