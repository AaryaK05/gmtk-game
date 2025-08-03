extends Node
#@onready var control: Control = $player/Camera3D/Control

func start_game():
	if !Globals.playingGame:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
#
#func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("escape"):
		#_on_pause_btn_pressed()	
		#
#func _on_pause_btn_pressed() -> void:
	#get_tree().paused=!Globals.pausedGame
	##control.visible=!Globals.pausedGame
	#Globals.pausedGame=true
#
#func go_to_menu():
	#pass
