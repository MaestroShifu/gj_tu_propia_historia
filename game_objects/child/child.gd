extends CharacterBody3D
class_name GJChild

@export var speed = 14
@export var gravity: float = -1.0
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D


func _physics_process(_delta: float) -> void:
	var current_pos := global_position
	var next_pos := navigation_agent_3d.get_next_path_position()
	var new_velocity : Vector3 = next_pos.direction_to(current_pos) * speed

	navigation_agent_3d.velocity = new_velocity


func update_agent(target_location : Vector3):
	navigation_agent_3d.set_target_position(target_location)


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()
