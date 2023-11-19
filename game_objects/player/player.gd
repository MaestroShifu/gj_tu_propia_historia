extends CharacterBody3D

@export var speed = 14

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	GameEvents.move_player.connect(move_player)

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func move_player(input_direction: Vector3) -> void:
	direction = input_direction
