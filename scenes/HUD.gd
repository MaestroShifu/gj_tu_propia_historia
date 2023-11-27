extends Control
class_name Hud

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var menu: Control = %Menu
@onready var win: Control = $Win
@onready var quest: PanelContainer = $Quest
@onready var nino: TextureRect = $Personaje/Nino
@onready var item_count: Label = $Tula/item_count
@onready var time_text: Label = %Time_text
@onready var btn_empezar: Button = $Menu/VBoxContainer/btn_empezar


func _on_btn_empezar_pressed():
	quest.visible = true
	menu.visible = false
	animation_player.play("quest_animation")


func update_time_text(in_text: String):
	time_text.text = in_text


func update_total_items_ui(total_items: int, total_take_items: int):
	item_count.text = "%s/%s" %[total_take_items, total_items]


func _on_btn_close_quest_pressed():
	quest.visible = false


func _on_btn_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()


func _on_btn_salir_pressed() -> void:
	pass # Replace with function body.
