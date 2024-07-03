class_name EnemyBundles
# Class that registers enemy bundles for spawning...

enum EnemyType {
    BAT,
    FUNGUS,
    SPIDER,
}

const enemyBundles = {
    EnemyType.BAT: ["res://content/entity/enemy/bat/bat_ev1.tscn"],
    EnemyType.FUNGUS: ["res://content/entity/enemy/fungus/fungus_ev1.tscn"],
    EnemyType.SPIDER: ["res://content/entity/enemy/spider/spider_ev1.tscn"],
}

