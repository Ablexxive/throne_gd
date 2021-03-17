extends "res://src/Abilities/Projectiles/ProjectileBase.gd"

export (PackedScene) var Explosion = load("res://src/Abilities/Explosion.tscn")

func initialize() -> void:
	speed = 300.0
	damage = 20.0
	on_hit_ability = true

func use_ability() -> void:
	# Spawn Flame
	var explosion = Explosion.instance()
	explosion.add_to_group("player_projectile")
	explosion.set_target_group("enemies")
	explosion.delay = 0.0
	explosion.duration = 0.0
	explosion.transform = self.global_transform

	get_tree().get_root().add_child(explosion)
