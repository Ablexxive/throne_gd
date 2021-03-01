extends Node

export var enemy_stationary: bool
export var stop_player_shooting: bool

func _ready() -> void:
	if enemy_stationary != null:
		var enemies = get_tree().get_nodes_in_group('enemies')
		for enemy in enemies:
			enemy.stationary = enemy_stationary
	print(stop_player_shooting)
	if stop_player_shooting != null:
		var players = get_tree().get_nodes_in_group('player')
		for player in players:
			print(stop_player_shooting)
			player.stop_shooting = stop_player_shooting
