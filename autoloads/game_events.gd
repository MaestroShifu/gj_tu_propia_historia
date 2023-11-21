extends Node


signal move_player(direction: Vector2)
signal move_camera(value: float)

func emit_move_player(direction: Vector2) -> void:
	move_player.emit(direction)

func emit_move_camera(value: float) -> void:
	move_camera.emit(value)
