extends CanvasLayer

@export var health_label: Label
@export var heart_box: HBoxContainer

@export var time_label: Label
@export var kill_label: Label
@export var wave_label: Label

@export var crystal_label: Label
@export var level_bar: TextureProgressBar
@export var level_label: Label

@export var ingredients_box: VBoxContainer

func _ready() -> void:
	var clear_ingredient_children := func() -> void:
		for i in ingredients_box.get_children():
			i.queue_free()

	clear_ingredient_children.call()

# We just update the HUD every frame, as it's not that heavy.
# Removes the need to use signals.
func _process(_delta: float) -> void:
	if GEntityAdmin.player:
		update_health_label()
		update_heart_box()
		update_crystal_label()
		update_level_bar()
		update_level_label()
		update_kill_label()
		update_ingredients_box()

	if GSceneAdmin.level_base:
		update_time_label()
		update_wave_label()


func update_heart_box() -> void:
	var children := heart_box.get_children()

	const HEART_NORMAL := preload("res://assets/ui/hud/heart.png")
	const HEART_EMPTY := preload("res://assets/ui/hud/heart_empty.png")

	var change_heart_count := func() -> void:
		for i in children:
			i.queue_free()

		for i in range(0, GEntityAdmin.player.max_health):
			var icon := TextureRect.new()
			icon.texture = HEART_NORMAL
			icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
			heart_box.add_child(icon)

	var update_heart_visuals := func() -> void:
		if children.size() != GEntityAdmin.player.max_health:
			return

		for i in range(0, GEntityAdmin.player.max_health):
			if i < GEntityAdmin.player.health:
				children[i].texture = HEART_NORMAL
			else:
				#children[i].modulate = Color(0.0, 0.0, 0.0, 1.0)
				children[i].texture = HEART_EMPTY

	if children.size() != GEntityAdmin.player.max_health:
		change_heart_count.call()

	update_heart_visuals.call()


func update_kill_label() -> void:
	kill_label.text = str(GEntityAdmin.player.kills)


func update_health_label() -> void:
	health_label.text = "%d/%d" % [GEntityAdmin.player.health, GEntityAdmin.player.max_health]


func update_time_label() -> void:
	time_label.text = GSceneAdmin.level_base.get_time_string()


func update_crystal_label() -> void:
	crystal_label.text = str(GEntityAdmin.player.crystals)


func update_level_bar() -> void:
	level_bar.value = GEntityAdmin.player.level_progress
	level_bar.max_value = GEntityAdmin.player.level_required


func update_level_label() -> void:
	level_label.text = "[LVL] %d" % GEntityAdmin.player.level

func update_wave_label() -> void:
	wave_label.text = "WAVE %d" % WaveSpawner.current_wave

func update_ingredients_box() -> void:
	var children := ingredients_box.get_children()


	if children.is_empty():
		for i in range(1, Ingredient.IngredientType.size() - 1):
			var ig_container := preload("res://content/ui/hud/ingredient_container.tscn").instantiate()
			ig_container.set_icon(Ingredient.ingredient_types[i].icon_texture)
			ingredients_box.add_child(ig_container)

	var update_labels := func() -> void:
		for i in children.size():
			#i.label.text = str(GEntityAdmin.player.ingredientInventory[i])
			children[i].set_label(str(GEntityAdmin.player.ingredient_inventory[i+1]))

	update_labels.call()
