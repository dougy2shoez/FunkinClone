extends Node
class_name NoteConductor
@onready var arrowScene = preload("res://scenes/arrow.tscn")
@onready var ratingScene = preload("res://scenes/rating.tscn")
@onready var splashScene = preload("res://scenes/noteSplash.tscn")
@onready var songType = MasterVars.songType
func _ready() -> void:
	noteCount = 0
	Conductor.connect("onBeatHit", onBeatHit)
	Conductor.isPlayingSong = true
	Conductor.songPosition = (((60 / BPMGLOBAL) * -4) * 1000)
var BPMGLOBAL = MasterVars.BPMGLOBAL
@export var scrollSpeed = 0.75
@export var timerCountDown = float(((60 / BPMGLOBAL) * -4) * 1000)
@export var noteCount = 0
@onready var timeID = 0
@onready var noteID = 0
@export var noteIsHittable = false
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
@onready var dirs: Array = ["LEFT", "DOWN", "UP", "RIGHT"]
var players: Array = [null,null,null]
var Score: Array = [0, 0]
@onready var loadedSongData = false
var currSplash = 0
var SYNCTIMER = float(0)
var strumisHittable: Array = [false, false, false, false]
var hasLoadedCharacters = false
@export var Dead = false
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
		if not hasLoadedCharacters:
			get_parent().get_parent().loadStage(MetaData["playData"]["stage"])
			get_parent().get_parent().applyCHARACTERS(MetaData["playData"]["characters"]["player"],MetaData["playData"]["characters"]["opponent"], MetaData["playData"]["characters"]["girlfriend"])
			get_parent().get_node("HealthBar/iconz").createIcon(MetaData["playData"]["characters"]["player"], MetaData["playData"]["characters"]["opponent"])
			hasLoadedCharacters = true
		hasLoadedSong = true
		songPlayData = SongData["notes"][difficulty]
		songArrayData = SongData["notes"][difficulty][0]
		scrollSpeed = 4 / SongData["scrollSpeed"][difficulty] - (SongData["scrollSpeed"][difficulty] * 0.28)
		MasterVars.BPMGLOBAL = MetaData["timeChanges"][0]["bpm"]
	if not Dead:
		if notePosition0.size() == 0: strumisHittable[0] = false
		elif notePosition0.size() >= 1:
			if abs(Conductor.songPosition - songPlayData[notePosition0[0]]["t"]) < 160: 
				strumisHittable[0] = true
			else:
				
				strumisHittable[0] = false
		if notePosition1.size() == 0: strumisHittable[1] = false
		elif notePosition1.size() >= 1:
			if abs(Conductor.songPosition - songPlayData[notePosition1[0]]["t"]) < 160: strumisHittable[1] = true
			else: strumisHittable[1] = false
		if notePosition2.size() == 0: strumisHittable[2] = false
		elif notePosition2.size() >= 1:
			if abs(Conductor.songPosition - songPlayData[notePosition2[0]]["t"]) < 160: strumisHittable[2] = true
			else: strumisHittable[2] = false
		if notePosition3.size() == 0: strumisHittable[3] = false
		elif notePosition3.size() >= 1:
			if abs(Conductor.songPosition - songPlayData[notePosition3[0]]["t"]) < 160: strumisHittable[3] = true
			else: strumisHittable[3] = false
		Conductor.pitchScale = $Inst.pitch_scale
		get_parent().get_parent().isPausable = true
		if HP[0] > 2: HP[0] = 2
		if HP[0] < 0: 
			HP[0] = 0
			onDeath()
			get_parent().get_parent().initDeath()
		if timerCountDown > 0: 
			SYNCTIMER += delta
			if SYNCTIMER > 1:
				if not snapped((Conductor.songPosition/1000), 0.02) == snapped($Inst.get_playback_position(), 0.01):
					Conductor.songPosition = $Inst.get_playback_position() * 1000
				SYNCTIMER = 0.0
		else:	
			Conductor.songPosition = timerCountDown 
			timerCountDown += delta * 1000 
		if not ratingPos[0] == 0:
			rating = ratingPos[0] 
			add_child(ratingScene.instantiate())
			
			if ratingPos[0] < 4: Score[1] += 1
			else: Score[1] = 0	
			ratingPos[0] = 0
		if Conductor.songPosition > 5: if not $Inst.playing and not Dead:
			if not MasterVars.isStoryMode: get_tree().change_scene_to_file("res://scenes/resultsScene.tscn")
			else:
				if MasterVars.songsPlaylistPos < MasterVars.songsPlaylist.size():
					timerCountDown = float(((60 / BPMGLOBAL) * -4) * 1000)
					MasterVars.songsPlaylistPos += 1
					MasterVars.songName = MasterVars.songsPlaylist[MasterVars.songsPlaylistPos] 
					timeID = 0
					noteID = 0
					noteIsHittable = false
					playingVocalsP2 = true
					songName = MasterVars.songName
					SongData = {}
					get_parent().get_parent().get_node("gameCam").getEventData = false
					get_parent().get_parent().get_node("gameCam").eventCount = 0
					SongDataPath = ("res://assets/data/songs/" + str(songName) + "/" + str(songName))
					currBFAnim = ["idle", 0, 1.0]
					currDADAnim = ["idle", 0, 1.0]
					currGFAnim = ["bop1", 0, 1.0]
					timeIDCOUNT.clear()
					noteIDCOUNT.clear()
					HP = [1]
					notePosition0.clear()
					notePosition1.clear()
					notePosition2.clear()
					notePosition3.clear()
					difficulty = MasterVars.currDifficult
					hasLoadedSong = false
					songPlayData = []
					songArrayData = {}
					metaDataPath = ""
					customSingAnim = ""
					noteCount = 0
					MetaData = {}
					Score = [0, 0]
					loadedSongData = false
					SYNCTIMER = float(0)
					$Inst.readySong = false
					$VoicesBF.readySong = false
					$VoicesDAD.readySong = false
					$Inst.playSong = false
					$VoicesBF.playSong = false
					$VoicesDAD.playSong = false
		print(songPlayData)
		if noteCount < songPlayData.size():
			if 0 - (Conductor.songPosition - songArrayData["t"]) / scrollSpeed < 750:
				songArrayData = SongData["notes"][difficulty][noteCount]
				if songArrayData["d"] < 8: 
					if songArrayData.has("k"): customSingAnim = songArrayData["k"]
					else: customSingAnim = ""
					add_child(arrowScene.instantiate())
				noteCount += 1
	else: get_parent().get_parent().isPausable = false
func onBeatHit():
	if currGFAnim[0] == "bop1": currGFAnim[0] = "bop2"
	else: currGFAnim[0] = "bop1"
func onDeath():
	Conductor.isPlayingSong = false
	Dead = true
	notePosition0.clear()
	notePosition1.clear()
	notePosition2.clear()
	notePosition3.clear()
	Conductor.songPosition = float(((60 / BPMGLOBAL) * -4) * 1000)
	timerCountDown = float(((60 / BPMGLOBAL) * -4) * 1000)
	noteCount = 0
	HP[0] = 1
	timeID = 0
	noteID = 0
	songArrayData = SongData["notes"][difficulty][0]
	playingVocalsP2 = true
	$Inst.playing = false
	$VoicesBF.playing = false
	$VoicesDAD.playing = false
	for i in get_child_count():
		if get_child(i).name.contains("Arrow"):
			get_child(i).queue_free()
