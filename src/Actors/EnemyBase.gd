extends KinematicBody2D

# Components
onready var attack_timer: Timer = $Weapon/AttackTimer
onready var nav_2d: Navigation2D = get_parent().get_node("Navigation2D")
onready var label: Label = $Label
onready var anim_sprite: AnimatedSprite = $AnimatedSprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

# Entity variables
export (PackedScene) var Bullet = load("res://src/Actors/Bullet.tscn")
export var stationary: = false

var path: = PoolVector2Array() setget set_path
var health: = 100
var speed = 100.0
var movement_vector = Vector2.ZERO
var can_shoot: = false

func _ready() -> void:
	anim_sprite.play()
	label.text = "%s" % health
	if not attack_timer:
		print("Weapon attack timer not implemented.")
	if not animation_player:
		print("AnimationPlayer not implemented.")

func _physics_process(delta: float) -> void:
	if not stationary:
		var player = get_parent().get_node("Player")
		if player:
		# TODO: This is temporary motion, replace with better once you do pathfinding.
		# Smaller the divisor, the faster the enemy.
			#movement_vector = position.direction_to(player.position) * speed * delta
			#move_and_collide(movement_vector)
			var distance_from_player = self.global_position.distance_to(player.global_position)
			if distance_from_player > 150:
				var new_path: PoolVector2Array = nav_2d.get_simple_path(self.global_position, player.global_position)
				#line_2d.points = new_path
				path = new_path
				var move_distance: float = speed * delta
				move_along_path(move_distance)
			else:
				if can_shoot:
					shoot()

func _on_AttackTimer_timeout() -> void:
		can_shoot = true

func shoot() -> void:
	var player = get_parent().get_node("Player")
	if player:
		var bullet = Bullet.instance()
		bullet.add_to_group("enemy_projectile")
		bullet.set_target_group("player")
		owner.add_child(bullet)
		# If we want the bullet to stay relative muzzle direction (i.e. for
		# a beam of magic), do `add_child(b)` instead to add it to self.
		bullet.transform = self.global_transform
		bullet.look_at(player.global_position)

		# Restart attack timer.
		self.attack_timer.start(2.0)
		can_shoot = false

func set_path(value: PoolVector2Array) -> void:
	path = value
	#if value.size() == 0:
	#	return

func move_along_path(distance: float) -> void:
	var start_point: = position
	for _idx in range(self.path.size()):
		var distance_to_next: = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance/distance_to_next)
			## TODO: use move_and_collide instead of updating the position
			#var new_position = start_point.linear_interpolate(path[0], distance/distance_to_next)
			#move_and_collide(new_position)
			break
		elif distance < 0.0:
			position = path[0]
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func hit(damage: int) -> void:
	# https://www.davidepesce.com/2019/11/25/godot-tutorial-11-attacks-damage-death/
	health -= damage
	label.text = "%s" % health
	if health <= 0:
		queue_free()
		PlayerData.score += 10
	else:
		$AnimationPlayer.play("hit_reaction")
