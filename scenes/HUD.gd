extends Control

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var menu: Control = %Menu
@onready var quest: PanelContainer = $Quest

func _on_btn_empezar_pressed():
	quest.visible = true
	menu.visible = false
	animation_player.play("quest_animation")
	
func _on_btn_close_quest_pressed():
	quest.visible = false
