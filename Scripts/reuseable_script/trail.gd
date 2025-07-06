extends Line2D

var previous_position: Vector2 = Vector2.ZERO
var ball_radius: float = 0.0

func _ready():
	var texture = get_parent().texture
	ball_radius = texture.get_size().x * 0.5
	previous_position = get_parent().global_position

func _process(delta: float) -> void:
	var current_position = get_parent().global_position
	var offset = current_position - previous_position

	if offset.length() > 0.1:
		var direction = offset.normalized()
		var trail_position = current_position - direction * ball_radius * 0.9
		add_point(trail_position)

		if points.size() > 40:
			remove_point(0)

		previous_position = current_position
