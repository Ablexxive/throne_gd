extends KinematicBody2D

onready var nav_2d: Navigation2D = get_parent().get_node("Navigation2D")
#onready var line_2d: Line2D = $Line2D
var path: = PoolVector2Array() setget set_path

onready var anim_sprite: AnimatedSprite = $AnimatedSprite
export var stationary: = false
var health: = 100
var collision_damage: = 10

func _ready() -> void:
	anim_sprite.play()

var speed = 100.0
var movement_vector = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not stationary:
		var player = get_parent().get_node("Player")
		if player:
		# TODO: This is temporary motion, replace with better once you do pathfinding.
		# Smaller the divisor, the faster the enemy.
			#movement_vector = position.direction_to(player.position) * speed * delta
			#move_and_collide(movement_vector)
			var new_path: PoolVector2Array = nav_2d.get_simple_path(self.global_position, player.global_position)
			#line_2d.points = new_path
			path = new_path
			var move_distance: float = speed * delta
			move_along_path(move_distance)

func set_path(value: PoolVector2Array) -> void:
	path = value
	#if value.size() == 0:
	#	return
	
func move_along_path(distance: float) -> void:
	var start_point: = position
	for idx in range(self.path.size()):
		var distance_to_next: = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance/distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func hit(damage: int) -> void:
	# https://www.davidepesce.com/2019/11/25/godot-tutorial-11-attacks-damage-death/
	health -= damage
	if health <= 0:
		queue_free()
	else:
		$AnimationPlayer.play("hit_reaction")
		print("Hit for: ", damage)
		
func get_damage() -> int:
	return collision_damage


# Possible useful: 
#https://www.davidepesce.com/2019/11/25/godot-tutorial-11-attacks-damage-death/
