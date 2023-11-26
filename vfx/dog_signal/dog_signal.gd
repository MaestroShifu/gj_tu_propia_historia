extends Node3D

class_name SignalVFX

@onready var exclamation_mesh: GPUParticles3D = $Exclamation_mesh

func boiling() -> void:
	exclamation_mesh.process_material.color = Color(1, 0, 0, 1)

func warm() -> void:
	exclamation_mesh.process_material.color = Color(0, 1, 0, 1)
