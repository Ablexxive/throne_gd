extends "res://src/Actors/EnemyBase.gd"

export (PackedScene) var GroundSpike = load("res://src/Abilities/GroundSpike.tscn")
export (PackedScene) var WarningCircle = load("res://src/Abilities/WarningCircle.tscn")

var attack_warning_duration := 0.5

func _ready() -> void:
	self.health = 200
	self.SPEED = 80.0
	self.attack_distance = 280
	label.text = "%s" % health

func shoot() -> void:
	# create a signal that shoots out when the player node is updated (i.e. respawns)
	# so that we don't have to check it each time.
	player = get_parent().get_node("Player")
	if player:
		# Spawn Warning Circle at Player
		var warning_circle = WarningCircle.instance()
		warning_circle.duration = attack_warning_duration
		warning_circle.add_to_group("enemy_projectile")
		owner.add_child(warning_circle)
		# If we want the warning_circle to stay relative muzzle direction (i.e. for
		# a beam of magic), do `add_child(b)` instead to add it to self.
		warning_circle.transform = player.global_transform

		# Spawn Attack at player
		var ground_spike = GroundSpike.instance()
		ground_spike.delay = attack_warning_duration
		ground_spike.add_to_group("enemy_projectile")
		ground_spike.set_target_group("player")
		owner.add_child(ground_spike)
		# If we want the ground_spike to stay relative muzzle direction (i.e. for
		# a beam of magic), do `add_child(b)` instead to add it to self.
		ground_spike.transform = player.global_transform

		# Restart attack timer.
		self.attack_timer.start(2.0)
		can_shoot = false
