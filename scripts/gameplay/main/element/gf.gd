extends Node2D
@onready var stagePositionsAccess = get_parent().get_node("stage").get_node("Positions")
@onready var stageExists = get_parent().has_node("stage")
func _ready() -> void:
	$animate.use_parent_material = true
	use_parent_material = true
	name = "gf" # NECESSARY for the camera to reference!!
	print(get_parent().stageData)
	z_index = get_parent().stageData["characters"]["gf"]["zIndex"]

var runOnce = false
var noteConductor
@onready var hueChange
func _process(delta: float) -> void:
	if stageExists: if stagePositionsAccess.has_node("GF"): position = stagePositionsAccess.get_node("GF").position
	if runOnce == false:
		noteConductor = get_parent().get_node("UILayer/NoteConductor")
		if not get_parent().hueChangeAll:
			use_parent_material = false
			material = ShaderMaterial.new()
			material.shader = get_parent().material.shader
			hueChange = get_parent().hueChange
			material.set_shader_parameter("hue", hueChange["gf"][0])
			material.set_shader_parameter("saturation", hueChange["gf"][1])
			material.set_shader_parameter("brightness", hueChange["gf"][2])
			material.set_shader_parameter("contrast", hueChange["gf"][3])
		runOnce = true
	if has_node("animate"):
		$animate.play(str(noteConductor.currGFAnim[0]))
	else:
		$animateatlas.symbol = (str(noteConductor.currGFAnim[0]))
		$animateatlas.playing = true
