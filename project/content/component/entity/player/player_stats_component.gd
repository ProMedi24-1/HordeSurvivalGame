class_name PlayerStatsComponent
extends StatsComponent

# Other variables like health are already inherited from default StatsComponent.
@export var mana_crystals: int = 0

@export var can_overheal: bool = false ## Whether the entity can overheal over the max health.

var kills: int  = 0 

#TODO Implement ingredients
enum IngredientType{
    SPIDER_EYE,
    BAT_WING,
}

