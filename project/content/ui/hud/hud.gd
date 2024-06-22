extends CanvasLayer

@export
var healthBar: ProgressBar
@export
var healthLabel: Label

@export
var timeLabel: Label
@export
var killLabel: Label

@export
var crystalLabel: Label

@export
var levelBar: ProgressBar
@export
var levelLabel: Label

# We just update the HUD every frame, as it's not that heavy.
# Removes the need to use signals.
func _process(_delta: float) -> void:
	if GEntityAdmin.player:
		updateHealthBar()
		updateHealthLabel()
		updateCrystalLabel()
		updateLevelBar()
		updateLevelLabel()
		updateKillLabel()

	if GSceneAdmin.levelBase:
		updateTimeLabel()

func updateHealthBar() -> void:
	healthBar.value = GEntityAdmin.player.health
	healthBar.max_value = GEntityAdmin.player.maxHealth

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
