extends CharacterBody2D

@export var speed = 600 #speed of tank
@export var gameOver = false
@onready var explosion = $AnimatedSprite2D

var hp = 100
const MaxHP = 100
var health = MaxHP

signal player_dead()

func _ready():
	set_healthLabel()
	set_healthBar()
	
func animating():
	emit_signal("player_dead")
	gameOver = true
	$HealthBar.hide()
	$HealthLabel.hide()
	await get_tree().create_timer(1).timeout
	speed = 0
	emit_signal("playerDead")
	queue_free()

func set_healthLabel():
	if $HealthLabel:
		$HealthLabel.text = "Health: %s" % str(health)
	else:
		print("Error: HealthLabel node not found.")

func set_healthBar():
	if $HealthBar:
		$HealthBar.value = health
	else:
		print("Error: HealthBar node not found.")

func damage():
	health -= 25
	if health <= 0:
		health = MaxHP
		explosion.play()
		animating()
	
	set_healthLabel()
	set_healthBar()

func _on_area_2d_body_entered(body):
	hp -= 25
	print("Body entered:", body)
	print("Player HP: ", hp)
	damage()
	body.queue_free()
	
func _physics_process(delta):
	if position.y >= 980:
		health -= 110
		damage()
		
	if !gameOver:
		var direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).normalized()

		# Disable movement upwards if player Y is below 700
		if position.y < 700:
			direction.y = max(0, direction.y)
		elif position.y > 935:
			direction.y = min(0, direction.y)
			
		if gameOver:
			direction.x = max(0,direction.x)
			direction.y = max(0,direction.y)

		# Apply movement
		velocity = direction * speed
		move_and_slide()
	else:
		# Stop accepting keyboard input
		self.set_process_input(false)
