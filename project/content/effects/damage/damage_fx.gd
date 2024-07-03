extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("finished", delete)
	self.emitting = true
	
func delete() -> void:
	#print(finished)
	self.queue_free()
