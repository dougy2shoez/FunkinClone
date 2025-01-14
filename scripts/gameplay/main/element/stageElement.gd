extends Node2D

func _ready() -> void:
	elementData = get_parent().elementData
	$paralaxEffect/stageElement.texture = load("res://assets/images/stages/" + str(elementData["assetPath"] + ".png"))
	z_index = elementData["zIndex"]
	position.x = elementData["position"][0] + get_parent().stageData["stageOffset"][0]
	position.y = elementData["position"][1] + get_parent().stageData["stageOffset"][1]
	scale.x = elementData["scale"][0]  
	scale.y = elementData["scale"][1] 
	$paralaxEffect.scroll_scale.x = elementData["scroll"][0]	
	$paralaxEffect.scroll_scale.y = elementData["scroll"][1]
	print("res://assets/images/stages/" + str(elementData["assetPath"] + ".png"))
	print(elementData["scroll"][1])
var setStage = false
var elementData
var oneRUN = false
var scroll_x
var scroll_y 
func _process(delta: float) -> void:
	if oneRUN == false:
		oneRUN = true 
	
