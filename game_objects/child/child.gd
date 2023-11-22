extends CharacterBody3D

@export var speed = 14
@export var gravity: float = -1.0

func _physics_process(_delta: float) -> void:
	move_and_slide()
