extends "res://src/Abilities/AbilityBase.gd"
# TODO: instead of loading the hazard here, have it just be a string reference so that
# we can change it on creation of trap to different types.
export (PackedScene) var FireHazard = load("res://src/Abilities/Skills/FireHazard.tscn")

func _on_Node2D_body_entered(body: Node) -> void:
	if body.is_in_group(target_group):
		# Spawn Flame
		var flame = FireHazard.instance()
		flame.add_to_group("player_projectile")
		flame.set_target_group("enemies")
#		flame.delay = 0.1
#		flame.duration = 10.0
		flame.transform = self.global_transform

		get_tree().get_root().add_child(flame)

		if single_use:
			# Use Tween for dyanmic animations
			var tween = get_node("Tween")
			tween.interpolate_property($Sprite, "modulate",
				Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.0), flame.delay,
				Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
	elif body.get_class() == "TileMap":
		queue_free()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	queue_free()
