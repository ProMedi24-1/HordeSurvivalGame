#include "GEntityAdmin.h"

using namespace godot;


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

GEntityAdmin::~GEntityAdmin() {}

void GEntityAdmin::registerEntity(Node *entity) {
    entities.push_back(entity);

    if (entity->is_in_group("Player")) {
        player = entity;
    }
}

void GEntityAdmin::unregisterEntity(Node *entity) {
    entities.erase(std::remove(entities.begin(), entities.end(), entity), entities.end());
}

void GEntityAdmin::registerPlayer(Node *newPlayer) {
    player = newPlayer;
}

Node *GEntityAdmin::getPlayer() {
    return player;
}

void GEntityAdmin::_ready() {}

void GEntityAdmin::_process(double delta) {}

void GEntityAdmin::_physics_process(double delta) {}
