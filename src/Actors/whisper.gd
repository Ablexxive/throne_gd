extends KinematicBody2D

onready var anim_sprite: AnimatedSprite = $AnimatedSprite

# What if we put the bullet on the weapon? That way we could swap it out there? I dunno.
export (PackedScene) var Bullet

# TODO- move to PlayerData.gd file to put player data together
var velocity: = Vector2.ZERO
export var speed: = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_sprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var direction: = get_direction()
	velocity = speed * direction
	velocity = move_and_slide(velocity, Vector2.ZERO)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	#if Input.get_connected_joypads():
	#	var aim_direction = get_aim_direction()
		# https://godotforums.org/discussion/24477/aim-with-the-right-stick
	#	var rotation = atan2(aim_direction.y, aim_direction.x)
	#	bullet.rotate(rotation)
	#else:
		#bullet.look_at(get_global_mouse_position())
	var enemy = get_closest_enemy()
	if enemy:
		var bullet = Bullet.instance()
		owner.add_child(bullet)
		bullet.transform = self.global_transform
		bullet.look_at(enemy.global_position)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

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

func _on_attack_timer_timeout() -> void:
	shoot()
