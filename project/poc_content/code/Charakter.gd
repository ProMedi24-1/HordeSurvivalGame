extends CharacterBody2D

var move_speed = 400
var move_direction = Vector2(1,1)

var hp = 100
var score = 0
var score_points_spent = 0
var hp_regen_per_second = 3


var rng = null
var ui = null

# Called when the node enters the scene tree for the first time.
func _ready():
    self.rng = RandomNumberGenerator.new()
    self.ui = get_node("/root/World/UI")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    self.regen(delta)
    self.move(delta)
    
    # HANDLE ENEMY COLLISIONS (currently same damage for every "Hurtbox"-collision (collision layer mask: 3 - enemy))
    self.collision_damage(delta)

    self.skill()
    
func skill():
    if self.score >= self.score_points_spent + 100:
        self.score_points_spent += 100
        self.ui.display_talents()
        
func regen(delta):
    self.hp += delta * self.hp_regen_per_second
    if self.hp > 100:
        self.hp = 100
    
func collision_damage(delta):
    var overlapping_mobs = %Hurtbox.get_overlapping_bodies()
    #var collision_dmg = 5 * overlapping_mobs.size()
    var collision_dmg = 0
    for mob in overlapping_mobs:
        collision_dmg += mob.get_collision_dmg()
    self.get_damage(delta * collision_dmg)
    

func move(delta):
    var move_direction = Vector2()
    move_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    move_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    move_direction = move_direction.normalized()
    if move_direction.x != 0 or move_direction.y != 0:
        self.move_direction = move_direction

    self.move_and_collide(move_direction * delta * self.move_speed)
    

func get_damage(dmg):
    self.hp -= dmg
    if self.hp <= 0:
        self.hp = 0
        get_tree().paused = true

func add_score(score):
    self.score += score
