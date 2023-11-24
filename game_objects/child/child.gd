extends CharacterBody3D
class_name GJChild

@export var speed = 2
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

