extends Node


signal move_player(direction: Vector3)

func emit_move_player(direction: Vector3) -> void:
	move_player.emit(direction)
