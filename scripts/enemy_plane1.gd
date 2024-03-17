extends CharacterBody2D

var hp = 25

func _physics_process(delta):
	if position.y-100 < get_viewport_rect().size.y:
		position.y += 5
	else:
		print("freed")
		queue_free()


func _on_area_2d_body_entered(body):
	hp-=25
	#TODO: Plane explode animation
	print("Plane HP: ", hp)
