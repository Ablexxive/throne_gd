extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Use AnimationPlayer to tweak animations and also for non-dynamic anims
	#$AnimationPlayer.play("Spawn")

	# Use Tween for dyanmic animations
	var tween = get_node("Tween")
	tween.interpolate_property($Sprite, "scale",
		Vector2(0.75, 0.75), Vector2(1, 1), 0.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Sprite, "modulate",
	  Color(1, 1, 1, 0.45), Color(1, 1, 1, 0.65), 0.3,
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func set_target_group(group_id: String) -> void:
	pass
