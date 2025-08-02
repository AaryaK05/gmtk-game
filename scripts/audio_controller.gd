extends Node
@onready var music: AudioStreamPlayer = $music
@onready var push: AudioStreamPlayer = $push
@onready var pick: AudioStreamPlayer = $pick
@onready var stretch: AudioStreamPlayer = $stretch
@onready var shoot: AudioStreamPlayer = $shoot


func play_music():
	music.play()
	
func play_push_rock():
	push.play()
	
func play_pick_obj():
	pick.play()
	
func play_stretch_slingshot():
	stretch.play()
	
func play_shoot():
	shoot.play() 
