extends ProgressBar

var player = null
var player_hp = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.player = get_node("/root/World/Charakter")
	self.player_hp = player.hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self.player.hp != self.player_hp:
		self.player_hp = self.player.hp
		
		#self.set_size(Vector2(self.player_hp*4, get_size().y))
		self.value = (player_hp)
