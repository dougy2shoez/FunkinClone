extends Node2D
@onready var strumAnim = get_parent().get_parent()
@onready var childSprite = $AnimatedSprite2D
@onready var sustainScene = preload("res://scenes/sustain.tscn")
func _ready() -> void:
	name = "Arrow" + str(noteCount)
	position.y = -999999
@onready var songArrayData = get_parent().songArrayData
@onready var Score = get_parent().Score
@onready var dirs: Array = ["LEFT", "DOWN", "UP", "RIGHT"]
@onready var noteCount = get_parent().noteCount
@onready var timeID = float(songArrayData["t"])
@onready var noteID = int(songArrayData["d"])
var idArray: Array[int] = [0]
var wasHit = false
var wasHitConditionCheck = 0
var checkRUNONCE = true
var yID = 0
var stnID = 0
var stnName = "new"
var timerNoteAnim = 0
var enemyAnimTime = .25
var yTeleport = 0
var missAnim = false
var oneTimeRun = false
var currBFAnim
var currDADAnim
var dadSing = false
@onready var scrollSpeed = get_parent().scrollSpeed
var HP: Array[float] = [1]
var loopAnimArrow: Array = [false, false, false, false]
var sustainFinish = false
var noteKind: String = ""
@onready var rating = get_parent().ratingPos
func calculateYPos(vwoosh:bool = true):
	return 0.45 * Conductor.songPosition - timeID - (0) * scrollSpeed * 1 * (1)


func calculateRating(msOff: float, rating: Array):
	msOff = abs(msOff)
	if  msOff < 15:
		rating[0] = 1 
		MasterVars.songStats["rating"]["sick"] += 1
	elif msOff < 45:
		rating[0] = 2
		MasterVars.songStats["rating"]["sick"] += 1
	elif msOff < 90:
		rating[0] = 3
		MasterVars.songStats["rating"]["good"] += 1
	elif msOff < 135:
		rating[0] = 4
		MasterVars.songStats["rating"]["bad"] += 1
	elif msOff < 160:
		rating[0] = 5
		MasterVars.songStats["rating"]["shit"] += 1
