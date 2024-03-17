extends Area2D

func _physics_process(delta):
	if position.y > 0:
		position.y -= 20
	else:
		queue_free()

func _on_body_entered(body):
	body.hp-=25
	if body.hp == 0: 
		body.animating()
	queue_free()
