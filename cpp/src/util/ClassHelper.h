#pragma once

#include <godot_cpp/classes/node.hpp>
#include <util/Common.h>

#define BIND_METHOD(CLASS, METHOD_NAME, ...) \
        bindMethod(#METHOD_NAME, &CLASS::METHOD_NAME, ##__VA_ARGS__);

#define BIND_STATIC_METHOD(CLASS, METHOD_NAME, ...) \
        bindStaticMethod(#CLASS, #METHOD_NAME, CLASS::METHOD_NAME, ##__VA_ARGS__);

#define BIND_PROPERTY(VAR_NAME, SET_NAME, GET_NAME) \
        ADD_PROPERTY(PropertyInfo(get_variant<decltype(VAR_NAME)>(), #VAR_NAME), #SET_NAME, #GET_NAME);

#define BIND_PROPERTY_ENUM(VAR_NAME, SET_NAME, GET_NAME, VALUES) \
        ADD_PROPERTY(PropertyInfo(Variant::INT, #VAR_NAME, PROPERTY_HINT_ENUM, VALUES), #SET_NAME, #GET_NAME);

using namespace godot;


template<typename F, typename... Args>
    void bindMethod(const StringName &name, F p_function, Args... args) {
        ClassDB::bind_method(D_METHOD(name, args...), p_function);
    }

template<typename F, typename... Args>
    void bindStaticMethod(const StringName &className, const StringName &name, F p_function, Args... args) {
        ClassDB::bind_static_method(className, D_METHOD(name, args...), p_function);
    }

template<typename G, typename S>
    void bind_property(const StringName &setName, const StringName &getName, G getter, S setter) {
        bindMethod(setName, setter, "value");
        bindMethod(getName, getter);
    }

inline void disableEditorProcess(Node *node) {
    if (Engine::get_singleton()->is_editor_hint()) {
        node->set_process_mode(Node::ProcessMode::PROCESS_MODE_DISABLED);
    }
}

inline bool isEditor() {
    return Engine::get_singleton()->is_editor_hint();
}


template<typename T>
Variant::Type get_variant() {
    return Variant::Type::NIL;
}

template<>
inline Variant::Type get_variant<int>() {
    return Variant::Type::INT;
}

template<>
inline Variant::Type get_variant<float>() {
    return Variant::Type::FLOAT;
}

template<>
inline Variant::Type get_variant<bool>() {
    return Variant::Type::BOOL;
}