func _process(delta: float) -> void:
	z_index = 300
	if noteID < 4 : 
		if checkRUNONCE: # so it doesnt slow it down by assigning each frame
			if noteID == 0: idArray = get_parent().notePosition0
			elif noteID == 1: idArray = get_parent().notePosition1
			elif noteID == 2: idArray = get_parent().notePosition2
			elif noteID == 3: idArray = get_parent().notePosition3
			strumAnim = get_parent().get_parent().get_node("Strum" + str(int(noteID)))
			noteKind = get_parent().customSingAnim
			idArray.append(noteCount)
			childSprite.play(str(int(noteID))) 
			currBFAnim = get_parent().currBFAnim
			HP = get_parent().HP
			if songArrayData.has("l"):
				if songArrayData["l"] > 0:
					for i in ((songArrayData["l"] / 7.5)) / scrollSpeed - 1:
						yID = i
						stnID = noteID + 1
						stnName = "hold"
						add_child(sustainScene.instantiate())
					stnName = "end"
					yID += 1
					add_child(sustainScene.instantiate())
					
					
			checkRUNONCE = false
			
		position.x =  (111.5 * (noteID))
		position.y = (timeID - Conductor.songPosition) / scrollSpeed + yTeleport
		if get_parent().Dead:
			Conductor.isPlayingSong = false
			queue_free()
		if Conductor.songPosition - timeID > -159.9 * wasHitConditionCheck * 9999999 - 159.9 and Conductor.songPosition - timeID < 160 * wasHitConditionCheck * 9999999 + 160:
			
			if Input.is_action_just_pressed("" + str(int(noteID))):
				if idArray[0] == noteCount:
					childSprite.play("blankState")
					wasHit = true

					strumAnim.childSprite.play(str(int(noteID)) + "_confirm")
					get_parent().currSplash = noteID
					currBFAnim[1] = 1
					currBFAnim[2] = 1.0
					currBFAnim[0] = ("sing" + str(dirs[noteID]))
					if songArrayData.has("l"):
						if songArrayData["l"] > 0:
							strumAnim.coverSprite.play(str(int(noteID)) + "_loop")
			if wasHit:
				if strumAnim.childSprite.animation == (str(int(noteID)) + "_confirm"): currBFAnim[2] += 2.0
				if not oneTimeRun: 
					if Conductor.songPosition - timeID < 0: yTeleport = 0 - position.y
					get_parent().playingVocalsP2 = true
					HP[0] += 0.035 - abs((Conductor.songPosition - timeID) * 0.0004)
					rating[1] = int(noteID)
					calculateRating(abs(Conductor.songPosition - timeID), get_parent().ratingPos)
					if abs(Conductor.songPosition - timeID) < 6: 
						get_parent().get_parent().get_parent().get_node("info").get_node("Score2").text = "+" + str(500 + Score[1])
						Score[0] += 500 + (Score[1] / 1.5)
					else: 
						get_parent().get_parent().get_parent().get_node("info").get_node("Score2").text = "+" + str(519.2 - (abs(Conductor.songPosition - timeID) * 3.2) + Score[1])
						Score[0] += 519.2 - (abs(Conductor.songPosition - timeID) * 3.2) + (Score[1] / 2)
					oneTimeRun = true
					
				wasHitConditionCheck = 999
				if songArrayData.has("l"): 
					if songArrayData["l"] > 0:
						if not sustainFinish:
							strumAnim.childSprite.play(str(int(noteID)) + "_confirm")
							if strumAnim.childSprite.get_frame() > 3:
								strumAnim.childSprite.set_frame(0)
						else: strumAnim.childSprite.play(str(int(noteID)) + "_press")
				else: strumAnim.childSprite.play(str(int(noteID)) + "_confirm")
				if not sustainFinish:
					strumAnim.childSprite.play(str(int(noteID)) + "_confirm")
				if Input.is_action_just_released("" + str(int(noteID))):
					idArray.erase(noteCount)
					currBFAnim[2] = 1.0
					queue_free()
		elif Conductor.songPosition - timeID > 161:
			idArray.erase(noteCount)
			if not missAnim:
				currBFAnim[0] = ("sing" + str(dirs[noteID]) + "Miss")
				currBFAnim[1] = 1
				$MissSound.playMissSound()
				get_parent().Score[1] = 0
				if not HP[0] == 0:
					HP[0] =  HP[0] - 0.075
				Score[0] -= 10
				MasterVars.songStats["rating"]["missed"] += 1
				get_parent().playingVocalsP2 = false
				missAnim = true
			if position.y < -500:
				queue_free()
	else: 
		if checkRUNONCE:
			strumAnim = get_parent().get_parent().get_node("Strum" + str(int(noteID)))
			position.x =  (111.5 * (noteID - 3)) - 751
			noteKind = get_parent().customSingAnim
			childSprite.play(str(int(noteID) - 4)) 
			checkRUNONCE = false
			currDADAnim = get_parent().currDADAnim
			if songArrayData.has("l"):
				if songArrayData["l"] > 0:
					for i in (songArrayData["l"] / 7.5) / scrollSpeed - 1:
						yID = i
						stnID = noteID + 1
						stnName = "hold"
						add_child(sustainScene.instantiate())
					stnName = "end"
					yID += 1
					add_child(sustainScene.instantiate())
		position.y = 0 - (Conductor.songPosition - timeID) / scrollSpeed
		if (Conductor.songPosition - timeID) > 0:
			if songArrayData.has("l"):
				if songArrayData["l"] > 0:
					strumAnim.childSprite.play(str(int(noteID - 4)) + "_confirm")
					if strumAnim.childSprite.get_frame() > 3:
						strumAnim.childSprite.set_frame(0)
				else: strumAnim.childSprite.play(str(int(noteID - 4)) + "_confirm")
			else: strumAnim.childSprite.play(str(int(noteID - 4)) + "_confirm")
			if not dadSing:
				if noteKind == "": currDADAnim[0] = ("sing" + str(dirs[noteID - 4]))
				else: currDADAnim[0] = ("sing" + str(dirs[noteID - 4]) + "-" + noteKind)
				currDADAnim[1] = 1
				dadSing = true
			childSprite.play("blankState")
			timerNoteAnim += delta
			if songArrayData.has("l"):
				enemyAnimTime = ((songArrayData["l"])/ 1000)
				currDADAnim[2] = ((songArrayData["l"])/ 1000) + 1.0
				if songArrayData["l"] > 0: strumAnim.coverSprite.play(str(int(noteID) - 4) + "_loop")
				else: 
					enemyAnimTime = .25
					currDADAnim[2] = 1.0
			else:
				enemyAnimTime = .25
				currDADAnim[2] = 1.0
			if timerNoteAnim > enemyAnimTime:
				strumAnim.childSprite.play(str(int(noteID) - 4))
				strumAnim.coverSprite.play("blankState")
				queue_free()
