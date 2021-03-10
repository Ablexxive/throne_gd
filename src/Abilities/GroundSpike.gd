extends "res://src/Abilities/AbilityBase.gd"

func _ready() -> void:
	set_target_group("player")
	single_use(false)
