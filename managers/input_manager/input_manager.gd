extends Node

func _process(delta: float) -> void:
	move_player()
	move_camera()
	action_bark()


func move_player() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
	GameEvents.emit_move_player(direction)


func move_camera() -> void:
	var direction: float = Input.get_axis("left_camera", "right_camera")
	GameEvents.emit_move_camera(direction)


func action_bark() -> void:
	if Input.is_action_pressed("bark"):
		GameEvents.emit_action_bark()
