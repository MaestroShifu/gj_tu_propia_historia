extends Timer

signal time_is_eover()

@onready var hud: HudGame = $"../../hud"  as HudGame


func _ready() -> void:
	if autostart:
		init()


func _process(_delta: float) -> void:
	if is_running():
		hud.time_text.text = time_format(time_left)


func init(init_time : float = 0) -> void:
	if !is_stopped():
		return

	if !autostart:
		wait_time = init_time

	start()


func is_running() -> bool:
	return !is_stopped()


func _on_timeout() -> void:
	stop()
	time_is_eover.emit()


func time_format(time_in_secs : float) -> String:
	var seconds = fmod(time_in_secs, 60)
	var minutes = fmod((time_in_secs/60), 60)

	return "%02d:%02d" % [minutes, seconds]
