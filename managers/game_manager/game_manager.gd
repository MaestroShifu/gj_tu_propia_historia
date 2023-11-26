extends Node

signal game_over
## Time in seconds for gameplay duration from 1 minute to 10 minutes
@export_range(60, 600) var time_out_value : float = 180
@onready var time_out_manager: Timer = $"../TimeOutManager"

var game_state : GAME_STATES = GAME_STATES.READY

enum GAME_STATES {
	READY,
	PLAYING,
	PAUSED,
	GAME_OVER
}


func _ready() -> void:
	time_out_manager.init(time_out_value)
	time_out_manager.time_is_eover.connect(on_time_is_eover)


func change_game_state(new_state: GAME_STATES) -> void:
	game_state = new_state


func on_time_is_eover() -> void:
	change_game_state(GAME_STATES.GAME_OVER)
	game_over.emit()

