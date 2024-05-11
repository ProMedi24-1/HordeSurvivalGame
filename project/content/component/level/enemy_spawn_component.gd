extends ReferenceRect

@export var enemy_scene: PackedScene
@export var spawn_delay: float = 1.0  # Zeit in Sekunden zwischen den Spawns

var timer: Timer

func _ready() -> void:
    timer = Timer.new()
    timer.wait_time = spawn_delay
    timer.autostart = true
    timer.one_shot = false
    timer.connect("timeout", _on_timer_timeout)
    add_child(timer)

func _on_timer_timeout() -> void:
    spawn_enemy()

func spawn_enemy() -> void:
    var enemy = enemy_scene.instantiate()
    var x = randf_range(self.position.x, self.size.x + self.position.x)
    var y = randf_range(self.position.y, self.size.y + self.position.y)
    enemy.position = Vector2(x, y)
    add_child(enemy)
