extends Node2D

@onready var stagePositionsAccess = get_parent().get_node("Positions")
func _ready() -> void:
	$animate.use_parent_material = true
	use_parent_material = true
	name = "gf"
	print(get_parent().stageData)
	z_index = get_parent().stageData["characters"]["gf"]["zIndex"]

var runOnceIFUCKINGHATETHISREADYBULLSHIT = false
var conductor
func _process(delta: float) -> void:
	position = stagePositionsAccess.get_node("GF").position
	if runOnceIFUCKINGHATETHISREADYBULLSHIT == false:
		conductor = get_parent().get_node("UILayer/Conductor")
		runOnceIFUCKINGHATETHISREADYBULLSHIT = true
	$animate.play(str(conductor.currGFAnim[0]))
	pass
