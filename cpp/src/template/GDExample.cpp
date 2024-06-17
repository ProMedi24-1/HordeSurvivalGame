#include "GDExample.h"

using namespace godot;

void GDExample::_bind_methods() {
    ClassDB::bind_method(D_METHOD("get_amplitude"), &GDExample::get_amplitude);
}

GDExample::GDExample() { disableEditorProcess(this); }

GDExample::~GDExample() {}

double GDExample::get_amplitude() const {
	return amplitude;
}

void GDExample::_ready() {}

void GDExample::_process(double delta) {}

void GDExample::_physics_process(double delta) {}
