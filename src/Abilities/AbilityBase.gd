extends Area2D

var damage: = 50
var single_use: = true

var target_group: = "enemies"

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(target_group):
		body.take_damage(damage)
		if single_use:
			end_effect()
	elif body.get_class() == "TileMap":
		end_effect()

func set_target_group(group_id: String) -> void:
	self.target_group = group_id

func single_use(value: bool) -> void:
	self.single_use = value

func end_effect() -> void:
	queue_free()
