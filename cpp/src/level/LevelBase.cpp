#include "LevelBase.h"

#include <godot_cpp/classes/class_db_singleton.hpp>
#include <godot_cpp/classes/timer.hpp>
#include <util/Conversion.h>

void LevelBase::_bind_methods() {
    ADD_SIGNAL(MethodInfo("timeChanged"));

    BIND_METHOD(LevelBase, getTimeElapsed);
    BIND_METHOD(LevelBase, setTimeElapsed, "time");
    BIND_METHOD(LevelBase, getTimeString, "time");

    BIND_METHOD(LevelBase, getDifficulty);
    BIND_METHOD(LevelBase, setDifficulty, "diff");

    BIND_METHOD(LevelBase, getMaxTime);
    BIND_METHOD(LevelBase, setMaxTime, "time");
}

LevelBase::LevelBase() = default;

LevelBase::~LevelBase() = default;

void LevelBase::_ready() {
    const auto levelTimer = memnew(Timer);

    levelTimer->set_wait_time(1);
    levelTimer->set_one_shot(false);
    levelTimer->connect("timeout", callable_mp(this, &LevelBase::updateTime));
    add_child(levelTimer);
    levelTimer->start();
}

void LevelBase::updateTime() {
    if (holdTime) {
        return;
    }

    if (timeElapsed >= maxTime) {
        GLogger::log("Max Time reached");
        updateDifficulty();
    } else {
        timeElapsed += 1;
        updateDifficulty();
    }

    emit_signal("timeChanged");
}

void LevelBase::updateDifficulty() {
    if (isStatic) {
        return;
    }

    if (isAdaptive) {
        updateAdaptive();
    } else {
        updateLinear();
    }
}

void LevelBase::updateLinear() {
    if (isDecoupled) {
        difficulty += (100 / maxTime);
        difficulty = std::min(difficulty, maxDifficulty);
    } else {
        difficulty = ((timeElapsed / maxTime) * maxDifficulty);
        difficulty = std::min(difficulty, maxDifficulty);
    }
}

void LevelBase::updateAdaptive() {
    // TODO: Implement.
    difficulty = 5;
}

String LevelBase::getTimeString(int time) const {
    return convertStr(std::format("{:02}:{:02}", time / 60, time % 60));
}

void LevelBase::_process(double delta) {
    // Intentionally left blank.
}

void LevelBase::_physics_process(double delta) {
    // Intentionally left blank.
}
