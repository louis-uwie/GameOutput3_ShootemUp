extends CharacterBody2D

@onready var explosion = $AnimatedSprite2D2
var hp = 50

func _physics_process(delta):
	if position.y-100 < get_viewport_rect().size.y:
		position.y += 5
	else:
		queue_free()

func animating():
	explosion.play()
	await get_tree().create_timer(0.5).timeout
	queue_free()
