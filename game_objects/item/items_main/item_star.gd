extends Node3D

class_name ToyStar

@onready var area_3d: Area3D = $Area3D

func _ready() -> void:
	area_3d.body_entered.connect(_on_area_3d_body_entered)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Child"):
		var child := body as GJChild
		if child.take_object_is_valid():
			GameEvents.emit_take_item()
			queue_free()
