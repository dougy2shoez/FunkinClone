extends Node2D
@onready var ArrowOrigin = get_parent().get_parent().get_parent()
@onready var noteID = int(ArrowOrigin.noteID)
@onready var stnName = ArrowOrigin.stnName
@onready var yID = ArrowOrigin.yID
@onready var childSprite = $AnimatedSprite2D
@onready var Score = ArrowOrigin.Score

func _ready() -> void:
	position = Vector2(9999,9999)
	$AnimatedSprite2D.z_index = 25
	scale = Vector2(0.7,0.7)
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
		get_parent().clip_contents = true
		position.x = ArrowOrigin.position.x - 10
		position.y = (6.5 * yID) + 100 + ArrowOrigin.position.y - 100
		if stnName == "end":
			ArrowOrigin.sustainFinish = true 
		if position.y < -35:
			queue_free()
	else:
		if hpSet == false:
			HP = ArrowOrigin.HP
			hpSet = true
		if ArrowOrigin.wasHit: get_parent().clip_contents = true
		if position.y < -35 and ArrowOrigin.wasHit and Input.is_action_pressed(("" + str(noteID))):
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
		if stnName == "end":
			position.x = ArrowOrigin.position.x - 9
			position.y = (6.5 * yID) + 100 + ArrowOrigin.position.y - 90
		else:
			position.x = ArrowOrigin.position.x - 10
			position.y = (6.5 * yID) + 100 + ArrowOrigin.position.y - 100
		
