extends Node2D
@onready var timer = $Timer

var enemy_scene = preload("res://scenes/enemy_plane1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	print("Timeout")
	timer.stop()
	var enemy = enemy_scene.instantiate()
	enemy.position.x = randi_range(196, 956)
	enemy.position.y = -90
	add_child(enemy)
	timer.start(randi_range(1, 5))
