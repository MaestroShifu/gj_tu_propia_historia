extends Control
class_name HudGame

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var menu: Control = %Menu
@onready var win: Control = $Win
@onready var quest: PanelContainer = $Quest
@onready var nino: TextureRect = $Personaje/Nino
@onready var item_count: Label = $Tula/item_count
@onready var time_text: Label = %Time_text
@onready var btn_empezar: Button = $Menu/VBoxContainer/btn_empezar
@onready var lose: Control = $Lose
@onready var items_pictures_container: HBoxContainer = $Tula/PanelContainer/MarginContainer/PanelContainer2/HBoxContainer

var img_found : Texture2D = preload("res://assets/hud/items/kid_found.png") as Texture2D
var img_lost : Texture2D = preload("res://assets/hud/items/kid_lost.png") as Texture2D
var item_picture_template : PackedScene = preload("res://scenes/hud/item_picture.tscn") as PackedScene

var game_manager : GameManager
var item_ui_dict : Dictionary

func _ready() -> void:
	nino.texture = img_lost
	menu.set_visible(true)
	win.set_visible(false)
	lose.set_visible(false)


func init(in_game_manager: GameManager):
	game_manager = in_game_manager

	var items_data := game_manager.item_data.ItemDataSpawn
	for key in items_data.keys():
		var item : Dictionary = items_data[key] as Dictionary
		var item_ui := item_picture_template.instantiate() as ItemDataUI
		items_pictures_container.add_child(item_ui)
		item_ui.init(item.found, item.disabled, key)
		item_ui_dict[key] = item_ui


func activate_found_item(in_item : ItemSpawn.EnumItemName):
	if !item_ui_dict.has(in_item):
		return

	var item_ui : ItemDataUI = item_ui_dict[in_item] as ItemDataUI
	item_ui.set_active_item()


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


func set_child_port_found_texture():
	nino.texture = img_found


func set_child_port_lost_texture():
	nino.texture = img_lost


func show_win_notice():
	win.set_visible(true)


func show_lose_notice():
	lose.set_visible(true)
