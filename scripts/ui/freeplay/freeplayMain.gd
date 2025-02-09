extends Node2D

@onready var capsuleScene = preload("res://scenes/freeplayCapsule.tscn")
@onready var currSelect = 1
@onready var sounds: Dictionary = {"scroll": preload("res://assets/sounds/scrollMenu.ogg"), "confirm": preload("res://assets/sounds/confirmMenu.ogg")}
@onready var IDCapsule = 0
var difficulties: Array = ["normal","hard","erect","nightmare","easy"]
@onready var levelsData: Array
@onready var erasedSongs: Array
@onready var currHiScore = 0
@onready var currHiScoreSmooth = 0
@onready var currHiScoreDisplay = "0000000"
@onready var killAllCapsules = false

# 45 x difference
func loadJsonData(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedSong = JSON.parse_string(dataFile.get_as_text())
		if parsedSong is  Dictionary: return parsedSong
		else: print("invalid metadata!")
	else: print("doesnt exist in specified directory!")

func loadCapsules():
	killAllCapsules = false
	var songID
	var capsuleSpawned = false
	IDCapsule = null 
	add_child(capsuleScene.instantiate())
	IDCapsule = 1
	for i in songList.size():
		print(IDCapsule)
		print(songList.size())
		capsuleSpawned = false
		songID = songList[IDCapsule - 1]
		baseSongMetadata = loadJsonData("res://assets/data/songs/" + str(songID) + "/" + str(songID) + "-metadata.json")
		print(baseSongMetadata)
		add_child(capsuleScene.instantiate())
		IDCapsule += 1 
		capsuleSpawned = true
		
var currLevelIndex = 0
var lengthSongs = 0
var countINDEX = 0
var songList: Array
var baseSongMetadata
var levelDir = DirAccess.get_files_at("res://assets/data/levels")
func _ready() -> void:
	if MasterVars.currCharacter == "bf": MasterVars.songType = ""
	else: MasterVars.songType = MasterVars.currCharacter
	for i in levelDir.size():
		var levelData = loadJsonData("res://assets/data/levels/" + str(levelDir[i]))
		for ia in levelData["songs"].size():
			songList.append(levelData["songs"][ia])
	print(songList)
	$transition.play("freeplayTransition")
	
	



func reverse_string(s:String) -> String:
	var r := "" 
	for i in range(s.length()-1, -1, -1):
		r += s[i]
	return r
# ^^^ thankz u/Robert_Bobbinson for da code luv u


func scrollMenu():
	$soundsFreeplay.stream = sounds["scroll"]
	$soundsFreeplay.play()
	$musicFreeplay.play()
	$musicFreeplay.volume_db = -25

var currSortSelected = 0
var setScoreDisplay = false
var stringScoreDisplay: String
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("decline"):
		get_tree().change_scene_to_file("res://scenes/charSelect.tscn")
	#if Input.is_action_just_pressed("decline"):
	#	MasterVars.songName = "darnell"
	#	MasterVars.songName = "bf"
	#	get_tree().change_scene_to_file("res://scenes/playScene.tscn")
	#	get_parent().queue_free()
	currHiScoreSmooth += (currHiScore - currHiScoreSmooth) / (0.1 / delta)
	var stringScoreDisplay: String
	for x in 7: # i wrote this all in one attempt ??? i am smart lol
		if x < reverse_string(str(int(currHiScoreSmooth))).length(): 
			stringScoreDisplay = stringScoreDisplay + reverse_string(str(int(currHiScoreSmooth)))[x]
		else: stringScoreDisplay = stringScoreDisplay + "0" 
	$scoreDisplay.scoreDisplay = reverse_string(stringScoreDisplay)
	$musicFreeplay.volume_db += (-6.5 - $musicFreeplay.volume_db) / (0.25/delta) 
	if Input.is_action_just_pressed("ui_up"):
		currSelect -= 1
		scrollMenu()
	elif Input.is_action_just_pressed("ui_down"):
		currSelect += 1
		scrollMenu()
	pass
