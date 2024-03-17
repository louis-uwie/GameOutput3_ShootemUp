extends CharacterBody2D

var hp = 50

func _physics_process(delta):
	if position.y-100 < get_viewport_rect().size.y:
		position.y += 10
	else:
		queue_free()

