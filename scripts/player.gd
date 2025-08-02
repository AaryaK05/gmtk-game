extends CharacterBody3D
@onready var rock: RigidBody3D = $"../Rock"
@onready var player_collider_detector: Area3D = $playerColliderDetector
@onready var camera_3d: Camera3D = $Camera3D
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slingy: Node3D = $"../slingy"
@onready var spawn_marker: Marker3D = $"../spawnMarker"

var joint: Generic6DOFJoint3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var push_force=80.0
var grabbing:bool
var canMove=true
var timer=Timer.new()
var camera_offset=Vector3(-1.551,0.479,0.888)

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(ball_throwing_anim)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#print(canMove)
	if canMove:
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#print(direction)
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)


		#Grab the ball
			
		if Input.is_action_just_pressed("grab"):
				var action=player_collider_detector.get_overlapping_areas()
				if action:
					print(action[0].name)
				if !grabbing and action:
					AudioController.play_push_rock()
					grab_ball()
				else:
					release_ball()
		move_and_slide()
				
	if Globals.throw_ball:
		Globals.throw_ball=false
		#stop player from moving
		canMove=false 
		#Camera view for throwing the ball
		camera_view()
		#after 3 seconds get spawn position
		timer.start(3)		
		
		
	
			#c.get_collider().apply_central_impulse(-c.get_normal()*push_force)	
			
func grab_ball():
	grabbing=true
	
func release_ball():
	grabbing=false
		
func ball_throwing_anim():
	timer.stop()
	spawn_position()

func camera_view():
	camera_3d.position.x=slingy.position.x
	camera_3d.position.y=slingy.position.y -10
	camera_3d.position.z=slingy.position.z - 25
	#print(camera_3d.position)
	#print(camera_3d.rotation)
	camera_3d.rotate_y(179.6)
	
func spawn_position():
	self.global_transform.origin = spawn_marker.global_transform.origin
	#print(spawn_marker.transform.origin)
	#print(self.position)
	self.canMove=true
	Globals.gateHit=false
	if !Globals.gateHit:
		rock.spawn_rock()
	Globals.respawnRocks=true
	camera_3d.global_transform = spawn_marker.global_transform 
	camera_3d.translate(camera_offset)
	camera_3d.rotation_degrees.y=-31
	rock.freeze=false
	
	
