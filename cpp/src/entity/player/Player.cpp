#include "Player.h"

#include <global/admins/GEntityAdmin.h>
#include <godot_cpp/classes/input.hpp>

void Player::_bind_methods() {
    BIND_METHOD(Player, getMaxHealth);
    BIND_METHOD(Player, setMaxHealth, "value");
    ADD_PROPERTY(PropertyInfo(Variant::Type::INT, "maxHealth"), "setMaxHealth", "getMaxHealth");

    BIND_METHOD(Player, getHealth);
    BIND_METHOD(Player, setHealth, "value");
    ADD_PROPERTY(PropertyInfo(Variant::Type::INT, "health"), "setHealth", "getHealth");

    BIND_METHOD(Player, getGodMode);
    BIND_METHOD(Player, setGodMode, "value");
    ADD_PROPERTY(PropertyInfo(Variant::Type::BOOL, "godMode"), "setGodMode", "getGodMode");

    BIND_METHOD(Player, getMovSpeed);
    BIND_METHOD(Player, setMovSpeed, "value");
    ADD_PROPERTY(PropertyInfo(Variant::Type::FLOAT, "movSpeed"), "setMovSpeed", "getMovSpeed");
}

Player::Player() { disableEditorProcess(this); }

Player::~Player() = default;

void Player::_ready() {
    if (isEditor()) {
        return;
    }

    EntityBase::_ready();

    movBody = static_cast<CharacterBody2D *>(get_parent());

    GLogger::log("Player ready", getConstColor(ConstColor::GREEN_YELLOW));
}

void Player::_process(double delta) {
    // Intentionally left blank.
}

void Player::_physics_process(double delta) {

    handleMovement(delta);
    movBody->move_and_slide();
}

void Player::handleMovement(double delta) {
    auto direction = Vector2(0, 0);

    direction = Input::get_singleton()->get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown");

    movBody->set_velocity(direction.normalized() * movSpeed * static_cast<f32>(delta));
}
