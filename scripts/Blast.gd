extends Area2D

func _physics_process(delta):
	if position.y-50 < get_viewport_rect().size.y:
		position.y += 5
	else:
		queue_free()

func _on_body_entered(body):
	body.hp-=5
	print("Player Hp: ", body.hp)
	queue_free()
