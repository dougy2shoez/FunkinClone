extends Node2D


func _ready() -> void:
	pass 


var selectorAnim = [[false, 0.0], [false, 0.0]]
var difficultySelect = 0
@onready var difficulties = get_parent().difficulties
func _process(delta: float) -> void:
	if (difficultySelect > 4): difficultySelect = 0 
	elif (difficultySelect < 0): difficultySelect = 4 
	MasterVars.currDifficult = difficulties[difficultySelect]
	if MasterVars.currDifficult == "erect" or MasterVars.currDifficult == "nightmare": 
		MasterVars.songType = "erect"
	else: 
		MasterVars.songType = ""
	$difficulty.play(str(MasterVars.currDifficult))
	
	if Input.is_action_just_pressed("ui_left"):
		difficultySelect -= 1
		
	elif Input.is_action_just_pressed("ui_right"):
		difficultySelect += 1
