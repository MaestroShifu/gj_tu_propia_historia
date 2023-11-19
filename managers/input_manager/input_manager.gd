extends Node

func _physics_process(delta: float) -> void:
	move_player()
	
func move_player() -> void:
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	
	if direction.length_squared() > 0:
		direction.normalized()

	GameEvents.emit_move_player(direction)
