extends CharacterBody2D

@onready var explosion = $AnimatedSprite2D2

var hp = 200
var can_shoot = true

func _ready():
	position.y = -100

func _physics_process(delta):
	if position.y-100 < 50:
		position.y += 5

func animating():
	explosion.play()
	await get_tree().create_timer(0.5).timeout
	queue_free()
