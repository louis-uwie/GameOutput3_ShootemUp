extends CharacterBody2D

@export var speed = 600 #speed of tank
var rotation_speed = 1.0  #rotate speed (buggy if too low or too high values)
var max_rotation = 45.0 #(also buggy if values are too high or low)

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()

	if Input.is_action_pressed("rotate_left"):
		rotation_degrees = clamp(rotation_degrees - rotation_speed * delta, -max_rotation, 0)
	elif Input.is_action_pressed("rotate_right"):
		rotation_degrees = clamp(rotation_degrees + rotation_speed * delta, 0, max_rotation)
	else:
		rotation_degrees = 0

	rotation = rotation_degrees

	var rotation_radians = deg_to_rad(rotation_degrees)

	var rotated_direction = Vector2(direction.x * cos(rotation_radians) - direction.y * sin(rotation_radians),
									direction.x * sin(rotation_radians) + direction.y * cos(rotation_radians))

	# Apply movement
	velocity = rotated_direction * speed
	move_and_slide()
