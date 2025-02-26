extends Node2D


func _ready() -> void:
	$animate.use_parent_material = true
	use_parent_material = true
	InitDeathScn()	
	name = "bf" # NECESSARY for the camera to reference!!
	print(get_parent())
	z_index = get_parent().stageData["characters"]["bf"]["zIndex"]
var noteConductor
var bfSingTimer = 0.0
var lastBeat = 0.0
var singAnimPlaying = false
var runOnce = false
var BPMWait = 0

func svgScale():
	
	pass

func InitDeathScn():
	if FileAccess.file_exists("res://scenes/gameplay/characters/deathScenes/" + MasterVars.currCharacter + ".tscn"):
		add_child(load("res://scenes/gameplay/characters/deathScenes/" + MasterVars.currCharacter + ".tscn").instantiate())
	else: 
		add_child(preload("res://scenes/gameplay/characters/deathScenes/bf.tscn").instantiate())

@onready var hueChange
@onready var stagePositionsAccess = get_parent().get_node("stage").get_node("Positions")
@onready var stageExists = get_parent().has_node("stage")
func _process(delta: float) -> void:
	if not has_node("deathCharScn"):
		InitDeathScn()
	if runOnce == false:
		noteConductor = get_parent().get_node("UILayer/NoteConductor")
		Conductor.connect("onBeatHit", onBeatHit)
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
	$animate.play(str(noteConductor.currBFAnim[0]))
	if noteConductor.currBFAnim[1] == 1:
		noteConductor.currBFAnim[1] = 0
		singAnimPlaying = true
		bfSingTimer = 0.0 
		$animate.set_frame(0)
	if singAnimPlaying == true: bfSingTimer += delta
	if bfSingTimer > noteConductor.currBFAnim[2] and singAnimPlaying == true:
		singAnimPlaying = false
		bfSingTimer = 0.0
	if has_node("animate-light"):
		print($"animate-light".modulate.a)
		$"animate-light".modulate.a = (get_parent().get_node("stage").get_meta("flashAmount") / 100) 
		$"animate-light".play($animate.get_animation())
		$"animate-light".frame = $animate.frame
func onBeatHit():
	if MasterVars.BPMGLOBAL < 110:
		if singAnimPlaying == false:
			$animate.set_frame(0)
			noteConductor.currBFAnim[0] = "idle"
	else:
		BPMWait += 1
		if BPMWait > 1:
			if singAnimPlaying == false:
				$animate.set_frame(0)
				noteConductor.currBFAnim[0] = "idle"
				BPMWait = 0
