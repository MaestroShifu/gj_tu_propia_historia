extends CharacterBody3D
class_name Player

@export var speed : float = 14
@export var bark_radius : float = 8

@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var input_direction: Vector2 = Vector2.ZERO
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	GameEvents.move_player.connect(move_player)
	GameEvents.action_bark.connect(on_action_bark)


func _physics_process(_delta: float) -> void:
	var world_direction := camera.global_transform.basis.x * input_direction.x
	var character_fordward := Vector3.UP.cross(camera.global_transform.basis.x)
	world_direction += character_fordward * input_direction.y

	var new_velocity = world_direction * speed
	new_velocity.y -= gravity

	set_velocity(new_velocity)
	move_and_slide()


func move_player(in_input_direction: Vector2) -> void:
	input_direction = in_input_direction


func on_action_bark():
	audio_stream_player.play()

	var child_pos : Vector3 = %Child.position
	var delta_pos := child_pos - self.position
	var delta_distance := delta_pos.length()
	if delta_distance > bark_radius:
		return

	%Child.update_target_position(self.position)

