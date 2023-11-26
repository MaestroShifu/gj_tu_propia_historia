extends Node

signal game_over

enum GAME_STATES {
	READY,
	PLAYING,
	PAUSED,
	GAME_OVER
}

## Time in seconds for gameplay duration from 1 minute to 10 minutes
@export_range(60, 600) var time_out_value : float = 180

@onready var time_out_manager: Timer = $"../TimeOutManager"
@onready var item_data: ItemSpawn = ItemSpawn.new()
@onready var list_items: Node3D = $ListItems

var total_items: int = 0
var total_take_items: int = 0
var percentage_color: float = 0

var is_win: bool = false

var game_state : GAME_STATES = GAME_STATES.READY


func _ready() -> void:
	start_items_in_map()
	total_items = len(get_tree().get_nodes_in_group("Item"))
	GameEvents.take_item.connect(take_item)

	time_out_manager.init(time_out_value)
	time_out_manager.time_is_eover.connect(on_time_is_eover)


func _process(delta: float) -> void:
	if total_items == total_take_items:
		is_win = true
	
	var percentage_color_new := float(total_take_items) / float(total_items)
	percentage_color = lerpf(percentage_color, percentage_color_new, delta)
	RenderingServer.global_shader_parameter_set("grayscale", percentage_color)
	

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
		item.item_name = key
		item.global_position = Vector3(position["x"], position["y"], position["z"])

func take_item(item_name: ItemSpawn.EnumItemName) -> void:
	print("Item recojido", item_name)
	total_take_items += 1


func change_game_state(new_state: GAME_STATES) -> void:
	game_state = new_state


func on_time_is_eover() -> void:
	change_game_state(GAME_STATES.GAME_OVER)
	game_over.emit()
