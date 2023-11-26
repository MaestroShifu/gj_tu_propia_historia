extends Node

@onready var item_data: ItemSpawn = ItemSpawn.new()
@onready var list_items: Node3D = $ListItems

var total_items: int = 0
var total_take_items: int = 0

var is_win: bool = false

func _ready() -> void:
	start_items_in_map()
	total_items = len(get_tree().get_nodes_in_group("Item"))
	GameEvents.take_item.connect(take_item)


func _process(_delta: float) -> void:
	if total_items == total_take_items:
		is_win = true


func start_items_in_map() -> void:
	for key in item_data.ItemDataSpawn:
		var scene := item_data.ItemDataSpawn[key].scene as Resource
		var positions := item_data.ItemDataSpawn[key].position as Array
		
		if len(positions) == 0:
			continue
		
		var position := positions[randi() % positions.size()] as Dictionary
		if not position.has_all(["x", "y", "z"]):
			continue

		var item := scene.instantiate() as Node3D
		list_items.add_child(item)
		item.global_position = Vector3(position["x"], position["y"], position["z"])

func take_item() -> void:
	total_take_items += 1
