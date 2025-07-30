extends Node
@onready var container: BoxContainer = $ColorRect/Container
@onready var container_2: BoxContainer = $ColorRect/Container2

func _ready() -> void:
	container.visible=true
	container_2.visible=false
	
func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_settings_btn_pressed() -> void:
	container.visible=false
	container_2.visible=true

func _on_back_pressed() -> void:
	container.visible=true
	container_2.visible=false
