#pragma once

#include <godot_cpp/classes/character_body2d.hpp>
#include <godot_cpp/classes/node2d.hpp>
#include <godot_cpp/classes/sprite2d.hpp>

#include <util/ClassHelper.h>
#include <util/Common.h>

#include <entity/EntityBase.h>

namespace godot {

class Player : public EntityBase {
    GDCLASS(Player, EntityBase)

  private:
    // Player Stats
    u32 maxHealth = 100;
    u32 health = maxHealth;
    bool godMode = false;

    f32 movSpeed = 5000.0f;

    // Since we are inheriting from Node2D, but want to use CharacterBody2D for movement,
    // we need to set the movBody to a CharacterBody2D Node.
    CharacterBody2D *movBody = nullptr;
    Sprite2D *playerSprite = nullptr;

  protected:
    static void _bind_methods();

  public:
    Player();
    ~Player() override;

    u32 getMaxHealth() const { return maxHealth; }
    u32 getHealth() const { return health; }
    bool getGodMode() const { return godMode; }
    f32 getMovSpeed() const { return movSpeed; }

    void setMaxHealth(u32 value) { maxHealth = value; }
    void setHealth(u32 value) { health = value; }
    void setGodMode(bool value) { godMode = value; }
    void setMovSpeed(f32 value) { movSpeed = value; }

    void handleMovement(double delta);

    void _process(double delta) override;
    void _physics_process(double delta) override;
    void _ready() override;
};

} // namespace godot
