extends Area2D

@onready var explosion = $AnimatedSprite2D2
var speed = 20
var hit = false

func _physics_process(delta):
	if position.y > 0:
		position.y -= speed
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
	body.hp-=25
	if body.hp == 0: 
		body.animating()
	hit = true
	$Shell_Icon.visible = false
	
