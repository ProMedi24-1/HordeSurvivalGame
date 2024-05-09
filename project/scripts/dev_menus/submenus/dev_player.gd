class_name DevPlayer
extends DevMenuBase


var player_speed := [100]

func _init() -> void:
    super("Player", Vector2(200, 200), Vector2(500, 50))

func draw_contents() -> void:
    ImGui.Text("Player Stats")
    ImGui.InputInt("Player Speed", player_speed)

    #ImGui.Text("Player Speed: %s" % )
