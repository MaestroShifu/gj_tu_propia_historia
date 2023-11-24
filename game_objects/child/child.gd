extends CharacterBody3D
class_name GJChild

@export var speed : float = 2
@export var random_pos_radius : float = 15
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(_delta: float) -> void:
	if navigation_agent_3d.is_navigation_finished():
		return

	var current_pos := global_position
	var next_pos := navigation_agent_3d.get_next_path_position()
	var direction := (next_pos - current_pos).normalized()
	var new_velocity : Vector3 = direction * speed
	new_velocity.y -= gravity

	set_velocity(new_velocity)
	move_and_slide()


func update_target_position(target_location : Vector3):
	navigation_agent_3d.set_target_position(target_location)


func update_random_target_pos():
	var random_position := self.position
	random_position.x = random_position.x + randf_range(-random_pos_radius, random_pos_radius)
	random_position.z = random_position.z + randf_range(-random_pos_radius, random_pos_radius)

	navigation_agent_3d.set_target_position(random_position)


