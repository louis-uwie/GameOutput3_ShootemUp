extends CharacterBody2D

@onready var explosion = $AnimatedSprite2D2
var hp = 25

func _physics_process(delta):
	if position.y-100 < get_viewport_rect().size.y:
		position.y += 5
	else:
		print("freed")

func animating():
	explosion.play()
	await get_tree().create_timer(0.5).timeout
	queue_free()
	
func _on_area_2d_body_entered(body):
	hp-=25
	if hp <= 0:
		animating()
	print("Plane HP: ", hp)
