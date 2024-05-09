extends Control

func _ready() -> void:
    pass
    
func start_game() -> void:
    GameRoot.change_game_state(GameRoot.GameState.PLAYING, "TestLevel")
    
func _on_play_button_pressed() -> void:
    start_game()
    print_rich("[color=YELLOW]Starting new Run[/color]")

func _on_settings_button_pressed() -> void:
    print_rich("[color=YELLOW]Opening Settings[/color]")

func _on_credits_button_pressed() -> void:
    print_rich("[color=YELLOW]Viewing Credits[/color]")

func _on_quit_button_pressed() -> void:
    print_rich("[color=YELLOW]Quitting Game[/color]")
    get_tree().quit()
