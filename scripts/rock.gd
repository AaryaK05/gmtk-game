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
	
	if body is RigidBody3D:
		#print(body.get_children())
		if body.has_node("obstacle"):
			mass-=0.25
		else:			
			mass+=0.25
			for child_node in get_children(): # cant directly scale RigidBody3D, so we scale children instead
				if child_node is Node3D:
					child_node.scale += Vector3.ONE * 0.015
			body.queue_free()
			print(mass)
	
			
	if body.name=="gate" and !Globals.gateHit:
		print("hit!!")
		Globals.gateHit=true
		spawn_rock()
		#self.translate(ballOffset)
		#self.freeze=true
		slingshotCollide=false
		Globals.weight+=self.mass
		print(Globals.weight)
	

		

	
		
	
