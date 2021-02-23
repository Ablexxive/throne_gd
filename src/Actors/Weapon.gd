extends Node2D

export (PackedScene) var Bullet

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = self.global_transform
