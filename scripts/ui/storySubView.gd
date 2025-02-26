extends CanvasLayer
# 126
@onready var levelDirs = DirAccess.get_files_at("res://assets/data/levels")
@onready var levelData: Array
var difficultySelect = 1
var difficulties: Array = ["easy","normal","hard","erect","nightmare"]
var posCount: int = 0
var curLevelSelect: int = 0
func loadJsonFile(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedSong = JSON.parse_string(dataFile.get_as_text())
		if parsedSong is 	Dictionary: return parsedSong
		else: print("invalid json file")
	else: print("json doesnt exist in specified directory!")
func _ready() -> void:
	for x in levelDirs:
		var curLevelData = loadJsonFile("res://assets/data/levels/" + x)
		levelData.append(curLevelData)
		var weekSprite: Sprite2D = Sprite2D.new()
		weekSprite.texture = load("res://assets/images/" + curLevelData["titleAsset"] + ".png")
		weekSprite.position.y = (posCount * 126)
		weekSprite.name = str(curLevelSelect)
		$text.add_child(weekSprite)
		posCount += 1
func _process(delta: float) -> void:
	if (difficultySelect > 2): difficultySelect = 0
	elif (difficultySelect < 0): difficultySelect = 2
	MasterVars.currDifficult = difficulties[difficultySelect]
	if Input.is_action_pressed("confirm"):
		MasterVars.isStoryMode = true
		MasterVars.songType = ""
		MasterVars.songsPlaylist = levelData[curLevelSelect]["songs"]
		MasterVars.songsPlaylistPos = 0
		MasterVars.songName = levelData[curLevelSelect]["songs"][0]
		get_tree().change_scene_to_file("res://scenes/playScene.tscn")
	if Input.is_action_pressed("ui_left"): $ARRLeft.play("press")
	else: $ARRLeft.play("def") 
	if Input.is_action_pressed("ui_right"): $ARRRight.play("press")
	else: $ARRRight.play("def")
	if Input.is_action_just_pressed("ui_left"):
		difficultySelect -= 1
		$difficult.position.y = 495
		$difficult.modulate.a = 0.35
	elif Input.is_action_just_pressed("ui_right"):
		difficultySelect += 1
		$difficult.position.y = 495
		$difficult.modulate.a = 0.35
	if Input.is_action_just_pressed("ui_up") and not curLevelSelect <= 0:
		curLevelSelect -= 1
		print(curLevelSelect)
	if Input.is_action_just_pressed("ui_down") and not curLevelSelect >= 8:
		curLevelSelect += 1
		print(curLevelSelect)
	$text.position.y += (((0 -curLevelSelect) * 126 + 524) - $text.position.y) / (0.1 / delta)
	$BG.color += ((Color(levelData[curLevelSelect]["background"])) - $BG.color) / (0.2 / delta)
	$difficult.position.y += (523 - $difficult.position.y) / (0.05 / delta)
	$difficult.modulate.a += (1 - $difficult.modulate.a) / (0.05 / delta)
	$difficult.animation = MasterVars.currDifficult
