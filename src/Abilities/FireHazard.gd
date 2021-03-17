extends "res://src/Abilities/GroundSpike.gd"

var end_effect_duration := 0.4

func end_effect() -> void:
	var tween = get_node("Tween")
	tween.interpolate_property($Sprite, "scale",
		Vector2(1.0, 1.0), Vector2(0.0, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Sprite, "modulate",
		Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	queue_free()
