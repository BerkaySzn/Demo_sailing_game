extends CharacterBody2D

@onready var cannon_point_left = $CannonPointLeft
@onready var cannon_point_right = $CannonPointRight

var max_moving_speed = 100.0
var rotation_speed = 1.0
var direction := Vector2.ZERO
var acceleration = 100.0
var target_velocity = direction
var cannonball_scene = preload("res://Scenes/reuseables_scene/cannonball.tscn")

var input_state := {
	"rotate_clockwise": false,
	"rotate_c_clockwise": false,
	"move_forward": false,
	"move_backward": false,
	"shoot_left": false,
	"shoot_right": false,
}

func get_input_state() -> void:
	input_state["rotate_c_clockwise"] = Input.is_action_pressed("rotate_c_clockwise")
	input_state["rotate_clockwise"] = Input.is_action_pressed("rotate_clockwise")
	input_state["move_forward"] = Input.is_action_pressed("move_forward")
	input_state["move_backward"] = Input.is_action_pressed("move_backward")
	input_state["shoot_left"] = Input.is_action_just_pressed("shoot_left")
	input_state["shoot_right"] = Input.is_action_just_pressed("shoot_right")

func _ready() -> void:
	print("Cannonball direction: ", direction)

func _physics_process(delta: float):
	get_input_state()
	get_input(delta)
	target_velocity = direction
	velocity = velocity.move_toward(target_velocity, acceleration * delta)
	move_and_slide()

func get_input(delta: float):
	direction = Vector2.ZERO
	# Rotation
	if input_state["rotate_c_clockwise"]:
		rotation -= rotation_speed * delta
		if !input_state["rotate_clockwise"] && !input_state["move_backward"]:
			direction += Vector2.RIGHT.rotated(rotation) * 50.0
	if input_state["rotate_clockwise"]:
		rotation += rotation_speed * delta
		if !input_state["rotate_c_clockwise"] && !input_state["move_backward"]:
			direction += Vector2.RIGHT.rotated(rotation) * 50.0


	#Movement
	if input_state["move_forward"]:
		direction += Vector2.RIGHT.rotated(rotation) * max_moving_speed
	if input_state["move_backward"]:
		direction -= Vector2.RIGHT.rotated(rotation) * max_moving_speed / 5
		
	#shoot
	if input_state["shoot_left"]:
		var cannonball = cannonball_scene.instantiate()
		cannonball.position = cannon_point_left.global_position
		cannonball.set_direction = (Vector2.RIGHT.rotated(rotation - PI / 2))
		get_tree().current_scene.add_child(cannonball)

	if input_state["shoot_right"]:
		var cannonball = cannonball_scene.instantiate()
		cannonball.position = cannon_point_right.global_position
		cannonball.set_direction = (Vector2.RIGHT.rotated(rotation + PI / 2))
		get_tree().current_scene.add_child(cannonball)
