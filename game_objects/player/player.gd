extends CharacterBody3D
class_name Player

@export var speed : float = 14
@export var range_of_search: float = 5

@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var input_direction: Vector2 = Vector2.ZERO
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
var min_item_distance: float = 0


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

	move_and_slide()


func move_player(in_input_direction: Vector2) -> void:
	input_direction = in_input_direction


func filter_distance_valid(item: Item) -> bool:
	return global_position.distance_to(item.global_position) <= range_of_search


func map_item_to_distance(item: Item) -> float:
	return global_position.distance_to(item.global_position)


func calculate_distance_to_item() -> void:
	var nodes := get_tree().get_nodes_in_group("Item")
	var items_distance_min_valid := nodes.filter(filter_distance_valid).map(map_item_to_distance)
	
	if len(items_distance_min_valid) == 0:
		min_item_distance = 0
	else:
		for i in items_distance_min_valid.size():
			var distance = items_distance_min_valid[i]
			if i == 0:
				min_item_distance = distance
			if distance < min_item_distance:
				min_item_distance = distance


func on_action_bark():
	audio_stream_player.play()
