extends Node3D

class_name CamaraTripod

@export var rotation_amount: float = 90

func _ready() -> void:
	if not has_node("Camera"):
		printerr("There is no camera inside the node")
		return
	GameEvents.move_camera.connect(move_camera)

func move_camera(value: int) -> void:
	var rotation_y = rotation.y + (value * 90)
	
	if rotation_y >= 360:
		rotation.y = 0
	if rotation_y <= 0:
		rotation.y = 360

	rotation.y = rotation_y
	print(rotation.y)
