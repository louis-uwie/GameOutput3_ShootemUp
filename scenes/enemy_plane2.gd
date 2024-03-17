extends CharacterBody2D

var hp = 200
var can_shoot = true

func _ready():
	position.y = -100

func _physics_process(delta):
	if position.y-100 < 50:
		position.y += 5

