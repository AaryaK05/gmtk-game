extends Node
@onready var main: BoxContainer = $Buttons/main
@onready var settings: BoxContainer = $Buttons/settings
@onready var background: Sprite2D = $Control/Background
@onready var controls: ColorRect = $Buttons/controls

	

func _physics_process(delta: float) -> void:
#	window resizing
	var width=get_viewport().size.x
	var height=get_viewport().size.y
	background.scale.x=width/ background.texture.get_size().x
	background.scale.y=height/ background.texture.get_size().y
	#pass

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
