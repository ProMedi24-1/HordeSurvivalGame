extends Node2D


var Bullet = load("res://scenes/bullet.tscn")
var shoot_timer = 0
var shoot_cooldown = 0.5
var shoot_timer2 = 0
var shoot_cooldown2 = 1.7
var shoot_timer3 = 0
var shoot_cooldown3 = 0.2
var angle = 0
const DEG2RAD = PI / 180.0
var base_damage = 5

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if self.player == null:
		self.player = get_parent()
		
	# ATTACKS
	#self.base_attack(delta)
	#self.base_attack2(delta)
	self.base_attack3(delta)

func base_attack(delta):
	self.shoot_timer += delta
	if self.shoot_timer >= self.shoot_cooldown:
		self.shoot_timer -= self.shoot_cooldown
		
		
		var b = Bullet.instantiate()
		get_tree().get_current_scene().add_child(b)
		b.transform = self.global_transform
		
		var velocity = Vector2(cos(self.angle), sin(self.angle))
		
		# Apply force to move the bullet
		b.apply_central_impulse(velocity * 500) 
		b.damage = self.base_damage
		self.angle += 1
		
func base_attack2(delta):
	self.shoot_timer2 += delta
	if self.shoot_timer2 >= self.shoot_cooldown2:
		self.shoot_timer2 -= self.shoot_cooldown2
		
		
		var b = Bullet.instantiate()
		var b2 = Bullet.instantiate()
		var b3 = Bullet.instantiate()
		owner.add_child(b)
		owner.add_child(b2)
		owner.add_child(b3)
		
		b.transform = self.global_transform
		b2.transform = self.global_transform
		b3.transform = self.global_transform
		
		var velocity = self.move_direction
		
		# Apply force to move the bullet
		var cos = cos(20 * DEG2RAD)
		var sin = sin(20 * DEG2RAD)

		var vel1 = Vector2(velocity.x*cos, velocity.y*sin).normalized()
		var vel3 = Vector2(velocity.x*sin, velocity.y*cos).normalized()
		b.apply_central_impulse(vel1 * 500) 
		b2.apply_central_impulse(velocity * 500) 
		b3.apply_central_impulse(vel3 * 500) 
		b.damage = self.base_damage
		b2.damage = self.base_damage
		b3.damage = self.base_damage
		
func base_attack3(delta):
	self.shoot_timer3 += delta
	if self.shoot_timer3 >= self.shoot_cooldown3:
		self.shoot_timer3 -= self.shoot_cooldown3
		
		# detect nearest enemy within certain range
		var closest_enemy = null
		var closest_distance = 9999999
		for enemy in self.player.get_node("AttackRange").get_overlapping_bodies():
			var distance = self.global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = enemy
				
		# only shoot when there is at least one enemy within attack range
		if closest_enemy != null:
			var b = Bullet.instantiate()
			get_tree().get_current_scene().add_child(b)
			b.transform = self.global_transform
			var direction = self.global_position.direction_to(closest_enemy.global_position)
			b.apply_central_impulse(direction * 500) 
			b.damage = self.base_damage
