extends Node2D

export (PackedScene) var EnemyScene
export (PackedScene) var PlayerScene

func _process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.empty() || len(enemies) < 3:
		var new_enemy = EnemyScene.instance()

		add_child(new_enemy)
		# Set owner has to happen after a thing has been added to the scene!
		new_enemy.set_owner(get_tree().get_root())
		new_enemy.transform = self.global_transform

	var player = get_tree().get_nodes_in_group("player")
	if player.empty():
		var new_player = PlayerScene.instance()
		add_child(new_player)
		new_player.set_owner(get_tree().get_root())
		new_player.transform = self.global_transform
