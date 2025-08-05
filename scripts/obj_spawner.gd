extends Node3D

@export var spawn_object=preload("res://scenes/small_obj.tscn")
@export var spawn_big_object=preload("res://scenes/big_obj.tscn")

var rnd=RandomNumberGenerator.new()
var spawn_number=2
var spawn_big_number=9
var timer=Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(reSpawn)
	reSpawn()
	
func reSpawn():
	spawn()
	timer.start(14)


func spawn():
	for i in spawn_number:
		var obj=spawn_object.instantiate()
		add_child(obj)
	for i in spawn_big_number:
		var obj=spawn_big_object.instantiate()
		obj.name="Obstacle"
		add_child(obj)
