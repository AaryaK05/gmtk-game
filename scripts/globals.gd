extends Node

var throw_ball=false
var gateHit=false
var weight=0
var totalWeight=10
var respawnRocks=true
var playingGame=false
var pausedGame=false
var winGame=false

var totalGateWeightNeeded=5

func _physics_process(delta: float) -> void:
	if totalGateWeightNeeded<=0:
		print("Game over!")
		#game_over.visible=true
		winGame=true
		
