extends Node3D

class_name Item

@onready var area_3d: Area3D = $Area3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Child"):
		var child := body as GJChild
		if child.take_object_is_valid():
			queue_free()
