extends CharacterBody3D
class_name GJChild

@export var speed : float = 2
@export var listening_range: float = 8
@export var random_pos_radius : float = 15
@export var game_manager: GameManager
@export var time_to_reach_target : float = 10

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var sfx_kid_step: AudioStreamPlayer3D = $SfxKidSteps
@onready var child_mesh: Node3D = %Child

var dog_bark: bool = false
var is_lost: bool = false
var animation_player: AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var elapsed_time : float = 0

func _ready() -> void:
	GameEvents.call_the_child.connect(on_action_dog_bark)
	animation_player = child_mesh.get_node_or_null("AnimationPlayer")


func _process(_delta: float) -> void:
	validate_listening_range()


func _physics_process(_delta: float) -> void:
	if navigation_agent_3d.is_navigation_finished():
		animation_player.play("Neutro")
		sfx_kid_step.stop()
		is_lost = false
		elapsed_time = 0
		return

	elapsed_time += _delta
	if elapsed_time >= time_to_reach_target:
		unstuck()
		elapsed_time = 0
		return

	var next_pos := navigation_agent_3d.get_next_path_position()
	var direction := (next_pos - global_position).normalized()
	velocity = direction * speed
	velocity.y -= gravity

	if !velocity.is_zero_approx():
		var direction_tmp := direction
		direction_tmp.y = 0
		look_at(global_position + direction_tmp, Vector3.UP)
		animation_player.play("Walk")
		if not sfx_kid_step.playing:
			sfx_kid_step.play()

	move_and_slide()


func validate_listening_range() -> void:
	var dog: Player = get_tree().get_first_node_in_group("Player") as Player
	var is_listening := valid_is_listening()

	if dog_bark && is_listening:
		update_target_position(dog.global_position)
		dog_bark = false
		is_lost = false

	if is_lost:
		dog_bark = false
		return

	if not is_listening && not is_lost && not dog_bark:
		update_random_target_pos()
		is_lost = true

	if is_lost:
		game_manager.hud.set_child_port_lost_texture()
	else:
		game_manager.hud.set_child_port_found_texture()


func update_target_position(target_location : Vector3):
	navigation_agent_3d.set_target_position(target_location)


func update_random_target_pos():
	var dog: Player = get_tree().get_first_node_in_group("Player") as Player
	var random_position : Vector3 = Vector3.ZERO
	while true:
		random_position = self.position
		random_position.x = random_position.x + randf_range(-random_pos_radius, random_pos_radius)
		random_position.z = random_position.z + randf_range(-random_pos_radius, random_pos_radius)

		var delta_dog := dog.position - random_position
		if delta_dog.length() > listening_range:
			break

	navigation_agent_3d.set_target_position(random_position)


func on_action_dog_bark() -> void:
	if valid_is_listening():
		dog_bark = true


func valid_is_listening() -> bool:
	var dog: Player = get_tree().get_first_node_in_group("Player") as Player
	return global_position.distance_to(dog.global_position) <= listening_range


func take_object_is_valid() -> bool:
	return valid_is_listening() && not is_lost


func unstuck():
	var dog: Player = get_tree().get_first_node_in_group("Player") as Player
	var delta_dog = dog.position - global_position
	var new_target := global_position + delta_dog.normalized() * (delta_dog.length() * 0.5)
	update_target_position(new_target)
