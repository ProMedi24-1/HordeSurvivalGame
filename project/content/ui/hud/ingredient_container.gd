class_name IngredientContainer extends HBoxContainer

#var iconTexture: Texture2D
#var labelText: String

@export var iconTex: TextureRect 
@export var label: Label

func _ready() -> void:
	pass # Replace with function body.

func setLabel(text: String) -> void:
	label.text = text

func setIcon(texture) -> void:
	#var tex = Ingredient.ingredientTypes[0]
	#print(tex.iconTexture)
	#icon.texture = #tex.iconTexture 
	#iconTex.texture = preload("res://assets/pickup/ingredient/fungus.png")
	iconTex.texture = texture
