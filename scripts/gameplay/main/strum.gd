extends Node2D
@onready var strumID = get_parent().strumID
@onready var childSprite = $strumAnim
@onready var coverSprite = $sustainAnim
@onready var conductorNode = get_parent().get_node("Conductor")
@onready var enemyStrum = get_parent().enemyStrum
func _ready() -> void:
	coverSprite.play("blankState")
	if enemyStrum == 0:
		position.x =  (111.5 * (strumID + 1))
		childSprite.play("" + str(strumID + 1)) 
		name = ("Strum" + str(strumID + 1)) 
	else:
		position.x =  (111.5 * (strumID + 2)) - 751
		childSprite.play("" + str(strumID + 1)) 
		name = ("Strum" + str(strumID + 5)) 

func _process(delta: float) -> void:
	if enemyStrum == 0:
		if Input.is_action_just_pressed(str(strumID + 1)):
			childSprite.play(str(strumID + 1) + "_press")
		elif Input.is_action_just_released("" + str(strumID + 1)) or not Input.is_action_pressed("" + str(strumID + 1)):
			childSprite.play("" + str(strumID + 1)) 
			if not coverSprite.animation == (str(strumID + 1) + "_end"):
				coverSprite.play("blankState")
	else:
		pass
	
