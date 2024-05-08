extends ColorRect

var player = null
var attackRangeCollisionBox = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.player = get_node("/root/World/Charakter")
	for child in self.player.get_children():
		if child.name == "AttackRange":
			attackRangeCollisionBox = child.get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func _on_talent_1_pressed():
	attackRangeCollisionBox.shape.radius *= 1.1
	self.visible = false
	get_tree().paused = false

func _on_talent_2_pressed():
	self.player.get_node("WeaponLogic").shoot_cooldown3 *= 0.9
	self.visible = false
	get_tree().paused = false

func _on_talent_3_pressed():
	self.player.get_node("WeaponLogic").base_damage *= 1.1
	self.visible = false
	get_tree().paused = false
	
	
### TALENT IDEAS:
## PERMANENT
# running speed
# attack range
# attack speed
# attack base damage
#
## ONE-TIME EFFECT
# big aoe around character
# big heal
# score points
