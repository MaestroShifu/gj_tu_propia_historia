extends CharacterBody3D
class_name GJChild

@export var speed = 2
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D


func _physics_process(_delta: float) -> void:
	var current_pos := global_position
	var next_pos := navigation_agent_3d.get_next_path_position()
	var direction := (next_pos - current_pos).normalized()

	velocity = direction * speed
	move_and_slide()


func update_agent(target_location : Vector3):
	navigation_agent_3d.set_target_position(target_location)

