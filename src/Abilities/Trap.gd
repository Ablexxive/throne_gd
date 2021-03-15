extends "res://src/Abilities/AbilityBase.gd"
# TODO: instead of loading the hazard here, have it just be a string reference so that
# we can change it on creation of trap to different types.
export (PackedScene) var FireHazard = load("res://src/Abilities/FireHazard.tscn")

func _on_Node2D_body_entered(body: Node) -> void:
	if body.is_in_group(target_group):
		# Spawn Flame
		var flame = FireHazard.instance()
		flame.add_to_group("player_projectile")
		flame.set_target_group("enemies")
		flame.delay = 0.1
		flame.duration = 10.0
		flame.transform = self.global_transform
		get_tree().get_root().add_child(flame)

		if single_use:
			queue_free()
