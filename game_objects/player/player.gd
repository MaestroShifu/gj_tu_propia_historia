extends CharacterBody3D
class_name Player

@export var speed : float = 14
@export var range_of_search: float = 5

@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var particle_signal: SignalVFX = %Vfx_dog_signal
@onready var dog_mesh: Node3D = $Doggo

var input_direction: Vector2 = Vector2.ZERO
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
var min_item_distance: float


func _ready() -> void:
	GameEvents.move_player.connect(move_player)
	GameEvents.action_bark.connect(on_action_bark)


func _process(_delta: float) -> void:
	calculate_distance_to_item()


func _physics_process(_delta: float) -> void:
	var world_direction := camera.global_transform.basis.x * input_direction.x
	var character_fordward := Vector3.UP.cross(camera.global_transform.basis.x)
	world_direction += character_fordward * input_direction.y

	velocity = world_direction * speed
	velocity.y -= gravity

	if !world_direction.is_zero_approx():
		dog_mesh.look_at(world_direction + dog_mesh.global_position, Vector3.UP)

	move_and_slide()


func move_player(in_input_direction: Vector2) -> void:
	input_direction = in_input_direction


func map_item_to_distance(item: Node3D) -> float:
	return global_position.distance_to(item.global_position)


func calculate_distance_to_item() -> void:
	var nodes := get_tree().get_nodes_in_group("Item")
	var items_distance_min_valid := nodes.map(map_item_to_distance)

	for i in items_distance_min_valid.size():
		var distance = items_distance_min_valid[i]
		if i == 0:
			min_item_distance = distance
		if distance < min_item_distance:
			min_item_distance = distance

	var particle: GPUParticles3D = particle_signal.get_child(0) as GPUParticles3D

	if min_item_distance > range_of_search:
		particle.emitting = false
		return

	var percentage := calculate_percentage(min_item_distance)
	if percentage >= 50:
		particle_signal.boiling()
		particle.emitting = true
		return
	if percentage >= 0:
		particle_signal.warm()
		particle.emitting = true
		return


func calculate_percentage(distance: float) -> float:
	var diff := range_of_search - distance
	return (diff * 100) / range_of_search


func on_action_bark():
	audio_stream_player.play()
