extends Node2D

func _ready() -> void:
	pass 
	
func focusCharacter(charFocus: int):
	# if stageExists:
	if charFocus == 1:
		position = get_parent().get_node("stage").get_node("Positions").get_node("P1").get_node("cameraPos").position + get_parent().get_node("stage").get_node("Positions").get_node("P1").position + get_parent().get_node("dad").get_node("cameraPos").position
	elif charFocus == 0:
		position = get_parent().get_node("stage").get_node("Positions").get_node("P2").get_node("cameraPos").position + get_parent().get_node("stage").get_node("Positions").get_node("P2").position + get_parent().get_node("bf").get_node("cameraPos").position
	elif charFocus == 2:
		position = get_parent().get_node("stage").get_node("Positions").get_node("GF").get_node("cameraPos").position + get_parent().get_node("stage").get_node("Positions").get_node("GF").position + get_parent().get_node("gf").get_node("cameraPos").position

func eventsDict(EventData: Dictionary):
	match EventData["e"]:
		"FocusCamera":
			print(EventData["v"])
			if EventData["v"] is Dictionary: focusCharacter(int(EventData["v"]["char"]))
			else: focusCharacter(EventData["v"])
		"ZoomCamera":
			camZoom = EventData["v"]["zoom"] * get_parent().stageData["cameraZoom"]
		"PlayAnimation":
			if eventData[eventCount]["v"]["target"] == "boyfriend":
				conductorNode.currBFAnim[1] = 1
				conductorNode.currBFAnim[0] = (EventData["v"]["anim"])
			elif eventData[eventCount]["v"]["target"] == "dad":
				conductorNode.currDADAnim[1] = 1
				conductorNode.currDADAnim[0] = (EventData["v"]["anim"])
		"SetCameraBop":
			get_parent().get_node("UILayer").camBop[1] = EventData["v"]["rate"]
			get_parent().get_node("UILayer").camBop[0] = EventData["v"]["intensity"]




@onready var stageExists = get_parent().has_node("stage")
var eventData: Array = []
var getEventData = false
var eventCount = 0
var camZoom = 1
var bfOffset: Array = [0,0]
var dadOffset: Array = [0,0]
@onready var conductorNode = get_parent().get_node("UILayer/NoteConductor")
func _process(delta: float) -> void:
	if name ==  "gameCam":
		if not getEventData and conductorNode.loadedSongData:
			eventData = conductorNode.SongData["events"]
			getEventData = true
			camZoom = get_parent().stageData["cameraZoom"]
			print(eventData) 
			bfOffset = get_parent().stageData["characters"]["bf"]["cameraOffsets"]
			dadOffset = get_parent().stageData["characters"]["dad"]["cameraOffsets"]
			position = get_parent().get_node("stage").get_node("Positions").get_node("GF").get_node("cameraPos").position + get_parent().get_node("stage").get_node("Positions").get_node("GF").position + get_parent().get_node("gf").get_node("cameraPos").position
		if getEventData:
			$".".zoom.x += (camZoom - $".".zoom.x)/(0.5/delta)
			$".".zoom.y += (camZoom - $".".zoom.y)/(0.5/delta)
			if eventCount < eventData.size():
				if Conductor.songPosition > eventData[eventCount]["t"]:
					print(Conductor.songPosition)
					eventsDict(eventData[eventCount])
					eventCount += 1
	elif name == "menuCam":
		pass
