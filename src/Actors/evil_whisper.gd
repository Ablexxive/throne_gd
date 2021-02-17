extends KinematicBody2D

onready var anim_sprite: AnimatedSprite = $AnimatedSprite

func _ready() -> void:
	anim_sprite.play()
