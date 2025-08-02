extends Node
@onready var main: BoxContainer = $Buttons/main
@onready var settings: BoxContainer = $Buttons/settings


func _ready() -> void:
	AudioController.play_music()
	main.visible=true
	settings.visible=false
	
func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_settings_btn_pressed() -> void:
	main.visible=false
	settings.visible=true

func _on_back_pressed() -> void:
	main.visible=true
	settings.visible=false
