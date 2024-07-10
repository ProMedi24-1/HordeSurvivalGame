class_name IngredientContainer extends HBoxContainer

#var iconTexture: Texture2D
#var labelText: String

@export var icon_tex: TextureRect
@export var label: Label

func _ready() -> void:
	pass # Replace with function body.

func set_label(text: String) -> void:
	label.text = text

func set_icon(texture) -> void:
	#var tex = Ingredient.ingredientTypes[0]
	#print(tex.iconTexture)
	#icon.texture = #tex.iconTexture
	#iconTex.texture = preload("res://assets/pickup/ingredient/fungus.png")
	icon_tex.texture = texture
