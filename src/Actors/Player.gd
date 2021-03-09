extends KinematicBody2D

onready var anim_sprite: AnimatedSprite = $AnimatedSprite
onready var attack_timer: Timer = $Weapon/AttackTimer

onready var label: Label = $Label
onready var score_label: Label = $Score

# What if we put the bullet on the weapon? That way we could swap it out there? I dunno.
export (PackedScene) var Bullet = load("res://src/Actors/Bullet.tscn")

# TODO- move to PlayerData.gd file to put player data together
var velocity: = Vector2.ZERO
export var speed: = 250.0
var hp: = 500
var moving: = false

var can_shoot: = false
var stop_shooting: = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	if Input.is_action_just_pressed("shoot") && can_shoot:
		shoot()

	if velocity == Vector2.ZERO && can_shoot && not stop_shooting:
		shoot()

func _on_attack_timer_timeout() -> void:
	can_shoot = true

func _on_HitBox_body_entered(body: Node) -> void:
	#if body.is_in_group("enemies"):
		#var damage = body.get_damage()
		#self._was_hit(damage)
	pass

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

func get_closest_enemy() -> Node:
	# https://godotengine.org/qa/48297/detecting-enemy-location-for-use-in-homing-missiles
	var enemies = get_tree().get_nodes_in_group('enemies')
	if enemies.empty(): return null

	var closest_enemy = null
	var distance = INF

	for enemy in enemies:
		var new_distance = self.global_position.distance_to(enemy.global_position)
		if new_distance < distance:
			distance = new_distance
			closest_enemy = enemy

	return closest_enemy

func hit(damage: int) -> void:
	self._was_hit(damage)

func _was_hit(damage: int) -> void:
	hp -= damage
	label.text = "%s" % hp
	if hp <= 0:
		queue_free()
		PlayerData.deaths += 1
	else:
		$AnimationPlayer.play("hit_reaction")

func shoot():
	# https://godotforums.org/discussion/24477/aim-with-the-right-stick
	var enemy = get_closest_enemy()
	if enemy:
		var bullet = Bullet.instance()
		bullet.add_to_group("player_projectile")
		#bullet.set_collision_mask_bit(2, 4)
		owner.add_child(bullet)
		# If we want the bullet to stay relative muzzle direction (i.e. for
		# a beam of magic), do `add_child(b)` instead to add it to self.
		bullet.transform = self.global_transform
		bullet.look_at(enemy.global_position)

		# Restart attack timer.
		self.attack_timer.start(0.6)
		can_shoot = false
