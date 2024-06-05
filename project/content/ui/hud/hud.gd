extends CanvasLayer

@onready var health_bar := $HealthBar
@onready var time_label := $TimeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to health_changed signal so we update our bar evertime the player's health changes.
	var health_component = GameGlobals.entity_admin.player.health_component
	health_component.connect("health_changed", update_health_bar)

	var level_component = GameGlobals.scene_admin.level_component
	level_component.connect("time_changed", update_time_label)

	update_health_bar()
	update_time_label()


func update_health_bar() -> void:
	health_bar.value = GameGlobals.entity_admin.player.stats_component.health
	health_bar.max_value = GameGlobals.entity_admin.player.stats_component.max_health

func update_time_label() -> void:
	time_label.text = GameGlobals.scene_admin.level_component.get_time_string(GameGlobals.scene_admin.level_component.time_elapsed)
