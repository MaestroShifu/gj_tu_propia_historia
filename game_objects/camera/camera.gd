@tool
extends Camera3D

class_name Camera

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") as Player

func _physics_process(_delta: float) -> void:
	if player:
		look_at(player.global_position, Vector3.UP)
