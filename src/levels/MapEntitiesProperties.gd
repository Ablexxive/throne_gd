extends Node

export var enemy_stationary: bool
export var stop_player_shooting: bool


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
