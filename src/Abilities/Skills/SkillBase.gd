extends Area2D

var target_group: = "enemies"

var single_use: = true

var on_hit_ability: = false

var damage: = 50

# Signal Variables
var delay := 0.00001
var duration := 0.00001

var spawn_effect_duration := 0.00001
var end_effect_duration := 0.00001

func _init() -> void:
	# Overwrite the initialize function in child class to overwrite class vars
	initialize()


func initialize() -> void:
	pass


func _on_body_entered(body: Node) -> void:
	if body.is_in_group(target_group):
		if on_hit_ability:
			use_ability()

		if single_use:
			end_effect()

		body.take_damage(damage)
	elif body.get_class() == "TileMap":
		if on_hit_ability:
			print("Using explosion")
			use_ability()
		end_effect()


func set_target_group(group_id: String) -> void:
	self.target_group = group_id


func end_effect() -> void:
	queue_free()

## Signals and functions to override in child classes

func spawn_effect() -> void:
	# You can initalize SpawnTween here
	pass

func use_ability() -> void:
	pass

func _on_DelayTimer_timeout() -> void:
	pass # Replace with function body.


func _on_DurationTimer_timeout() -> void:
	pass # Replace with function body.


func _on_Spawn_tween_all_completed() -> void:
	pass # Replace with function body.


func _on_Despawn_tween_all_completed() -> void:
	pass # Replace with function body.
