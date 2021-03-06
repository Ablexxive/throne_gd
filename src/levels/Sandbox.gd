extends Node2D

export (PackedScene) var EnemyScene
export (PackedScene) var EnemyScene2
export (PackedScene) var PlayerScene

onready var spawn_points: = get_tree().get_nodes_in_group("spawn_points")
export var num_enemies := 5


func _process(_delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.empty() || len(enemies) < num_enemies:
		var new_enemy = null
		if randi() % 2 == 0:
			new_enemy = EnemyScene.instance()
		else:
			new_enemy = EnemyScene2.instance()

		var spawn_point = spawn_points[randi() % spawn_points.size()]
		new_enemy.transform = spawn_point.global_transform
		add_child(new_enemy)
		# Set owner has to happen after a thing has been added to the scene!
		new_enemy.set_owner(get_tree().get_root())

	var player = get_tree().get_nodes_in_group("player")
	if player.empty():
		var new_player = PlayerScene.instance()

		new_player.transform = self.global_transform
		add_child(new_player)
		new_player.set_owner(get_tree().get_root())
