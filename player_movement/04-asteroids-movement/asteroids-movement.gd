extends Sprite2D

var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	rotation += Input.get_axis("ui_left", "ui_right") * 2 * delta
	
	velocity += Vector2.from_angle(rotation) * 3 * delta * Input.get_axis("ui_up", "ui_down")

	position += velocity

	var coordinates := position
	$"../CanvasLayer/CoordinatesLabel".text = "Position X: %.1f\nPosition Y: %.1f\nRotation: %.1f\nVelocity X: %.1f\nVelocity Y: %.1f" % [coordinates.x, coordinates.y, rotation_degrees, velocity.x, velocity.y]
