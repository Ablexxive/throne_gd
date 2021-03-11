extends Node2D

# Duration is the time of warning before attack spawn
var duration := 0.5
# How long the warning circle should stick around after the attack has happened.
var over_duration := 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Use AnimationPlayer to tweak animations and also for non-dynamic anims
	#$AnimationPlayer.play("Spawn")

	# Use Tween for dyanmic animations
	var tween = get_node("Tween")
	tween.interpolate_property($Sprite, "scale",
		Vector2(0.35, 0.35), Vector2(1, 1), duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Sprite, "modulate",
	  Color(1, 1, 1, 0.2), Color(1, 1, 1, 0.55), duration,
	  Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	$OverDurationTimer.start(over_duration)


func _on_OverDurationTimer_timeout() -> void:
	queue_free()
