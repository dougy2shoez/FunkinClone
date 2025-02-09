extends Node
class_name Conductor
@onready var arrowScene = preload("res://scenes/arrow.tscn")
@onready var ratingScene = preload("res://scenes/rating.tscn")
@onready var splashScene = preload("res://scenes/noteSplash.tscn")
@onready var songType = MasterVars.songType
func _ready() -> void:
	pass
var BPMGLOBAL = MasterVars.BPMGLOBAL
@export var scrollSpeed = 0.75
@export var conductorPostion: float = (((60 / BPMGLOBAL) * -4) * 1000)
@export var timerCountDown = float(((60 / BPMGLOBAL) * -4) * 1000)
@export var conductorCount = 0
@onready var timeID = 0
@onready var noteID = 0
@onready var playingVocalsP2: bool = true
var songName = MasterVars.songName
var SongData = {}
var SongDataPath = ("res://assets/data/songs/" + str(songName) + "/" + str(songName))
func loadSongFile(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedSong = JSON.parse_string(dataFile.get_as_text())
		if parsedSong is 	Dictionary: return parsedSong
		else: print("invalid json file")
	else: print("json doesnt exist in specified directory!")

func loadMetaData(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedSong = JSON.parse_string(dataFile.get_as_text())
		if parsedSong is  Dictionary: return parsedSong
		else: print("invalid metadata!")
	else: print("doesnt exist in specified directory!")

@onready var currBFAnim = ["idle", 0, 1.0]
@onready var currDADAnim = ["idle", 0, 1.0]
@onready var currGFAnim = ["bop1", 0, 1.0]
var timeIDCOUNT: Array[int]
var noteIDCOUNT: Array[int]
@onready var HP: Array[float] = [1]
@export var notePosition0: Array[int]
@export var notePosition1: Array[int]
@export var notePosition2: Array[int]
@export var notePosition3: Array[int]
var difficulty = MasterVars.currDifficult
var hasLoadedSong = false
var songPlayData: Array
var songArrayData: Dictionary
var metaDataPath: String
var customSingAnim: String
var MetaData
var ratingPos: Array[int] = [0,1]
var rating
var players: Array = [null,null,null]
var Score: Array = [0, 0]
@onready var loadedSongData = false
@export var currBeat = -3
var currSplash = 0
var SYNCTIMER = float(0)

func _process(delta: float) -> void:
	if hasLoadedSong == false:
		print(SongDataPath)
		if songType == "": 
			metaDataPath = (str(SongDataPath) + "-metadata" + ".json")
			SongDataPath = (str(SongDataPath) + "-chart" + ".json")
		else:
			metaDataPath = (str(SongDataPath) + "-metadata"  + "-" + str(songType) + ".json")
			SongDataPath = (str(SongDataPath) + "-chart"  + "-" + str(songType) + ".json")
		SongData = loadSongFile(SongDataPath) 
		loadedSongData = true
		print(metaDataPath)
		MetaData = loadMetaData(metaDataPath)
		timerCountDown = float(((60 / BPMGLOBAL) * -4) * 1000)
		get_parent().get_parent().loadStage(MetaData["playData"]["stage"])
		get_parent().get_parent().applyCHARACTERS(MetaData["playData"]["characters"]["player"],MetaData["playData"]["characters"]["opponent"], MetaData["playData"]["characters"]["girlfriend"])
		get_parent().get_node("HealthBar/iconz").createIcon(MetaData["playData"]["characters"]["player"], MetaData["playData"]["characters"]["opponent"])
		hasLoadedSong = true
		songPlayData = SongData["notes"][difficulty]
		songArrayData = SongData["notes"][difficulty][0]
	if conductorPostion > ((60 / BPMGLOBAL) * currBeat) * 1000 - 0: 
		currBeat += 1
		if currGFAnim[0] == "bop1": currGFAnim[0] = "bop2"
		else: currGFAnim[0] = "bop1"
	if HP[0] > 2: HP[0] = 2
	if HP[0] < 0: HP[0] = 0
	if timerCountDown > 0: 
		conductorPostion += delta * 1000 * get_node("Inst").pitch_scale
		SYNCTIMER += delta
		if (1/delta) > 65:
			if SYNCTIMER > 0.5:
				if not snapped((conductorPostion/1000), 0.02) == snapped($Inst.get_playback_position(), 0.01):
					conductorPostion = $Inst.get_playback_position() * 1000
				SYNCTIMER = 0.0
		else:
			conductorPostion = $Inst.get_playback_position() * 1000
	else:
		conductorPostion =  timerCountDown 
		timerCountDown += delta * 1000 
	if not ratingPos[0] == 0:
		rating = ratingPos[0] 
		add_child(ratingScene.instantiate())
		if ratingPos[0] < 3:
			Score[1] += 1
			add_child(splashScene.instantiate())
		elif ratingPos[0] < 4: Score[1] += 1
		else: Score[1] = 0	
		ratingPos[0] = 0
	if conductorPostion > 0.1: if not $Inst.playing: get_tree().change_scene_to_file("res://scenes/resultsScene.tscn")
	if conductorCount < songPlayData.size():
		if 0 - (conductorPostion - songArrayData["t"]) / scrollSpeed < 750:
			songArrayData = SongData["notes"][difficulty][conductorCount]
			if songArrayData["d"] < 8:
				if songArrayData.has("k"): customSingAnim = songArrayData["k"]
				add_child(arrowScene.instantiate())
			conductorCount += 1
			
			
			
