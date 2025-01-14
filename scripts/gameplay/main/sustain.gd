extends Node2D
@onready var ArrowOrigin = get_parent().get_parent().get_parent()
@onready var noteID = int(ArrowOrigin.noteID)
@onready var stnName = ArrowOrigin.stnName
@onready var yID = ArrowOrigin.yID
@onready var childSprite = $AnimatedSprite2D
@onready var Score = ArrowOrigin.Score

func _ready() -> void:
	if stnName == "end":
		name = ("endSustainNode") 
	if noteID > 3: childSprite.play(str(noteID - 4)+ "_" + str(stnName))
	else: childSprite.play(str(noteID)+ "_" + str(stnName))
	
var queueDelete = 0
var HP: Array[float] 
var hpSet = false
@onready var animLoop = ArrowOrigin.loopAnimArrow
func _process(delta: float) -> void:
	z_index = -1
	if noteID > 3:
		position.x =  358 
		position.y = (15 * yID) + 100 
		if ArrowOrigin.position.y + (position.y * .5) < 54:
			queue_free()
	else:
		if hpSet == false:
			HP = ArrowOrigin.HP
			hpSet = true
		if ArrowOrigin.position.y + (position.y * .49) < 54  and ArrowOrigin.wasHit == true and Input.is_action_pressed(("" + str(noteID))):
			if stnName == "end":
				queueDelete = 1
				animLoop[noteID] = true
				ArrowOrigin.strumAnim.childSprite.play(str(noteID) + "_press")
				ArrowOrigin.strumAnim.coverSprite.play(str(noteID) + "_end")
				ArrowOrigin.sustainFinish = true 
			HP[0] = HP[0] + 0.0015
			Score[0] = Score[0] + 10
			animLoop[noteID] = false
			queue_free()
		if ArrowOrigin.wasHit == true and Input.is_action_just_released(("" + str(noteID))):
			queue_free()
		position.x =  358
		position.y = (15 * yID) + 100
		
