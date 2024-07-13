class_name Upgrades



class Upgrade:
    var name: String
    var description: String
    var icon_texture: Texture2D
    var cost: Pair

    var level: int

    var upgrade_func: Callable




static func upgrade_mov_speed() -> void:
    var player := GEntityAdmin.player
    player.mov_speed += 10

static func upgrade_attack_speed() -> void:
    var player := GEntityAdmin.player
    player.attack_speed += 10

#static func upgrade_dodge_chance() -> void:
    #var player := GEntityAdmin.player
    #player.dodge_chance += 0.03
