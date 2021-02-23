extends Area2D

var speed: = 350.0

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node) -> void:
	queue_free()
