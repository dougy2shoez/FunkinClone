extends Node
signal onBeatHit
signal onStepHit
signal onMeasureHit
var currMeasure: int = 0
var currBeat: int = 0
var currStep: int = 0
var oldMeasure: int = 0 
var oldStep: int = 0
var oldBeat: int = 0  
var pitchScale: float = 1.0
var currMeasureTime: float = 0
var currBeatTime: float = 0
var currStepTime: float = 0
var songPosition: float = 0
var stepLengthMs: float = ((60.0/MasterVars.BPMGLOBAL) * 1000 / 16.0)
var isPlayingSong = false
func _process(delta: float) -> void:
	if isPlayingSong: 
		stepLengthMs = ((60.0/MasterVars.BPMGLOBAL) * 1000 / 16.0)
		songPosition += delta * 1000 * pitchScale
	currStepTime = (songPosition / stepLengthMs)
	currBeatTime = currStepTime / 16.0
	currMeasureTime = currStepTime / 64.0
	currStep = floor(currStepTime)
	currBeat = floor(currBeatTime)
	currMeasure = floor(currMeasureTime)
	if (currStep != oldStep):
		onStepHit.emit()
		oldStep = currStep
	if (currBeat != oldBeat):
		onBeatHit.emit()
		oldBeat = currBeat
	if (currMeasure != oldMeasure):
		onMeasureHit.emit()
		oldMeasure = currMeasure
func reSyncSongPos(time: float):
	songPosition = time
