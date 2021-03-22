extends KinematicBody2D

onready var anim_sprite: AnimatedSprite = $AnimatedSprite
onready var auto_attack_timer: Timer = $AutoAttack/AttackTimer

onready var label: Label = $Label
onready var score_label: Label = $Score

export (PackedScene) var Trap = load("res://src/Abilities/Skills/Trap.tscn")
export (PackedScene) var ExplosiveShot = load("res://src/Abilities/Projectiles/ExplosiveShot.tscn")

# TODO- move to PlayerData.gd file to put player data together
var velocity: = Vector2.ZERO
export var speed: = 250.0
var hp: = 5500
var moving: = false

var weapon_on_cd: = false
var attack_dist: = 200.0
export var stop_shooting: = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# warning-ignore:return_value_discarded
	PlayerData.connect("score_updated", self, "update_score")

	anim_sprite.play()
	label.text = "%s" % hp
	score_label.text = "%s" % PlayerData.score

func update_score() -> void:
	score_label.text = "%s" % PlayerData.score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var direction: = get_direction()
	velocity = speed * direction
	velocity = move_and_slide(velocity, Vector2.ZERO)
	#label.text = "%s" % velocity

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot_explosive_shot()

	if velocity == Vector2.ZERO && not weapon_on_cd && not stop_shooting:
		weapon_on_cd = $AutoAttack.shoot(self.global_transform)

	if Input.is_action_just_pressed("skill_1"):
		spawn_trap()

func _on_attack_timer_timeout() -> void:
	weapon_on_cd = false

func get_direction() -> Vector2:
	var dir = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	) * 4.0
	return dir.clamped(1.0)

func get_aim_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("look_right") - Input.get_action_strength("look_left"),
		Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	)

func get_closest_enemy() -> Array:
	# https://godotengine.org/qa/48297/detecting-enemy-location-for-use-in-homing-missiles
	var enemies = get_tree().get_nodes_in_group('enemies')
	if enemies.empty(): return [null, INF]

	var closest_enemy = null
	var distance = INF

	for enemy in enemies:
		var new_distance = self.global_position.distance_to(enemy.global_position)
		if new_distance < distance:
			distance = new_distance
			closest_enemy = enemy
	return [closest_enemy, distance]

func take_damage(damage: int) -> void:
	hp -= damage
	label.text = "%s" % hp
	if hp <= 0:
		queue_free()
		PlayerData.deaths += 1
	else:
		$AnimationPlayer.play("hit_reaction")

func spawn_trap():
	var trap = Trap.instance()
	trap.add_to_group("player_projectile")
	trap.set_target_group("enemies")
	get_tree().get_root().add_child(trap)
	trap.transform = self.global_transform

func shoot_explosive_shot():
	var enemy_and_distance = get_closest_enemy()
	var enemy = enemy_and_distance.front()
	var distance = enemy_and_distance.back()
	if enemy:
		if distance <= attack_dist + 100.0:
			var explosive_shot = ExplosiveShot.instance()
			explosive_shot.add_to_group("player_projectile")
			explosive_shot.set_target_group("enemies")
			explosive_shot.transform = self.global_transform
			explosive_shot.look_at(enemy.global_position)
			get_tree().get_root().add_child(explosive_shot)
