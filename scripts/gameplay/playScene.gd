extends Node2D
@onready var stageElement = preload("res://scenes/stageElement.tscn")
@onready var bfScene: Resource
@onready var gfScene: Resource
@onready var dadScene: Resource
@onready var stageData =  {}
func loadJSONfile(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedData = JSON.parse_string(dataFile.get_as_text())
		if parsedData is  Dictionary: return parsedData
		else: print("invalid stageData!")
	else: print("data doesnt exist in specified directory!")
var checkRun = false
var ArrayCount = 0
var cameraX
var cameraY
var elementData
var stageScene
var packedStage
var stageChildren
func loadStage(StageName: String):
	print("res://assets/data/stages/" + str(StageName) + ".json")
	stageData = loadJSONfile("res://assets/data/stages/" + str(StageName) + ".json")
	stageScene = load("assets/" + stageData["directory"] + "/" + str(StageName) + ".tscn")
	stageChildren = stageScene.instantiate().get_children()
	if stageData.has("shaderParam"):
		material.set("shader_paramater/hue", stageData["shaderParam"][0])
		material.set("shader_paramater/saturation", stageData["shaderParam"][1])
	print(stageChildren)
	for child in stageChildren.size():
		add_child(stageChildren[int(child)].duplicate())
		print(stageChildren[int(child)])


func _process(delta: float) -> void:
	var songName = $UILayer/Conductor.songName

func applyCHARACTERS(bf: String, dad: String, gf: String):
	var gfPos: Array[int]
	bfScene = load("res://scenes/gameplay/characters/" + str(bf) + ".tscn")
	dadScene = load("res://scenes/gameplay/characters/" + str(dad) + ".tscn")
	gfScene = load("res://scenes/gameplay/characters/" + str(gf) + ".tscn")
	add_child(bfScene.instantiate())
	add_child(dadScene.instantiate())
	add_child(gfScene.instantiate())
	
	
	



	
