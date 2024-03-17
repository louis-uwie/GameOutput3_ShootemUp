extends CharacterBody2D


@export var speed = 600
var rotation_speed = 1.0
var max_rotation = 45.0
var can_shoot = true
var bullet2d_scene = preload("res://Shell.tscn")

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	var rotation_radians = deg_to_rad(rotation_degrees)

	var rotated_direction = Vector2(
		direction.x * cos(rotation_radians) - direction.y * sin(rotation_radians),
		direction.x * sin(rotation_radians) + direction.y * cos(rotation_radians)
	)

	if Input.is_action_pressed("rotate_left"):
		rotation_degrees = clamp(rotation_degrees - rotation_speed * delta, -max_rotation, 0)
	elif Input.is_action_pressed("rotate_right"):
		rotation_degrees = clamp(rotation_degrees + rotation_speed * delta, 0, max_rotation)
	else:
		rotation_degrees = 0

	rotation = rotation_degrees
	velocity = rotated_direction * speed
	
	move_and_slide()

#TODO: PUT INPUT EVENT FOR SHELL IN MAIN SCENE, INSTEAD OF PLAYER SCENE.
func _input(event):
	if Input.is_action_pressed("ui_accept") and can_shoot:
		$Timer.start(1)
		
		can_shoot = false
		var bullet2d_instance = bullet2d_scene.instantiate()
		
		bullet2d_instance.position = position
		
		add_child(bullet2d_instance)
		print(position.x)
		print(position.y)
		print(bullet2d_instance.position.x)
		print(bullet2d_instance.position.y)
		print("shoot")

func _on_timer_timeout():
	can_shoot = true
	$Timer.stop()
