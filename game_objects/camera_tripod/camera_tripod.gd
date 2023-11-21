extends Node3D

class_name CamaraTripod


var direction_tripod_camera: float = 0.0
@export var speed_camera_movement: float = 4.0

func _ready() -> void:
	if not has_node("Camera"):
		printerr("There is no camera inside the node")
		return
	GameEvents.move_camera.connect(move_camera)

func _process(delta: float) -> void:
	var speed_camera: float = direction_tripod_camera * speed_camera_movement
	var calculated_rotation = rotation_degrees.y + speed_camera * delta
	rotation_degrees.y = calculated_rotation

func move_camera(value: float) -> void:
	direction_tripod_camera = value
