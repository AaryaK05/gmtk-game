extends Node3D
@export var spawn_small_object=preload("res://scenes/small_obj.tscn")
@export var spawn_big_object=preload("res://scenes/big_obj.tscn")
var rnd=RandomNumberGenerator.new()
var spawn_number=3
var big_spawn_number=5
#var spawn_number=rnd.randi_range(8,10)
var timer=Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(resSpawn)
	resSpawn()
		

func resSpawn():
	spawn()
	timer.start(10)

func spawn():
	for i in spawn_number:
		var obj=spawn_small_object.instantiate()
		add_child(obj)
	for i in big_spawn_number:
		var obj=spawn_big_object.instantiate()
		add_child(obj)
