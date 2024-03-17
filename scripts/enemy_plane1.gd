extends CharacterBody2D


func _physics_process(delta):
	if position.y-100 < get_viewport_rect().size.y:
		position.y += 5
	else:
		print("freed")
		queue_free()
