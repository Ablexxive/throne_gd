extends Area2D

var speed: = 350.0
export var damage: = 20

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node) -> void:
	queue_free()
	if body.is_in_group("enemies"):
		body.hit(damage)
