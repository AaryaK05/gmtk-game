extends Node
@onready var main: BoxContainer = $Buttons/main
@onready var settings: BoxContainer = $Buttons/settings
@onready var controls: BoxContainer = $Buttons/controls



func _ready() -> void:
	main.visible=true
	settings.visible=false
	
func _on_play_btn_pressed() -> void:
	Game.start_game()

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_settings_btn_pressed() -> void:
	main.visible=false
	settings.visible=true

func _on_back_pressed() -> void:
	main.visible=true
	settings.visible=false


func _on_controls_btn_pressed() -> void:
	main.visible=false
	controls.visible=true
	
func _on_cntrlback_btn_pressed() -> void:
	main.visible=true
	controls.visible=false
