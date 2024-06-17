#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>

namespace godot {

class DebugMenuBar : public Node {
    GDCLASS(DebugMenuBar, Node)

  protected:
    static void _bind_methods();

  public:
    DebugMenuBar();
    ~DebugMenuBar() override;

    void showGameMenu() const;
    void showSceneMenu() const;
    void showSettingsMenu() const;
    void showGameplayMenu() const;
    void showLevelMenu() const;
    void showProfilingMenu() const;

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};

} // namespace godot
