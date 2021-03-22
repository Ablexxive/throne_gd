extends "res://src/Abilities/Skills/SkillBase.gd"

var anim_scale_factor := 1.5

func initialize() -> void:
	self.delay = 0.0001
	self.spawn_effect_duration = 0.5
	self.end_effect_duration = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_effect()

func spawn_effect() -> void:
	var spawn_tween = $Spawn
	spawn_tween.interpolate_property($Sprite, "scale",
		Vector2(0.0, 0.0), Vector2(anim_scale_factor, anim_scale_factor), spawn_effect_duration,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	spawn_tween.interpolate_property($CollisionPolygon2D, "scale",
		Vector2(0.0, 0.0), Vector2(anim_scale_factor, anim_scale_factor), spawn_effect_duration,
		Tween.TRANS_QUART, Tween.EASE_OUT)
	spawn_tween.interpolate_property($Sprite, "modulate",
		Color(1, 1, 1, 0.0), Color(1, 1, 1, 1.0), spawn_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	spawn_tween.start()


func _on_Spawn_tween_all_completed() -> void:
	var despawn_tween = $Despawn
	despawn_tween.interpolate_property($Sprite, "scale",
		Vector2(anim_scale_factor, anim_scale_factor), Vector2(0.0, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	despawn_tween.interpolate_property($CollisionPolygon2D, "scale",
		Vector2(anim_scale_factor, anim_scale_factor), Vector2(0.0, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	despawn_tween.interpolate_property($Sprite, "modulate",
		Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	despawn_tween.start()


func _on_Despawn_tween_all_completed() -> void:
	queue_free()

func end_effect() -> void:
	# We want the explosion to grow and shrink on it's own, so we make sure
	# to override the end_effect
	pass

