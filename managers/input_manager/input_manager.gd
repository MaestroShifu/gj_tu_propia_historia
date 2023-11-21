extends Node

func _process(delta: float) -> void:
	move_player()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_camera"):
		GameEvents.emit_move_camera(-1)
	if event.is_action_pressed("right_camera"):
		GameEvents.emit_move_camera(1)
		
		# Input.get_axis("left_camera", "right_camera")

func move_player() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
	GameEvents.emit_move_player(direction)
