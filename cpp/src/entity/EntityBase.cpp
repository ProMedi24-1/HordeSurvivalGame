#include "EntityBase.h"

#include <global/admins/GEntityAdmin.h>

void EntityBase::_bind_methods() {
    // Intentionally left blank.
}

EntityBase::EntityBase() = default;

EntityBase::~EntityBase() = default;

void EntityBase::_ready() {
    if (isEditor()) {
        return;
    }
    GEntityAdmin::registerEntity(this);
}

void EntityBase::_exit_tree() { GEntityAdmin::unregisterEntity(this); }

void EntityBase::_process(double delta) {
    // Intentionally left blank.
}

void EntityBase::_physics_process(double delta) {
    // Intentionally left blank.
}
