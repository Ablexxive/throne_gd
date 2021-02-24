extends KinematicBody2D

onready var anim_sprite: AnimatedSprite = $AnimatedSprite
export var stationary: = false
var health: = 100
var collision_damage: = 10

func _ready() -> void:
	anim_sprite.play()

var speed = 150
var movement_vector = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not stationary:
		var player = get_parent().get_node("Player")
		if player:
		# TODO: This is temporary motion, replace with better once you do pathfinding.
		# Smaller the divisor, the faster the enemy.
			#var movement_vector = (player.position - position)/40
			#look_at(player.position)
			movement_vector = position.direction_to(player.position) * speed * delta
			move_and_collide(movement_vector)
		#move(movement_vector)
	
	#move_and_collide(motion)
	#print(motion)
	#print(tmp)
	#get_angle_to(player.position)
		#position += (player.position - position)/50

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
