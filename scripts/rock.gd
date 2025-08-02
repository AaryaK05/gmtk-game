extends RigidBody3D
@onready var player: CharacterBody3D = $"../player"
@onready var rock_collider_detector: Area3D = $rockColliderDetector
@onready var slingy: Node3D = $"../slingy"
@onready var spawn_marker: Marker3D = $"../spawnMarker"
@onready var slingshot_marker: Marker3D = $"../slingshotMarker"
var slingshotCollide=false
#var ballOffset=Vector3(0,5.5,4.9)
@onready var rock_mesh: MeshInstance3D = $Rock

func _ready() -> void:
	self.global_transform.origin=spawn_marker.global_transform.origin


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
		self.apply_central_impulse(Vector3(0, 0, 8000))
		player.grabbing=false
		slingshotCollide=true
		#print("done")
	
	if body is RigidBody3D:
		mass+=5
		rock_mesh.scale*=Vector3(1.02,1.02,1.02)
		#print(self.scale)
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
	

		

	
		
	
