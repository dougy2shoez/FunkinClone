extends Node2D


func _ready() -> void:
	$animate.use_parent_material = true
	use_parent_material = true
	name = "bf"
	print(get_parent())
var conductor
var bfSingTimer = 0.0
var lastBeat = 0.0
var singAnimPlaying = false
var runOnceIFUCKINGHATETHISREADYBULLSHIT = false
var BPMWait = 0

func svgScale():
	pass




@onready var stagePositionsAccess = get_parent().get_node("stage").get_node("Positions")
func _process(delta: float) -> void:
	if runOnceIFUCKINGHATETHISREADYBULLSHIT == false:
		conductor = get_parent().get_node("UILayer/Conductor")
		runOnceIFUCKINGHATETHISREADYBULLSHIT = true
	position = stagePositionsAccess.get_node("P2").position
	$animate.play(str(conductor.currBFAnim[0]))
	if conductor.currBFAnim[1] == 1:
		conductor.currBFAnim[1] = 0
		singAnimPlaying = true
		bfSingTimer = 0.0 
		$animate.set_frame(0)
	if singAnimPlaying == true: bfSingTimer += delta
	if bfSingTimer > 1.0 and singAnimPlaying == true:
		singAnimPlaying = false
		bfSingTimer = 0.0
	if not conductor.currBeat == lastBeat:
		if conductor.BPMGLOBAL < 110:
			if singAnimPlaying == false:
				$animate.set_frame(0)
				conductor.currBFAnim[0] = "idle"
		else:
			BPMWait += 1
			if BPMWait > 1:
				if singAnimPlaying == false:
					$animate.set_frame(0)
					conductor.currBFAnim[0] = "idle"
					BPMWait = 0
		lastBeat = conductor.currBeat
	if has_node("animate-light"):
		print($"animate-light".modulate.a)
		$"animate-light".modulate.a = (get_parent().get_node("stage").get_meta("flashAmount") / 100) 
		$"animate-light".play($animate.get_animation())
		$"animate-light".frame = $animate.frame
	
	
