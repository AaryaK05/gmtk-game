extends HSlider
@onready var h_slider: HSlider = $"."

#@export
#var bus_name:String
#Get the bus index value
var bus_index:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index=AudioServer.get_bus_index("music")
	#Set Initial Slider Value
	var val=h_slider.value
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(val)
	)
	#Connect the slider to the function
	value_changed.connect(_on_value_changed)
	
func _on_value_changed(value:float)->void:
	#Set Changed Value to that Bus index
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
