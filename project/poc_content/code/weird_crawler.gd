extends RigidBody2D

var player = null

var move_speed = 60

var hp = 10

var collision_dmg = 10

# can only change direction every new run
var running_timer = 3 # directly trigger direction calculation at start
var running_time = 3

var direction = null

# Called when the node enters the scene tree for the first time.
func _ready():
    self.player = get_node("/root/World/Charakter")
    self.body_entered.connect(_on_body_entered)
    self.set_contact_monitor(true)
    self.set_max_contacts_reported(11)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    self.running_timer += delta
    if self.running_timer >= running_time:
        self.running_timer -= running_time
        # only runs aligned with x or y axis (where the distance is larger to player)
        if (abs(self.player.global_position.x - self.global_position.x)) > abs(self.player.global_position.y - self.global_position.y):
            self.direction = self.global_position.direction_to(Vector2(self.player.global_position.x, self.global_position.y))
        else:
            self.direction = self.global_position.direction_to(Vector2(self.global_position.x, self.player.global_position.y))
    move_and_collide(self.direction * self.move_speed * delta)
    

func get_collision_dmg():
    return self.collision_dmg

func _on_body_entered(body):
    #if body.name == "Charakter":
    #	self.hp -= 100 # dmg from player collision and bullet collision
    #	self.player.get_damage(10)
    if "Bullet" in body.name: # Bullet1, Bullet2, Bullet3 ...
        self.hp -= body.damage
        body.queue_free() # destroy bullet after this collision
        
    if self.hp <= 0:
        self.queue_free() # destroy this zombie
        self.player.add_score(10)
    
func get_damage(dmg):
    self.hp -= dmg
