extends Node3D

class_name SignalVFX

@onready var exclamation_mesh: GPUParticles3D = $Exclamation_mesh

func boiling() -> void:
	exclamation_mesh.process_material.color = Color8(245, 191, 66, 255)

func warm() -> void:
	exclamation_mesh.process_material.color = Color8(245, 233, 66, 255)
