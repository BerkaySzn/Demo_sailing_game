extends Area2D



var speed = 300.0
var direction = Vector2.ZERO

func _ready():
	direction = Vector2.RIGHT  # test movement to the right


func _physics_process(delta):
	position += direction * speed * delta
