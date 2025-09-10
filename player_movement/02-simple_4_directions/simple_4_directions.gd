extends Sprite2D

const SPEED = 300

func _process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var velocity = direction * SPEED * delta
	position += velocity

	var coordinates := position
	$"../CanvasLayer/CoordinatesLabel".text = "X: %.1f\nY: %.1f" % [coordinates.x, coordinates.y]
