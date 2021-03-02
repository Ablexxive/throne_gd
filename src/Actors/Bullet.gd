extends Area2D

var speed: = 350.0
var damage: = 20

var target_group: = "enemies"

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node) -> void:

	if body.is_in_group(target_group):
		body.hit(damage)
		queue_free()
	elif body.get_class() == "TileMap":
		queue_free()

func set_target_group(group_id: String) -> void:
	self.target_group = group_id
