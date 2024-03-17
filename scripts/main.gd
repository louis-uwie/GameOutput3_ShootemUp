extends Node2D
@onready var timer = $Timer
@onready var timer_2 = $Timer2
@onready var player = $Player

var can_shoot = true

var enemy_scene = preload("res://scenes/enemy_plane1.tscn")
var enemy_scene2 = preload("res://scenes/enemy_plane2.tscn")
var bullet_scene = preload("res://scenes/Shell.tscn")
var blast_scene = preload("res://scenes/Blast.tscn")

var enemy_green_planes = [null, null, null]
var enemy_x = [188, 576, 966]
var bullet_coords = [Vector2(-150, 69), Vector2(150, 69), Vector2(-95, 78), Vector2(95, 78)]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(1)
	for i in range(3):
		spawn_green_plane(i)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") and can_shoot:
		var bullet = bullet_scene.instantiate()
		bullet.position = player.position
		bullet.position.y -= 62
		add_child(bullet)
		timer_2.start(.25)
		can_shoot = false
	
	for i in range(3):
		if enemy_green_planes[i] == null:
			spawn_green_plane(i)
		else:
			if enemy_green_planes[i].position.y >= 50 and enemy_green_planes[i].can_shoot:
				enemy_green_planes[i].can_shoot = false
				start_shooting(i)
				await get_tree().create_timer(2).timeout
				enemy_green_planes[i].can_shoot = true
			

func _on_timer_timeout():
	timer.stop()
	var enemy = enemy_scene.instantiate()
	enemy.position.x = randi_range(196, 956)
	enemy.position.y = -90
	add_child(enemy)
	timer.start(randf_range(0.5, 1.0))

func _on_timer_2_timeout():
	can_shoot = true
	timer_2.stop()
	
func spawn_green_plane(i):
	var enemy = enemy_scene2.instantiate()
	enemy.position.x = enemy_x[i]
	enemy_green_planes[i] = enemy
	
	await get_tree().create_timer(randf_range(2,10)).timeout
	add_child(enemy)

func start_shooting(i):
	for j in range(4):
		var blast_bullet = blast_scene.instantiate()
		blast_bullet.position = enemy_green_planes[i].position + bullet_coords[j]
		add_child(blast_bullet)
		
