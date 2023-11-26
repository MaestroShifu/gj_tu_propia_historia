extends Node

signal move_player(direction: Vector2)
signal move_camera(value: float)
signal action_bark()
signal take_item(item_name: ItemSpawn.EnumItemName)

func emit_move_player(direction: Vector2) -> void:
	move_player.emit(direction)


func emit_move_camera(value: float) -> void:
	move_camera.emit(value)


func emit_action_bark() -> void:
	action_bark.emit()


func emit_take_item(item_name: ItemSpawn.EnumItemName) -> void:
	take_item.emit(item_name)
