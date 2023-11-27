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
@onready var fill_cooldown: TextureRect = %fill_cooldown

var couldown_bark_percentage: float = 0

var img_found : Texture2D = preload("res://assets/hud/items/kid_found.png") as Texture2D
var img_lost : Texture2D = preload("res://assets/hud/items/kid_lost.png") as Texture2D


func _ready() -> void:
	nino.texture = img_lost
	menu.set_visible(true)
	win.set_visible(false)
	lose.set_visible(false)
	
	GameEvents.couldown_bark.connect(couldown_bark_time)


func _process(delta: float) -> void:
	fill_cooldown.material.set("shader_parameter/FloatParameter", couldown_bark_percentage)


func couldown_bark_time(percentage: float) -> void:
	couldown_bark_percentage = percentage


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
