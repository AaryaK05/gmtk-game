extends CharacterBody3D

@onready var rock: RigidBody3D = $"../Rock"
@onready var player_collider_detector: Area3D = $playerColliderDetector
@onready var camera_3d: Camera3D = $Camera3D
@onready var slingy: Node3D = $"../slingy"
@onready var slingshot_marker: Marker3D = $"../other/slingshotMarker"
@onready var spawn_marker: Marker3D = $"../other/spawnMarker"
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
@onready var game_over: Label = $Camera3D/gameOver
@onready var result: Label = $Camera3D/result
@onready var pause: Control = $Camera3D/pause

#var joint: Generic6DOFJoint3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var push_force=80.0
var grabbing:bool
var canMove=true
var camera_offset=Vector3(-1.351,0.479,2.888)
var timer=Timer.new()

func _ready() -> void:
	pause.visible=false
	add_child(timer)
	timer.timeout.connect(ball_throwing_anim)

func _physics_process(delta: float) -> void:
	# Add the gravity.
#	if game is in win State
	if Globals.winGame:
		result.visible=false
		game_over.visible=true
		#get_tree().paused=true
		Game.toggle_pause(self.camera_3d)
		
#	if player can move
	if canMove:
#		if player is not on floor apply gravity 
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("left", "right", "forward", "back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#		if player is walking towards a axis
		if direction:
			animated_sprite_3d.play("walk")
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
#			brings to stop smoothly
			animated_sprite_3d.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)


		#Grab the ball
		if Input.is_action_just_pressed("grab"):
				var action=player_collider_detector.get_overlapping_areas()
#				grab and release ball
				if !grabbing and action:
					grab_ball()
				else:
					release_ball()
		move_and_slide()
				
#	if throw ball is set stop player movement and run this only once otherwise error occurs
	if Globals.throw_ball:
		Globals.throw_ball=false
		#stop player from moving
		canMove=false 
		#Camera view for throwing the ball
		slingshot_camera_view()
		#after 3 seconds get spawn position
		timer.start(10)		
			
func grab_ball():
	grabbing=true
	
func release_ball():
	grabbing=false
		

func ball_throwing_anim():
	timer.stop()
	spawn_position()

#slingshot camera view
func slingshot_camera_view():
	camera_3d.global_transform.origin = slingshot_marker.global_transform.origin
	camera_3d.rotation_degrees.y=-180
	
func original_camera_view():
	#original camera view
	camera_3d.global_transform = spawn_marker.global_transform 
	camera_3d.translate(camera_offset)
	camera_3d.rotation_degrees.x=-5.5
	camera_3d.rotation_degrees.y=-21.8
	
#spawn position
func spawn_position():
#	clear success text
	result.visible=false
#	set player spawn position
	self.global_transform.origin = spawn_marker.global_transform.origin
#	player is allowed to move again
	self.canMove=true
#	 respawn rock no matter what
	Globals.gateHit=false
	if !Globals.gateHit:
		rock.spawn_rock()
#	idk what this is
	#Globals.respawnRocks=true
#	set camera original view
	original_camera_view()
	rock.freeze=false
	


	
