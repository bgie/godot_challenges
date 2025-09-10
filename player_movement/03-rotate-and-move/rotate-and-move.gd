extends Sprite2D

func _process(delta: float) -> void:
	rotation += Input.get_axis("ui_left", "ui_right") * 3 * delta
	
	if Input.is_action_pressed("ui_up"):
		position += Vector2.from_angle(rotation) * 200 * delta

	var coordinates := position
	$"../CanvasLayer/CoordinatesLabel".text = "X: %.1f\nY: %.1f\nRotation: %.1f" % [coordinates.x, coordinates.y, rotation_degrees]
