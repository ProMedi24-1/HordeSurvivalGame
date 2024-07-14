extends Control

@export var wave_label: Label
@export var continue_button: Button


@export var health_button: Button
@export var speed_button: Button
@export var dex_button: Button

@export var health_ing_label: Label
@export var speed_ing_label: Label
@export var dex_ing_label: Label

func _ready() -> void:
	wave_label.text = "Wave " + str(WaveSpawner.current_wave) + " ended!"
	continue_button.press_event = on_continue

	GStateAdmin.can_pause = false

	Sound.play_sfx(Sound.Fx.FINISH_WAVE, 2, 0.2)

	health_button.press_event = func(): Upgrades.heal_player()
	speed_button.press_event = func(): Upgrades.upgrade_mov_speed()
	dex_button.press_event = func(): Upgrades.upgrade_attack_speed()

	# Dim the audio
	Sound.music_player.volume_db -= 10


func on_continue() -> void:
	GStateAdmin.unpause_game()
	Sound.music_player.volume_db += 10
	WaveSpawner.wave_ref.start_wave()
	GStateAdmin.can_pause = true
	self.queue_free()


func _process(_delta: float) -> void:
	var inv = GEntityAdmin.player.ingredient_inventory
	health_ing_label.text = str(inv[Ingredient.IngredientType.BATWING]) + " / 10"
	speed_ing_label.text = str(inv[Ingredient.IngredientType.FUNGUS]) + " / 10"
	dex_ing_label.text = str(inv[Ingredient.IngredientType.RATTAIL]) + " / 10"
