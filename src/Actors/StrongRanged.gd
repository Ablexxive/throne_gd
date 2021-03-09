extends "res://src/Actors/EnemyBase.gd"

func _ready() -> void:
	print("Updating self values.")
	self.health = 200
	self.speed = 80.0
	label.text = "%s" % health
