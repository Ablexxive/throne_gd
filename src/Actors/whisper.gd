extends KinematicBody2D

onready var anim_sprite: AnimatedSprite = $AnimatedSprite
# TODO- move to PlayerData.gd file to put player data together
var velocity: = Vector2.ZERO
export var speed: = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_sprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var direction: = get_direction()
	velocity = speed * direction
	velocity = move_and_slide(velocity, Vector2.ZERO)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
