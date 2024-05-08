extends RigidBody2D

var destroy_timer = 0
var destroy_time = 30
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Bullet"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.destroy_timer += delta
	if self.destroy_timer >= self.destroy_time:
		queue_free() # destroy this bullet
