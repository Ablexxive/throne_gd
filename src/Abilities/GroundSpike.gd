extends "res://src/Abilities/AbilityBase.gd"

var delay := 1.0
var duration := 1.0

func _ready() -> void:
	set_target_group("player")
	single_use(false)
	$DelayTimer.start(delay)
	$Sprite.visible = false
	$CollisionPolygon2D.disabled = true


func _on_DelayTimer_timeout() -> void:
	$EffectTimer.start(duration)
	$Sprite.visible = true
	$CollisionPolygon2D.disabled = false


func _on_EffectTimer_timeout() -> void:
	queue_free()
