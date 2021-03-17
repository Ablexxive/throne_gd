extends "res://src/Abilities/GroundSpike.gd"

var spawn_effect_duration := 0.3
var end_effect_duration := 0.3

func _ready() -> void:
	$DelayTimer.start(delay)
	$Sprite.visible = true
	#$CollisionPolygon2D.disabled = false
	spawn_effect()

func spawn_effect() -> void:
	var spawn_tween = get_node("SpawnTween")
	spawn_tween.interpolate_property($Sprite, "scale",
		Vector2(0.0, 0.0), Vector2(2.0, 2.0), spawn_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	spawn_tween.interpolate_property($CollisionPolygon2D, "scale",
		Vector2(0.0, 0.0), Vector2(2.0, 2.0), spawn_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	spawn_tween.interpolate_property($Sprite, "modulate",
		Color(1, 1, 1, 0.0), Color(1, 1, 1, 1.0), spawn_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	spawn_tween.start()

func end_effect() -> void:
	print("end effect")
	var tween = get_node("Tween")
	tween.interpolate_property($Sprite, "scale",
		Vector2(1.0, 1.0), Vector2(0.0, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($CollisionPolygon2D, "scale",
		Vector2(1.0, 1.0), Vector2(0.0, 0.0), spawn_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Sprite, "modulate",
		Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	queue_free()

