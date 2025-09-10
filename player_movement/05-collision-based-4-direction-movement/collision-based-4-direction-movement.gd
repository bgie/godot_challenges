extends CharacterBody2D

const SPEED = 300

func _process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

	var coordinates := position
	$"../CanvasLayer/CoordinatesLabel".text = "X: %.1f\nY: %.1f" % [coordinates.x, coordinates.y]
