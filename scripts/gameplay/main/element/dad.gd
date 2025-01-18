extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$animate.use_parent_material = true
	use_parent_material = true
	print(get_parent())
	name = "dad"
	pass # Replace with function body.
var conductor
var dadSingTimer = 0.0
var lastBeat = 0.0
var runOnceIFUCKINGHATETHISREADYBULLSHIT = false
var BPMWait = 0
var singAnimPlaying = false
@onready var stagePositionsAccess = get_parent().get_node("stage").get_node("Positions")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if runOnceIFUCKINGHATETHISREADYBULLSHIT == false:
		conductor = get_parent().get_node("UILayer/Conductor")
		runOnceIFUCKINGHATETHISREADYBULLSHIT = true
	position = stagePositionsAccess.get_node("P1").position
	$animate.play(str(conductor.currDADAnim[0]))
	if conductor.currDADAnim[1] == 1:
		conductor.currDADAnim[1] = 0
		singAnimPlaying = true
		dadSingTimer = 0.0
		$animate.set_frame(0)
	if not $animate.get_animation() == "idle": dadSingTimer += delta
	if dadSingTimer > 1.0: 
		conductor.currDADAnim[0] = "idle"
		singAnimPlaying = false
		dadSingTimer = 0.0
	if $animate.get_animation() == "idle":
		if not conductor.currBeat == lastBeat:
			lastBeat = conductor.currBeat
			if conductor.BPMGLOBAL < 110:
				if singAnimPlaying == false:
					$animate.set_frame(0)
			else:
				BPMWait += 1
				if BPMWait > 1:
					if singAnimPlaying == false:
						$animate.set_frame(0)
					BPMWait = 0
