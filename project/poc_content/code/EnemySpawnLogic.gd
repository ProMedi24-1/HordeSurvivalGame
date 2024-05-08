extends Node


var Zombie = load("res://scenes/zombie.tscn")
var WeirdCrawler = load("res://scenes/weird_crawler.tscn")

var spawn_timer = 0
var spawn_cooldown = 5

var rng = RandomNumberGenerator.new()
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# SPAWN NEW MOBS
	self.spawn(delta)

func spawn(delta):
	if player == null:
		player = get_parent()
	
	self.spawn_timer += delta
	if self.spawn_timer >= self.spawn_cooldown:
		self.spawn_timer -= self.spawn_cooldown
		
		var spawn_patterns = [self.spawn_pattern_1, self.spawn_pattern_2]
		var pattern_idx = self.rng.randi_range(0, len(spawn_patterns)-1)
		var enemy_types = [self.Zombie, self.WeirdCrawler]
		var enemy_type_idx = self.rng.randi_range(0, len(enemy_types)-1)
		spawn_patterns[pattern_idx].call(enemy_types[enemy_type_idx])
		#self.spawn_pattern_1()
		
		
func spawn_pattern_1(enemy_type):
	var amount = int(self.player.hp / 10)
	for i in range(amount):
		var z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(500-i*100,500))
		self.player.owner.add_child(z)
		z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(500-i*100,-500))
		self.player.owner.add_child(z)
		z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(500,500-i*100))
		self.player.owner.add_child(z)
		z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(-500,500-i*100))
		self.player.owner.add_child(z)
			
func spawn_pattern_2(enemy_type):
	var amount = int(self.player.hp / 10)
	for i in range(amount):
		var z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(500-i*100,500))
		self.player.owner.add_child(z)
		z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(500-i*100,-500))
		self.player.owner.add_child(z)
		z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(550-i*100,600))
		self.player.owner.add_child(z)
		z = enemy_type.instantiate()
		z.transform = Transform2D(Vector2(1,0), Vector2(0,1), self.global_transform.origin + Vector2(550-i*100,-600))
		self.player.owner.add_child(z)
