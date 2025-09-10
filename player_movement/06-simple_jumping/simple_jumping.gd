extends Sprite2D

var velocity := 0.0

const GRAVITY := 1000.0
const JUMP_FORCE := 600

func _process(delta: float) -> void:
	velocity += GRAVITY * delta
	
	var is_on_floor := (position.y >= 460)
	
	if is_on_floor and Input.is_action_just_pressed("ui_accept"):
		velocity -= JUMP_FORCE

	position.y += velocity * delta
	
	if position.y > 460:
		position.y = 460
		velocity = 0

	$"../CanvasLayer/CoordinatesLabel".text = "Position Y: %.1f\nVelocity Y: %.1f" % [position.y, velocity]
