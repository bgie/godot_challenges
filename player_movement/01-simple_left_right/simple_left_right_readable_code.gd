extends Sprite2D

func _process(delta: float) -> void:
	position.x += Input.get_axis("ui_left", "ui_right") * 300 * delta

	var coordinates := position
	$"../CanvasLayer/CoordinatesLabel".text = "X: %.1f" % [coordinates.x]
