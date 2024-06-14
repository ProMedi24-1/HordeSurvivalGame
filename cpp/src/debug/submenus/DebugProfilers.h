#pragma once

#include <vector>
#include <util/Common.h>
#include <numeric>

using namespace godot;

template<typename T>
struct profilerBuffer {
    u32 size;
    std::vector<T> buffer;

    profilerBuffer(u32 size) : size(size), buffer(size, 0) {}

    void addData(T data) {
        if (buffer.size() >= size) {
            buffer.erase(buffer.begin());
        }
        buffer.push_back(data);
    }

    T getAverage() {
        return std::accumulate(buffer.begin(), buffer.end(), 0) / buffer.size();
    }
};


void showFrameWindow(bool *p_open);

void showMemoryWindow(bool *p_open);

void showLoggerWindow(bool *p_open);
