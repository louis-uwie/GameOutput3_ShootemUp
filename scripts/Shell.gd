extends Area2D

func _physics_process(delta):
	if position.y > 0:
		position.y -= 2
	else:
		queue_free()
