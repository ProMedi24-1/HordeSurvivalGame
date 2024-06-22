class_name Utils
extends Object

# Circular Buffer data type.
class CircBuffer:
    var buffer: Array
    var bufSize: int

    func _init(size: int):
        self.buffer = []
        self.bufSize = size

    func getBuffer() -> Array:
        return self.buffer

    func getSize() -> Variant:
        return self.buffer.size()

    func pushBack(element: Variant) -> void:
        self.buffer.push_back(element)
        if self.buffer.size() > self.bufSize:
            self.buffer.pop_front()

    func popFront() -> Variant:
        return self.buffer.pop_front()

    func empty() -> bool:
        return self.buffer.is_empty()

# Pair data type holding 2 values.
class Pair:
    var first
    var second

    func _init(t1: Variant, t2: Variant):
        self.first = t1
        self.second = t2

    func getFirst() -> Variant:
        return self.first

    func getSecond() -> Variant:
        return self.second

    func swap() -> void:
        var tmp = self.first
        self.first = self.second
        self.second = tmp

# Compute the sum of an array.
static func accumulate(arr: Array) -> Variant:
    var sum := 0
    for i in arr:
        sum += i
    return sum
