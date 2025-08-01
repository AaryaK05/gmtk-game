extends Area3D

@export var item_type: String = 'grow'


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group('boulder'):
		body._on_item_picked_up(item_type)
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
