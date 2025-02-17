extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Conductor.connect("onBeatHit", onBeatHit)
	$animate.use_parent_material = true
	use_parent_material = true
	print(get_parent())
	z_index = get_parent().stageData["characters"]["dad"]["zIndex"]
	name = "dad" # NECESSARY for the camera to reference!!
var noteConductor
var dadSingTimer = 0.0
var lastBeat = 0.0
var runOnce = false
var BPMWait = 0
@onready var hueChange
var singAnimPlaying = false
@onready var stageExists = get_parent().has_node("stage")
@onready var stagePositionsAccess = get_parent().get_node("stage").get_node("Positions")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if runOnce == false:
		noteConductor = get_parent().get_node("UILayer/NoteConductor")
		if not get_parent().hueChangeAll:
			use_parent_material = false
			material = ShaderMaterial.new()
			material.shader = get_parent().material.shader
			hueChange = get_parent().hueChange
			material.set_shader_parameter("hue", hueChange["dad"][0])
			material.set_shader_parameter("saturation", hueChange["dad"][1])
			material.set_shader_parameter("brightness", hueChange["dad"][2])
			material.set_shader_parameter("contrast", hueChange["dad"][3])
		runOnce = true
	if stageExists: if stagePositionsAccess.has_node("P1"): position = stagePositionsAccess.get_node("P1").position
	$animate.play(str(noteConductor.currDADAnim[0]))
	if noteConductor.currDADAnim[1] == 1:
		noteConductor.currDADAnim[1] = 0
		singAnimPlaying = true
		dadSingTimer = 0.0 
		$animate.set_frame(0)
	if singAnimPlaying == true: dadSingTimer += delta
	if dadSingTimer > noteConductor.currDADAnim[2] and singAnimPlaying == true:
		singAnimPlaying = false
		dadSingTimer = 0.0
func onBeatHit():
	if noteConductor.BPMGLOBAL < 110:
		if singAnimPlaying == false:
			$animate.set_frame(0)
			noteConductor.currDADAnim[0] = "idle"
	else:
		BPMWait += 1
		if BPMWait > 1:
			if singAnimPlaying == false:
				$animate.set_frame(0)
				noteConductor.currDADAnim[0] = "idle"
				BPMWait = 0
