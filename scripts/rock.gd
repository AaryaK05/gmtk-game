extends RigidBody3D

#size parameters to handle scaling and shrinking
var grow_scale = 1.25
var shrink_scale = 0.85
var max_grow_scale = 3.0
var min_shrink_scale = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group('boulder')
	
func grow():
	var new_scale = scale * grow_scale
	new_scale = new_scale.clamp(Vector3(min_shrink_scale, min_shrink_scale, min_shrink_scale), Vector3(max_grow_scale, max_grow_scale, max_grow_scale))
	scale = new_scale
	update_collision_shape()

func shrink():
	var new_scale = scale * shrink_scale
	new_scale = new_scale.clamp(Vector3(min_shrink_scale, min_shrink_scale, min_shrink_scale), Vector3(max_grow_scale, max_grow_scale, max_grow_scale))
	scale = new_scale
	update_collision_shape()
	
func update_collision_shape():
	var collision_shape = $CollisionShape3D
	if collision_shape and collision_shape.shape is SphereShape3D:
		var sphere_shape = collision_shape.shape as SphereShape3D
		sphere_shape.radius = 0.5 * scale.x  # Default radius for unit sphere is 0.5

func _on_item_picked_up(item_type):
	if item_type == 'grow':
		grow()
	elif item_type == 'shrink':
		shrink()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	pass
