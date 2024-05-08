extends RichTextLabel


var player = null
var player_score = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.player = get_node("/root/World/Charakter")
	self.player_score = player.hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self.player.score != self.player_score:
		self.player_score = self.player.score
	
		self.text = "Score: " + str(self.player_score)
