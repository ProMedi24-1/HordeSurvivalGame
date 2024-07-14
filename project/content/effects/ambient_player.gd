extends AudioStreamPlayer2D

var looped: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if looped:
		#self.stream.looped = true
		self.connect("finished", self.play)




