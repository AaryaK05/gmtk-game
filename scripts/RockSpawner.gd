extends Node3D

@export var spawn_object=preload("res://scenes/small_obj.tscn")
@export var spawn_big_object=preload("res://scenes/big_obj.tscn")
@export var spawn_marker=preload("res://scenes/obj_spawner.tscn")
@onready var rock: RigidBody3D = $"../../Rock"

#var area=self.get_child(0)

var marker=Marker3D.new()
var rng=RandomNumberGenerator.new()
var spawn_number=2
var spawn_big_number=30
var timer=Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(reSpawn)
	#reSpawn()
	
	
func reSpawn():
	spawn()
	timer.start(10)


func spawn():
	for i in spawn_number:
		var obj=spawn_object.instantiate()
		obj.position=getRandomPosition()
		add_child(obj)
		#print(obj.position)
	for i in spawn_big_number:
		var obj=spawn_big_object.instantiate()
		obj.position=getRandomPosition()
		add_child(obj)
		#print(obj.position)


func getRandomPosition() -> Vector3:
	rng.randomize()
	var x=rng.randf_range(30,-30)
	return Vector3(x,0,0)
	
	

func _on_body_entered(body: Node3D) -> void:
	if body is CollisionObject3D:
		if body.get_collision_layer_value(7):
			print(rock.mass)
			if rock.mass > 14.75:
				spawn_number=30
				spawn_big_number=2
			else:
				spawn_number=2
				spawn_big_number=30
			reSpawn()
			

#func _on_body_exited(body: Node3D) -> void:
	#timer.stop()
