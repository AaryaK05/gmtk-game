extends RigidBody3D

@onready var player: CharacterBody3D = $"../player"
@onready var slingy: Node3D = $"../slingy"
@onready var spawn_marker: Marker3D = $"../other/spawnMarker"
@onready var slingshot_marker: Marker3D = $"../other/slingshotMarker"
@onready var rock_collider_detector: Area3D = $rockColliderDetector
@onready var result: Label = $"../player/Camera3D/result"
@onready var weight_left: Label = $"../player/Camera3D/weightLeft"

var rockMoving=false
#func _ready() -> void:
	#pass

#main physics function
func _physics_process(delta: float) -> void:
#	if player grabs the ball set ball position in front of player
	if player.grabbing:
		self.position.x=player.position.x
		self.position.z=player.position.z-0.6
		#a force applied on the x axis 
		apply_central_force(Vector3(-10,0,0) * delta)
		#torque to move it upward and show rotation
		apply_torque(Vector3(-100,0,0) * delta)
		#print("still aplied")
		
	if angular_velocity.length() > 0.001 and !rockMoving and !Globals.throw_ball:
		rockMoving=true
		AudioController.play_push_rock()
	if angular_velocity.length() ==0:
		rockMoving=false
		AudioController.stop_push_rock()
	
# spawn rock every round at spawn marker
func spawn_rock():
	rockMoving=false
	self.global_transform.origin=spawn_marker.global_transform.origin
	self.freeze=true

# signal of rock that checks for collisions
func _on_body_entered(body: Node) -> void:
#	checks for slingshot collision
	if body.name=="slingMeshCollision":
#		stop rock moving sound
		AudioController.stop_push_rock()
#		set throwball variable
		Globals.throw_ball=true
#		change rock position to slingshot marker position
		self.global_transform.origin=slingshot_marker.global_transform.origin
#		apply an impulse to rock towards gate
		player.grabbing=false
		
		self.apply_central_impulse(Vector3(0, 0, 1500))
#		set grabbing variable of player 
		
#		play throwing sound
		AudioController.play_shoot()
#	checks for collision to falling rocks
	elif body is RigidBody3D:
#		if the falling rock has a collision layer set to 3 
		if body.get_collision_layer_value(3): # if small rock
			on_hit_small_rock(body)
		#if the falling rock has a collision layer set to 4
		elif body.get_collision_layer_value(4): # if big rock
			on_hit_big_rock(body)
#	if rock collides with gate 
	elif body.name=="gate" and !Globals.gateHit:
#		play hit sound
		AudioController.play_hit_door()
#		set global gateHit to true
		Globals.gateHit=true
#		reSpawn rock to original position
		spawn_rock()
#		show sucess text on hit
		result.visible=true
		result.text="SUCCESS!"
#		set total weight needed on top left corner
		Globals.totalGateWeightNeeded-=self.mass
		weight_left.text="Weight to Hit Gate:"+str(Globals.totalGateWeightNeeded)+"kg"


func on_hit_small_rock(rock: RigidBody3D) -> void:
#	play pickup sound on collide with small rock
	AudioController.play_pickup()
	print(self.mass)
#	set mass of rock
	mass+=0.25
#	scale children of rock
	for child_node in get_children(): # cant directly scale RigidBody3D, so we scale children instead
		if child_node is Node3D:
			child_node.scale += Vector3.ONE * 0.015
#	free the small rock on hit
	rock.queue_free()

func on_hit_big_rock(rock: RigidBody3D) -> void:
#	play pickup sound
	AudioController.play_pickup()
	
	print(self.mass)
	mass = maxf(mass - 0.25, 0.5)
	for child_node in get_children(): # cant directly scale RigidBody3D, so we scale children instead
		if child_node is Node3D:
			child_node.scale = (child_node.scale - Vector3.ONE * 0.015).maxf(0.2)
	rock.apply_central_impulse(global_position.direction_to(rock.global_position) * 15)
	
	# prevent falling off map when hit by big rock
	linear_velocity = Vector3.ZERO
	constant_force = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	freeze = true
	freeze = false
	#print(mass)
