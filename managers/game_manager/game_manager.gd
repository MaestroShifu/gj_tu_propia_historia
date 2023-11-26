extends Node

@onready var item_data: ItemSpawn = ItemSpawn.new()
@onready var list_items: Node3D = $ListItems

func _ready() -> void:
	start_items_in_map()


func _process(_delta: float) -> void:
	pass


func start_items_in_map() -> void:
	for key in item_data.ItemDataSpawn:
		var scene = item_data.ItemDataSpawn[key].scene
		var positions := item_data.ItemDataSpawn[key].position as Array
		
		if len(positions) == 0:
			continue
		
		var position := positions[randi() % positions.size()] as Dictionary
		if not position.has_all(["x", "y", "z"]):
			continue

		var item = scene.instantiate() as Node3D
		list_items.add_child(item)
		item.global_position = Vector3(position["x"], position["y"], position["z"])
