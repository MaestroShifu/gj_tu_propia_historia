extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var child: GJChild = $Child


func _process(delta: float) -> void:
	child.update_agent(player.position)

