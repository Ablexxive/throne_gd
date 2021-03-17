extends KinematicBody2D

# Components
onready var attack_timer: Timer = $Weapon/AttackTimer
onready var nav_2d: Navigation2D = get_parent().get_node("Navigation2D")
onready var label: Label = $Label
onready var anim_sprite: AnimatedSprite = $AnimatedSprite
onready var animation_player: AnimationPlayer = $AnimationPlayer

# Entity variables
export (PackedScene) var Bullet = load("res://src/Abilities/Projectiles/AutoShot.tscn")
export var stationary: = false

# Constants
var SPEED := 200.0
var PATH_TIMER_CD := 0.4

# Global Vars
var health: = 100
var attack_distance: = 130
var movement_vector = Vector2.ZERO
var can_shoot: = false
var player = null

# Pathfinding Global Vars
var follow_path: = PoolVector2Array()
var path_timer = PATH_TIMER_CD
var current_path_node = 0

func _ready() -> void:
	anim_sprite.play()
	label.text = "%s" % health
	if not attack_timer:
		print("Weapon attack timer not implemented.")
	if not animation_player:
		print("AnimationPlayer not implemented.")

func _physics_process(delta: float) -> void:
	if not stationary:
		# create a signal that shoots out when the player node is updated (i.e. respawns)
		# so that we don't have to check it each time.
		player = get_parent().get_node("Player")
		if player:
			path_timer -= delta
			if path_timer <= 0.0 or follow_path.size() == 0:
				refresh_path()
			elif current_path_node > follow_path.size() -1:
				# TODO Check if this is needed.
				return

			# warning-ignore:return_value_discarded
			move_and_slide(Vector2.ZERO)
			var distance_from_player = self.global_position.distance_to(player.global_position)

			if distance_from_player > attack_distance:
				var move_distance: float = SPEED * delta
				move_along_path(move_distance)
			else:
				if can_shoot:
					shoot()
					#pass

func _on_AttackTimer_timeout() -> void:
		can_shoot = true

func take_damage(damage: int) -> void:
	# https://www.davidepesce.com/2019/11/25/godot-tutorial-11-attacks-damage-death/
	health -= damage
	label.text = "%s" % health
	if health <= 0:
		queue_free()
		PlayerData.score += 10
	else:
		$AnimationPlayer.play("hit_reaction")

func shoot() -> void:
	# create a signal that shoots out when the player node is updated (i.e. respawns)
	# so that we don't have to check it each time.
	player = get_parent().get_node("Player")
	if player:
		var bullet = Bullet.instance()
		bullet.add_to_group("enemy_projectile")
		bullet.set_target_group("player")
		owner.add_child(bullet)
		# If we want the bullet to stay relative muzzle direction (i.e. for
		# a beam of magic), do `add_child(b)` instead to add it to self.
		bullet.transform = self.global_transform
		bullet.look_at(player.global_position)
		bullet.speed = 110.0

		# Restart attack timer.
		self.attack_timer.start(2.0)
		can_shoot = false

func refresh_path() -> void:
			path_timer = PATH_TIMER_CD
			# Path optimization set to 'false' so that entities don't get stuck on walls.
			follow_path = nav_2d.get_simple_path(self.global_position, player.global_position, false)
			current_path_node = 0

func move_along_path(distance: float) -> void:
	var start_point: = position
	for _idx in range(follow_path.size()):
		var distance_to_next: = start_point.distance_to(follow_path[current_path_node])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(follow_path[current_path_node], distance/distance_to_next)
			# Note this `move_and_slide` call here helps the entities from getting stuck to each other.
			# Can remove once we have more group movement behavior working.
			# warning-ignore:return_value_discarded
			move_and_slide(Vector2.ZERO)
			break
		elif distance < 0.0:
			position = follow_path[current_path_node]
			# Note this `move_and_slide` call here helps the entities from getting stuck to each other.
			# Can remove once we have more group movement behavior working.
			# warning-ignore:return_value_discarded
			move_and_slide(Vector2.ZERO)
		distance -= distance_to_next
		start_point = follow_path[current_path_node]
		if current_path_node < follow_path.size() - 1:
			current_path_node += 1
		else:
			refresh_path()
