extends CanvasLayer


@export
var healthLabel: Label
@export
var heartBox: HBoxContainer

@export
var timeLabel: Label
@export
var killLabel: Label

@export
var crystalLabel: Label

@export
var levelBar: TextureProgressBar
@export
var levelLabel: Label

@export
var ingredientsBox: VBoxContainer

func _ready() -> void:
	var clearIngredientChildren := func() -> void:
		for i in ingredientsBox.get_children():
			i.queue_free()

	clearIngredientChildren.call()

# We just update the HUD every frame, as it's not that heavy.
# Removes the need to use signals.
func _process(_delta: float) -> void:
	if GEntityAdmin.player:
		updateHealthLabel()
		updateHeartBox()
		updateCrystalLabel()
		updateLevelBar()
		updateLevelLabel()
		updateKillLabel()
		updateIngredientsBox()

	if GSceneAdmin.levelBase:
		updateTimeLabel()


func updateHeartBox() -> void:
	var children := heartBox.get_children()
	
	var changeHeartCount := func() -> void:
		for i in children:
			i.queue_free()

		for i in range(0, GEntityAdmin.player.maxHealth):
			var icon := TextureRect.new()
			icon.texture = preload("res://assets/ui/hud/heart.png")
			icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
			heartBox.add_child(icon)

	var updateHeartVisuals := func() -> void:
		if children.size() != GEntityAdmin.player.maxHealth:
			return

		for i in range(0, GEntityAdmin.player.maxHealth):
			if i < GEntityAdmin.player.health:
				children[i].modulate = Color(1.0, 1.0, 1.0, 1.0)
			else: 
				children[i].modulate = Color(0.0, 0.0, 0.0, 1.0)

	if children.size() != GEntityAdmin.player.maxHealth:
		changeHeartCount.call()

	updateHeartVisuals.call()

func updateKillLabel() -> void:
	killLabel.text = str(GEntityAdmin.player.kills)

func updateHealthLabel() -> void:
	healthLabel.text = "%d/%d" % [GEntityAdmin.player.health, GEntityAdmin.player.maxHealth]

func updateTimeLabel() -> void:
	timeLabel.text = GSceneAdmin.levelBase.getTimeString()

func updateCrystalLabel() -> void:
	crystalLabel.text = str(GEntityAdmin.player.crystals)

func updateLevelBar() -> void:
	levelBar.value = GEntityAdmin.player.levelProgress
	levelBar.max_value = GEntityAdmin.player.levelRequired

func updateLevelLabel() -> void:
	levelLabel.text = "[LVL] %d" % GEntityAdmin.player.level

func updateIngredientsBox() -> void:
	var children := ingredientsBox.get_children()

	
	if children.is_empty():
		for i in Ingredient.ingredientTypes.keys().size():
			var igContainer := preload("res://content/ui/hud/ingredient_container.tscn").instantiate()
			igContainer.setIcon(Ingredient.ingredientTypes[i].iconTexture) 
			ingredientsBox.add_child(igContainer)

	var updateLabels := func() -> void:
		for i in children.size():
			#i.label.text = str(GEntityAdmin.player.ingredientInventory[i])
			children[i].setLabel(str(GEntityAdmin.player.ingredientInventory[i]))

	updateLabels.call()
