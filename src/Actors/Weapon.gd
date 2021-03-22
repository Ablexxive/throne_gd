extends Node2D

onready var attack_timer: Timer = $AttackTimer
export (PackedScene) var Bullet = load("res://src/Abilities/Projectiles/AutoShot.tscn")

func shoot(current_location: Transform) -> bool:
	# https://godotforums.org/discussion/24477/aim-with-the-right-stick
	var enemy_and_distance = owner.get_closest_enemy()
	var enemy = enemy_and_distance.front()
	var distance = enemy_and_distance.back()
	if enemy:
		if distance <= owner.attack_dist:
			var bullet = Bullet.instance()
			bullet.initialize()
			#bullet.add_to_group("player_projectile")
			bullet.transform = current_location
			bullet.look_at(enemy.global_position)
			get_tree().get_root().add_child(bullet)

			# Restart attack timer.
			attack_timer.start(0.8)
			return true
	return false
