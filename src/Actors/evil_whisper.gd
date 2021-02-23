extends KinematicBody2D

onready var anim_sprite: AnimatedSprite = $AnimatedSprite
export var stationary: bool = false

func _ready() -> void:
	anim_sprite.play()

func _physics_process(delta: float) -> void:
	if not stationary:
		var player = get_parent().get_node("Player")
		# TODO: This is temporary motion, replace with better once you do pathfinding.
		# Smaller the divisor, the faster the enemy.
		var movement_vector = (player.position - position)/40
		look_at(player.position)
		move_and_collide(movement_vector)
	
	#move_and_collide(motion)
	#print(motion)
	#print(tmp)
	#get_angle_to(player.position)
		#position += (player.position - position)/50
