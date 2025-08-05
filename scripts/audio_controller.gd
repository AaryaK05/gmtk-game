extends Node
@onready var music: AudioStreamPlayer = $music
@onready var push: AudioStreamPlayer = $push
@onready var pick: AudioStreamPlayer = $pick
@onready var stretch: AudioStreamPlayer = $stretch
@onready var shoot: AudioStreamPlayer = $shoot
@onready var hit: AudioStreamPlayer = $hit


func play_music():
	music.play()
	
func play_push_rock():
	push.play()
	
func stop_push_rock():
	push.stop()
	
func play_pick_obj():
	pick.play()
	
func play_stretch_slingshot():
	stretch.play()
	
func play_shoot():
	shoot.play()
	
	
func play_pickup():
	pick.play()


func play_hit_door():
	hit.play()
