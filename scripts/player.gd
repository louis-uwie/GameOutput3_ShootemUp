extends CharacterBody2D

@export var speed = 600 #speed of tank
var hp = 100

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()

	# Disable movement upwards if player Y is below 700
	if position.y < 700:
		direction.y = max(0, direction.y)
	elif position.y > 935:
		direction.y = min(0, direction.y)

	# Apply movement
	velocity = direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	body.hp-=25
	hp -= 25
	print("Body entered:", body)
	print("Player HP: ", hp)
	#TODO: Add hp animation and explosion
	body.queue_free()
