#include "GEntityAdmin.h"

std::vector<Node *> GEntityAdmin::entities;
Node *GEntityAdmin::player;

void GEntityAdmin::_bind_methods() {
    BIND_STATIC_METHOD(GEntityAdmin, getPlayer);
    BIND_STATIC_METHOD(GEntityAdmin, registerEntity, "entity");
    BIND_STATIC_METHOD(GEntityAdmin, unregisterEntity, "entity");
}

GEntityAdmin::GEntityAdmin() {
    disableEditorProcess(this);
    set_name("GEntityAdmin");
}

GEntityAdmin::~GEntityAdmin() = default;

void GEntityAdmin::registerEntity(Node *entity) {
    entities.push_back(entity);

    if (entity->is_in_group("Player")) {
        player = entity;
    }
}

void GEntityAdmin::unregisterEntity(Node *entity) { std::erase(entities, entity); }

void GEntityAdmin::registerPlayer(Node *newPlayer) { player = newPlayer; }

Node *GEntityAdmin::getPlayer() { return player; }

void GEntityAdmin::_ready() {
    GLogger::log("GEntityAdmin ready", getConstColor(ConstColor::GREEN_YELLOW));
}

void GEntityAdmin::_process(double delta) {
    // Intentionally left blank.
}

void GEntityAdmin::_physics_process(double delta) {
    // Intentionally left blank.
}
