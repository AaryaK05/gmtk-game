extends Node
@onready var player: CharacterBody3D = $player

func start_game():
	if !Globals.playingGame:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		
#
func _process(delta: float) -> void:
#	escape to pause game
	if Input.is_action_just_pressed("escape"):
#		if the current node has this pause node
		if has_node("player/Camera3D/pause"):
			toggle_pause(player)

func _on_continue_btn_pressed() -> void:
	toggle_pause(player)

func _on_restart_btn_pressed() -> void:
	toggle_pause(player)
	get_tree().reload_current_scene()
	
func _on_back_to_menu_btn_pressed() -> void:
	AudioController.stop_push_rock()
	toggle_pause(player)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func toggle_pause(body:Node):
		#print("Won:",Globals.winGame)
		if Globals.winGame:
			Globals.pausedGame=!Globals.pausedGame
			#await get_tree().create_timer(2.0).timeout 
			get_tree().paused=Globals.pausedGame
			var pause=body.get_child(0)
			pause.visible=true
			var label=pause.get_child(1)
			label.text="GAME OVER"
			var continueBtn=pause.get_child(2)
			continueBtn.visible=false
			Globals.winGame=false
			print(Globals.winGame)
			print("Game is over")
		else:		
			Globals.pausedGame=!Globals.pausedGame
			var pause=$player/Camera3D/pause
			pause.visible=Globals.pausedGame
			get_tree().paused=Globals.pausedGame
			#if Globals.pausedGame:
				#print("Game paused")
			#else:
				#print("Game continued")	
#


#free rocks after touching the area3d at the bottom of the mountain
func _on_rock_free_area_body_entered(body: Node3D) -> void:
	if body is CollisionObject3D:
		if body.get_collision_layer_value(5): # 5 corresponds to layer "free"
			await get_tree().create_timer(3, false, true).timeout # wait 3 seconds before freeing
			if is_instance_valid(body):
				body.queue_free()

#

		
