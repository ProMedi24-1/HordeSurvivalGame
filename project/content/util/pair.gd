class_name Pair

var first
var second

func _init(_first, _second):
    self.first = _first
    self.second = _second

func get_first():
    return self.first

func get_second():
    return self.second

func swap():
    var temp = self.first
    self.first = self.second
    self.second = temp
