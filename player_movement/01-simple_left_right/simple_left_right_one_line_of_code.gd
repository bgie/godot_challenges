extends Sprite2D

const SPEED := 300

func _process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	var velocity = direction * SPEED * delta
	position.x += velocity
