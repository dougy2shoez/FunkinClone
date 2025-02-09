extends Node2D


func _ready() -> void:
	pass 


var selectorAnim = [[false, 0.0], [false, 0.0]]
var difficultySelect = 0
@onready var difficulties = get_parent().difficulties
func _process(delta: float) -> void:
	if MasterVars.currCharacter == "bf":
		if (difficultySelect > 4): difficultySelect = 0 
		elif (difficultySelect < 0): difficultySelect = 4 
		if MasterVars.currDifficult == "erect" or MasterVars.currDifficult == "nightmare": 
			MasterVars.songType = "erect"
	else:
		if (difficultySelect > 2): difficultySelect = 0 
		elif (difficultySelect < 0): difficultySelect = 2 
	MasterVars.currDifficult = difficulties[difficultySelect]
	$difficulty.play(str(MasterVars.currDifficult))
	if Input.is_action_just_pressed("ui_left"):
		get_parent().get_node("musicFreeplay").play()
		difficultySelect -= 1
		
	elif Input.is_action_just_pressed("ui_right"):
		get_parent().get_node("musicFreeplay").play()
		difficultySelect += 1
