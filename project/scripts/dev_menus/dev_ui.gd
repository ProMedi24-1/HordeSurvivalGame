extends Node

var OverviewMenu := DevOverview.new()

func _process(_delta: float) -> void:
    OverviewMenu.draw_window()

func _ready() -> void:
    set_process_input(true)
    OverviewMenu.show_window = false

func _input(event: InputEvent) -> void:
    if event is InputEventKey and event.pressed:
        if event.keycode == KEY_F1:
            OverviewMenu.toggle_visibility()
            print_rich("[color=DODGER_BLUE]Toggle Dev-Menus[/color]")