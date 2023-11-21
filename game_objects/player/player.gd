extends CharacterBody3D

class_name Player

@export var speed = 14
@export var gravity: float = -1.0
var input_direction: Vector2 = Vector2.ZERO
@onready var camera: Camera3D = get_viewport().get_camera_3d()

func _ready() -> void:
	GameEvents.move_player.connect(move_player)

func _physics_process(_delta: float) -> void:
	var world_direction := Vector3.ZERO
	
	world_direction += camera.global_transform.basis.x * input_direction.x
	var character_fordward := Vector3.UP.cross(camera.global_transform.basis.x)
	world_direction += character_fordward * input_direction.y

	velocity = world_direction * speed
	
	velocity.y += gravity

	move_and_slide()

func move_player(in_input_direction: Vector2) -> void:
	input_direction = in_input_direction
