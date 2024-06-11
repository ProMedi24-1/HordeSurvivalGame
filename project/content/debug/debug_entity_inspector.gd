class_name DebugEntityInspector
extends DebugUiBase

var window_init: bool = false

var selected_item := [null]
var selected_item2 := [null]

var spawn_pos_x := [0.0]
var spawn_pos_y := [0.0]
var spawn_pos: Vector2 = Vector2.ZERO

func _init() -> void:
	super("EntityInspector", false)

func draw_contents(_p_show: Array = [true]) -> void:
	if not window_init:
		window_init = true
		ImGui.SetNextWindowPos(Vector2(700, 100))
		ImGui.SetNextWindowSize(Vector2(300, 200))
	
	ImGui.Begin("Entity Inspector", _p_show, ImGui.WindowFlags_NoSavedSettings)

	ImGui.SeparatorText("Entities")

	ImGui.SetNextItemWidth(0)
	ImGui.ListBox("##entity_list", selected_item, EntityAdmin.entities.duplicate(), EntityAdmin.entities.size())

	if ImGui.Button("Delete Entity"):
		if not selected_item.is_empty() and EntityAdmin.entities.size() > 0:
			GameGlobals.entity_admin.delete_entity(EntityAdmin.entities[selected_item[0]])

	ImGui.SeparatorText("Spawner")
	ImGui.SetNextItemWidth(0)
	ImGui.ListBox("##spawn_list", selected_item2, EntityAdmin.entity_map.keys(), EntityAdmin.entity_map.size())

	ImGui.Text("Spawn Position")
	if ImGui.DragFloat("X", spawn_pos_x):
		spawn_pos.x = spawn_pos_x[0]
	if ImGui.DragFloat("Y", spawn_pos_y):
		spawn_pos.y = spawn_pos_y[0]

	if ImGui.Button("Spawn Entity"):
		#if not selected_item2.is_empty() and EntityAdmin.entity_map.size() > 0:
			#GameGlobals.entity_admin.spawn_entity_at(EntityAdmin.entity_map.get(selected_item2[0]), spawn_pos[0])
		GameGlobals.entity_admin.spawn_entity_at(EntityAdmin.entity_map.keys()[selected_item2[0]], spawn_pos)
			
	ImGui.End() 
