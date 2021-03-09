extends Node2D

export (PackedScene) var EnemyScene
export (PackedScene) var EnemyScene2
export (PackedScene) var PlayerScene

onready var spawn_points: = get_tree().get_nodes_in_group("spawn_points")


func _process(_delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.empty() || len(enemies) < 5:
		var new_enemy = null
		if randi() % 2 == 0:
			new_enemy = EnemyScene.instance()
		else:
			new_enemy = EnemyScene2.instance()
		add_child(new_enemy)
		# Set owner has to happen after a thing has been added to the scene!
		new_enemy.set_owner(get_tree().get_root())

		var spawn_point = spawn_points[randi() % spawn_points.size()]
		new_enemy.transform = spawn_point.global_transform

	var player = get_tree().get_nodes_in_group("player")
	if player.empty():
		var new_player = PlayerScene.instance()
		add_child(new_player)
		new_player.set_owner(get_tree().get_root())
		new_player.transform = self.global_transform
