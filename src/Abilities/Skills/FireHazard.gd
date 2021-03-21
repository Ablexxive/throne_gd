extends "res://src/Abilities/Skills/SkillBase.gd"

func initialize() -> void:
	self.delay = 0.1
	self.end_effect_duration = 1.0
	self.duration = 10.0

func _ready() -> void:
	$DurationTimer.start(self.duration)
	# TODO: You prob don't need to do this if it's just being spawned from a trap.
#	var re_align = Vector2(self.global_position.x + 1.0, self.global_position.y)
#	self.look_at(re_align)

func end_effect() -> void:
	var tween = get_node("Despawn")
	tween.interpolate_property($Sprite, "scale",
		Vector2(1.0, 1.0), Vector2(0.0, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Sprite, "modulate",
		Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.0), end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _on_DurationTimer_timeout() -> void:
	end_effect()

func _on_Despawn_tween_all_completed() -> void:
	queue_free()

