#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/ClassHelper.h>
#include <util/Common.h>

namespace godot {

class LevelBase : public Node {
    GDCLASS(LevelBase, Node)

  private:
    const u32 maxDifficulty = 100;
    u32 difficulty = 0;
    bool isAdaptive = false;
    bool isDecoupled = false;
    bool isStatic = false;

    u32 maxTime = 600;
    u32 timeElapsed = 0;
    bool holdTime = false;

  protected:
    static void _bind_methods();

  public:
    LevelBase();
    ~LevelBase() override;

    void updateTime();

    void updateDifficulty();
    void updateLinear();
    void updateAdaptive();

    u32 getTimeElapsed() const { return timeElapsed; }
    void setTimeElapsed(u32 time) { timeElapsed = time; }

    u32 getDifficulty() const { return difficulty; }
    void setDifficulty(u32 diff) { difficulty = diff; }

    u32 getMaxTime() const { return maxTime; }
    void setMaxTime(u32 time) { maxTime = time; }

    String getTimeString(int time) const;

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};

} // namespace godot
