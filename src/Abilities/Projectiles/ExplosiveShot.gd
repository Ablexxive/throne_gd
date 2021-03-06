extends "res://src/Abilities/Projectiles/ProjectileBase.gd"

export (PackedScene) var Explosion = load("res://src/Abilities/Skills/Explosion.tscn")

func initialize() -> void:
	self.speed = 300.0
	self.damage = 20.0
	self.cost = 10.0
	self.on_hit_ability = true

func use_ability() -> void:
	# Spawn Flame
	var explosion = Explosion.instance()
	explosion.add_to_group("player_projectile")
	explosion.set_target_group("enemies")
	explosion.transform = self.global_transform

	get_tree().get_root().add_child(explosion)
