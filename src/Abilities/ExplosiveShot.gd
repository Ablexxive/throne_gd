extends "res://src/Abilities/Projectiles/ProjectileBase.gd"
# TODO: instead of loading the hazard here, have it just be a string reference so that
# we can change it on creation of trap to different types.
export (PackedScene) var Explosion = load("res://src/Abilities/Explosion.tscn")

func initialize() -> void:
	speed = 300.0
	on_hit_ability = true

# func _physics_process(delta: float) -> void:
	# position += transform.x * speed * delta

# func _on_Node2D_body_entered(body: Node) -> void:
	# print("Node 2d Body Entered")
	# if body.is_in_group(target_group):
		# # Spawn Flame
		# var explosion = Explosion.instance()
		# explosion.add_to_group("player_projectile")
		# explosion.set_target_group("enemies")
		# explosion.delay = 0.0
		# explosion.duration = 0.0
		# explosion.transform = self.global_transform

		# get_tree().get_root().add_child(explosion)

		# # if single_use:
# #			# Use Tween for dyanmic animations
# #			var tween = get_node("Tween")
# #			tween.interpolate_property($Sprite, "modulate",
# #				Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.0), flame.delay,
# #				Tween.TRANS_LINEAR, Tween.EASE_IN)
# #			tween.start()
		# end_effect()
	# elif body.get_class() == "TileMap":
		# end_effect()

# func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	# end_effect()

func use_ability() -> void:
	# Spawn Flame
	var explosion = Explosion.instance()
	explosion.add_to_group("player_projectile")
	explosion.set_target_group("enemies")
	explosion.delay = 0.0
	explosion.duration = 0.0
	explosion.transform = self.global_transform

	get_tree().get_root().add_child(explosion)
