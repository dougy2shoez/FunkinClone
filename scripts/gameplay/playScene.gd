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
var hueChangeAll = true
var hueChange: Dictionary = {}
var stageChildren
func loadStage(StageName: String):
	print("res://assets/data/stages/" + str(StageName) + ".json")
	stageData = loadJSONfile("res://assets/data/stages/" + str(StageName) + ".json")
	stageScene = load("assets/" + stageData["directory"] + "/" + str(StageName) + ".tscn")
	add_child(stageScene.instantiate())
	if stageData.has("shaderParam"):
		print(stageData["shaderParam"])
		material.set_shader_parameter("hue", stageData["shaderParam"][0])
		material.set_shader_parameter("saturation", stageData["shaderParam"][1])
		material.set_shader_parameter("brightness", stageData["shaderParam"][2])
		material.set_shader_parameter("contrast", stageData["shaderParam"][3])
	elif stageData.has("shaderParams"):
		print("m")
		hueChangeAll = false
		hueChange = stageData["shaderParams"]
		
		
	else: 
		print("no")
		material.set_shader_parameter("hue", 0.0)
		material.set_shader_parameter("saturation", 1.0)
		material.set_shader_parameter("brightness", 1.0)
		material.set_shader_parameter("contrast", 1.0)
# 0.735, 0.85
# 223, 303, y 44.0
# 0.59, 0.725
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
	
	
	



	
