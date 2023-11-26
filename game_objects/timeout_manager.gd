extends Timer

signal time_is_eover()


func _ready() -> void:
	if autostart:
		init()


func _process(_delta: float) -> void:
	pass
	#if is_running():
	#	print(left_time_format())


func init(init_time : float = 0) -> void:
	if !is_stopped():
		return

	if !autostart:
		wait_time = init_time

	start()


func is_running() -> bool:
	return !is_stopped()


func _on_timeout() -> void:
	time_is_eover.emit()


func left_time_format() -> String:
	var seconds = fmod(time_left, 60)
	var minutes = fmod((time_left/60), 60)

	return "%02d:%02d" % [minutes, seconds]
