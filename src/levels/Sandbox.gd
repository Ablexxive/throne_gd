extends Node2D

export (PackedScene) var EnemyScene

func _process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group('enemies')
	if enemies.empty() || len(enemies) < 3:
		var new_enemy = EnemyScene.instance()
		add_child(new_enemy)
		new_enemy.transform = self.global_transform
