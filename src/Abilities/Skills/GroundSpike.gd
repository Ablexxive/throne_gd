extends "res://src/Abilities/Skills/SkillBase.gd"

func initialize() -> void:
	delay = 1.0
	duration = 1.0
	single_use = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DelayTimer.start(self.delay)
	$Sprite.visible = false
	$CollisionPolygon2D.disabled = true

func _on_DelayTimer_timeout() -> void:
	$DurationTimer.start(duration)
	$Sprite.visible = true
	$CollisionPolygon2D.disabled = false

func _on_DurationTimer_timeout() -> void:
	end_effect()
