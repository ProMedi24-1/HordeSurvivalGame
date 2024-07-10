extends GPUParticles2D


func _ready() -> void:
	self.emitting = true
	self.connect("finished", delete)


func delete() -> void:
	self.get_parent().queue_free()
