extends Node

var throw_ball=false
var gateHit=false
var weight=0
var totalWeight=30
var respawnRocks=true

func _physics_process(delta: float) -> void:
	if Globals.weight>=Globals.totalWeight:
		print("Game over!")
		get_tree().quit()
