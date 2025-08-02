extends Node3D

@export var spawn_object=preload("res://scenes/small_obj.tscn")
var rnd=RandomNumberGenerator.new()
var spawn_number=10
#var spawn_number=rnd.randi_range(8,10)

func _ready() -> void:
	spawn()

#func _process(delta: float) -> void:
	#if Globals.respawnRocks:
		#spawn()
		#Globals.respawnRocks=false
		


func spawn():
	for i in spawn_number:
		var obj=spawn_object.instantiate()
		add_child(obj)
