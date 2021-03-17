extends Area2D

var target_group: = "enemies"

var damage: = 50
var speed: = 200.0

var on_hit_ability: = false


func _init() -> void:
	# Overwrite the initialize function in child class to overwrite class vars
	initialize()

func initialize() -> void:
	pass

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(target_group):
		if on_hit_ability:
			use_ability()
		else:
			body.take_damage(damage)
		end_effect()
	elif body.get_class() == "TileMap":
		end_effect()

func set_target_group(group_id: String) -> void:
	self.target_group = group_id

func end_effect() -> void:
	queue_free()

func use_ability() -> void:
	pass
