extends "res://src/Abilities/Skills/SkillBase.gd"

export (PackedScene) var FireHazard = load("res://src/Abilities/Skills/FireHazard.tscn")


func initialize() -> void:
	self.end_effect_duration = 0.3
	self.damage = 0.0
	self.on_hit_ability = true


func use_ability() -> void:
	var flame = FireHazard.instance()
	flame.add_to_group("player_projectile")
	flame.set_target_group("enemies")
	flame.transform = self.global_transform
	get_tree().get_root().add_child(flame)
	end_effect()


func end_effect() -> void:
	var despawn_tween = get_node("Despawn")
	despawn_tween.interpolate_property($Sprite, "modulate",
		Color(1, 1, 1, 0.6), Color(1, 1, 1, 0.3), self.end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	despawn_tween.interpolate_property($Sprite, "scale",
		Color(1, 1, 1, 1.0), Color(1, 1, 1, 0.0), self.end_effect_duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	despawn_tween.start()


func _on_Despawn_tween_all_completed() -> void:
	queue_free()
