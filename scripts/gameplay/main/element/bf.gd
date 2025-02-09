extends Node2D


func _ready() -> void:
	$animate.use_parent_material = true
	use_parent_material = true
	name = "bf" # NECESSARY for the camera to reference!!
	print(get_parent())
	z_index = get_parent().stageData["characters"]["bf"]["zIndex"]
var conductor
var bfSingTimer = 0.0
var lastBeat = 0.0
var singAnimPlaying = false
var runOnce = false
var BPMWait = 0

func svgScale():
	
	pass



@onready var hueChange
@onready var stagePositionsAccess = get_parent().get_node("stage").get_node("Positions")
@onready var stageExists = get_parent().has_node("stage")
func _process(delta: float) -> void:
	if runOnce == false:
		conductor = get_parent().get_node("UILayer/Conductor")
		if not get_parent().hueChangeAll:
			use_parent_material = false
			material = ShaderMaterial.new()
			material.shader = get_parent().material.shader
			hueChange = get_parent().hueChange
			material.set_shader_parameter("hue", hueChange["bf"][0])
			material.set_shader_parameter("saturation", hueChange["bf"][1])
			material.set_shader_parameter("brightness", hueChange["bf"][2])
			material.set_shader_parameter("contrast", hueChange["bf"][3])
		runOnce = true
		
	if stageExists: if stagePositionsAccess.has_node("P2"): position = stagePositionsAccess.get_node("P2").position
	$animate.play(str(conductor.currBFAnim[0]))
	if conductor.currBFAnim[1] == 1:
		conductor.currBFAnim[1] = 0
		singAnimPlaying = true
		bfSingTimer = 0.0 
		$animate.set_frame(0)
	if singAnimPlaying == true: bfSingTimer += delta
	if bfSingTimer > conductor.currBFAnim[2] and singAnimPlaying == true:
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
	
	
