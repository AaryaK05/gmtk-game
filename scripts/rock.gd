extends RigidBody3D
@onready var player: CharacterBody3D = $"../player"
@onready var rock_collider_detector: Area3D = $rockColliderDetector
@onready var slingy: Node3D = $"../slingy"
@onready var spawn_marker: Marker3D = $"../spawnMarker"
@onready var slingshot_marker: Marker3D = $"../slingshotMarker"
var slingshotCollide=false
#var ballOffset=Vector3(0,5.5,4.9)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#print(self.position)
	if player.grabbing:
		#print("player is grabbing")
		self.position.x=player.position.x
		self.position.z=player.position.z-0.6
	
func spawn_rock():
	self.global_transform.origin=spawn_marker.global_transform.origin
	self.freeze=true

func _on_body_entered(body: Node) -> void:
	#print(body.name)
	if body.name=="slingMeshCollision" and !slingshotCollide:
		Globals.throw_ball=true
		self.global_transform.origin=slingshot_marker.global_transform.origin
		self.apply_central_impulse(Vector3(0, 0, 1000))
		player.grabbing=false
		slingshotCollide=true
		AudioController.play_shoot()
		#print("done")
	elif body is RigidBody3D:	
		if body.get_collision_layer_value(3): # if small rock
			on_hit_small_rock(body)
		elif body.get_collision_layer_value(4): # if big rock
			on_hit_big_rock(body)
	elif body.name=="gate" and !Globals.gateHit:
		print("hit!!")
		Globals.gateHit=true
		spawn_rock()
		#self.translate(ballOffset)
		#self.freeze=true
		slingshotCollide=false
		Globals.weight+=self.mass
		print(Globals.weight)

func on_hit_small_rock(rock: RigidBody3D) -> void:
	mass+=0.25
	for child_node in get_children(): # cant directly scale RigidBody3D, so we scale children instead
		if child_node is Node3D:
			child_node.scale += Vector3.ONE * 0.015
	rock.queue_free()

func on_hit_big_rock(rock: RigidBody3D) -> void:
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
