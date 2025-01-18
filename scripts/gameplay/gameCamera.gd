extends Node2D


func _ready() -> void:
	pass 
	
func focusCharacter(charFocus: int):
	if charFocus == 1:
		position = get_parent().get_node("stage").get_node("Positions").get_node("P1").get_node("cameraPos").position + get_parent().get_node("stage").get_node("Positions").get_node("P1").position
	elif charFocus == 0:
		position = get_parent().get_node("stage").get_node("Positions").get_node("P2").get_node("cameraPos").position + get_parent().get_node("stage").get_node("Positions").get_node("P2").position
	elif charFocus == 2:
		position = get_parent().get_node("stage").get_node("Positions").get_node("GF").get_node("cameraPos").position + get_parent().get_node("stage").get_node("Positions").get_node("GF").position







var eventData: Array = []
var getEventData = false
var conductorPosition = 0
var eventCount = 0
var camZoom = 1
var bfOffset: Array = [0,0]
var dadOffset: Array = [0,0]
@onready var conductorNode = get_parent().get_node("UILayer/Conductor")
func _process(delta: float) -> void:
	if name ==  "gameCam":
		if getEventData == false and conductorNode.loadedSongData == true:
			eventData = conductorNode.SongData["events"]
			getEventData = true
			camZoom = get_parent().stageData["cameraZoom"]
			print(eventData)
			bfOffset = get_parent().stageData["characters"]["bf"]["cameraOffsets"]
			dadOffset = get_parent().stageData["characters"]["dad"]["cameraOffsets"]
		if getEventData == true:
			conductorPosition = conductorNode.conductorPostion
			$".".zoom.x += (camZoom - $".".zoom.x)/(0.5/delta)
			$".".zoom.y += (camZoom - $".".zoom.y)/(0.5/delta)
			if eventCount < eventData.size():
				if conductorPosition > eventData[eventCount]["t"]:
					print(conductorPosition)
					if eventData[eventCount]["e"] == "FocusCamera":
						if eventData[eventCount]["v"] is Dictionary: focusCharacter(int(eventData[eventCount]["v"]["char"]))
						else: focusCharacter(eventData[eventCount]["v"])
					elif eventData[eventCount]["e"] == "ZoomCamera":
						camZoom = eventData[eventCount]["v"]["zoom"] * get_parent().stageData["cameraZoom"]
					elif eventData[eventCount]["e"] == "PlayAnimation":
						if eventData[eventCount]["v"]["target"] == "boyfriend":
							conductorNode.currBFAnim[1] = 1
							conductorNode.currBFAnim[0] = (eventData[eventCount]["v"]["anim"])
						elif eventData[eventCount]["v"]["target"] == "dad":
							conductorNode.currDADAnim[1] = 1
							conductorNode.currDADAnim[0] = (eventData[eventCount]["v"]["anim"])
					eventCount += 1
	elif name == "menuCam":
		pass
