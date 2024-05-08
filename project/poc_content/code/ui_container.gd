extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    pass
    
func display_talents():
    %TalentBox.visible = true
    get_tree().paused = true
