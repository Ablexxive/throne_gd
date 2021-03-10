extends Area2D

var damage: = 50
var single_use: = true

var target_group: = "enemies"

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(target_group):
		body.take_damage(damage)
		if single_use:
			queue_free()
	elif body.get_class() == "TileMap":
		queue_free()

func set_target_group(group_id: String) -> void:
	self.target_group = group_id

func single_use(value: bool) -> void:
	self.single_use = value
