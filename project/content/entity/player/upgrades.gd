class_name Upgrades



class Upgrade:
    var name: String
    var description: String
    var icon_texture: Texture2D
    var cost: Pair

    var level: int

    var upgrade_func: Callable



static func heal_player() -> void:
    var cost := Pair.new(Ingredient.IngredientType.BATWING, 10)
    if GEntityAdmin.player.ingredient_inventory[cost.first] < cost.second:
        return

    GEntityAdmin.player.ingredient_inventory[cost.first] -= cost.second

    var player := GEntityAdmin.player
    player.health = player.max_health

    Sound.play_sfx(Sound.Fx.BREWING_BOTTLE)

static func upgrade_mov_speed(free: bool = false) -> void:
    if not free:
        var cost := Pair.new(Ingredient.IngredientType.FUNGUS, 10)

        if GEntityAdmin.player.ingredient_inventory[cost.first] < cost.second:
            return

        GEntityAdmin.player.ingredient_inventory[cost.first] -= cost.second

    var player := GEntityAdmin.player
    #var amount := player.mov_speed * 1
    var amount = 480
    player.mov_speed += amount # 1% increase

    Sound.play_sfx(Sound.Fx.BREWING_BOTTLE)

static func upgrade_attack_speed(free: bool = false) -> void:
    if not free:
        var cost := Pair.new(Ingredient.IngredientType.RATTAIL, 10)

        if GEntityAdmin.player.ingredient_inventory[cost.first] < cost.second:
            return

        GEntityAdmin.player.ingredient_inventory[cost.first] -= cost.second

    var player := GEntityAdmin.player
    var amount := player.attack_speed * 0.1
    #var amount = 0.035
    player.attack_speed -= amount # 10% increase

    Sound.play_sfx(Sound.Fx.BREWING_BOTTLE)

#static func upgrade_dodge_chance() -> void:
    #var player := GEntityAdmin.player
    #player.dodge_chance += 0.03
