extends CanvasLayer

@onready var health_bar := $HealthBar
@onready var time_label := $TimeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to health_changed signal so we update our bar evertime the player's health changes.
	
	var health_component = GEntityAdmin.getPlayer().health
	health_component.connect("health_changed", update_health_bar)

	var level_component = GSceneAdmin.getLevelComponent()
	level_component.connect("time_changed", update_time_label)

	update_health_bar()
	update_time_label()


func update_health_bar() -> void:
	health_bar.value = GEntityAdmin.getPlayer().stats.health
	health_bar.max_value = GEntityAdmin.getPlayer().stats.max_health

func update_time_label() -> void:
	time_label.text = GSceneAdmin.getLevelComponent().get_time_string(GSceneAdmin.getLevelComponent().time_elapsed)
