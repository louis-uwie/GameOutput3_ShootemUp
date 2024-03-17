extends Area2D

@onready var explosion = $AnimatedSprite2D2
var speed = 20
var hit = false

func _physics_process(delta):
	if position.y-50 < get_viewport_rect().size.y:
		position.y += 5
	else:
		queue_free()
	
	if hit:
		animating()

func animating():
	speed = 0
	explosion.play()
	await get_tree().create_timer(0.2).timeout
	queue_free()

func _on_body_entered(body):
	body.hp-=5
	body.damage(5)
	hit = true
	$Shell_Icon.visible = false
	
	
