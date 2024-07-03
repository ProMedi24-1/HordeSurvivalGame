class_name Ingredient


class IngredientBase:
    var name: String
    var iconTexture: Texture2D

    func _init(_name: String, _iconTexture: Texture2D) -> void:
        self.name = _name
        self.iconTexture = _iconTexture

enum IngredientType {
    BATWING,
    FUNGUS,
    SPIDEREYE,
}

static var ingredientTypes = {
    IngredientType.BATWING: IngredientBase.new(
        "Batwing", 
        preload("res://assets/pickup/ingredient/bat_wing.png"),
        ),

    IngredientType.FUNGUS: IngredientBase.new(
        "Fungus", 
        preload("res://assets/pickup/ingredient/fungus.png"),
        ),

}

static func addIngredientToPlayer(type: IngredientType) -> void:
    var player := GEntityAdmin.player

    if player == null:
        return

    player.ingredientInventory[type] += 1
    GLogger.log("Player: Added %s" % ingredientTypes[type].name)

    # match type:
    #     IngredientType.BATWING:
    #         player.ingredientInventory[]
    #     IngredientType.FUNGUS:
    #         player.addFungus()
    #     IngredientType.SPIDEREYE:
    #         player.addSpiderEye()
