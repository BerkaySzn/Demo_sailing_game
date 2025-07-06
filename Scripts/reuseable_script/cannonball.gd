extends Area2D

var speed = 300.0
var direction = Vector2.ZERO

func set_direction(dir: Vector2):
	direction = dir

func _physics_process(delta):
	position += direction * speed * delta
