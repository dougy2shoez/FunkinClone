extends Node2D


# Called when the node enters the scene tree for the first time.
var AtlasData: Dictionary = {"name" = [], "x" = [], "y" = [], "width" = [], "height" = [], "frameX" = [], "frameY" = []}
var setAtlas = false
func _ready() -> void:
	pass
var animFPS = 24.0
var frame = 1
var timeFrame = 0
func _process(delta: float) -> void:
	if setAtlas == false:
		var parser = XMLParser.new()
		parser.open("res://assets/images/stages/battlefield/darnell.xml")
		while parser.read() != ERR_FILE_EOF:
			if parser.get_node_type() == XMLParser.NODE_ELEMENT:
				var node_name = parser.get_node_name()
				var attributes_dict = {}
				AtlasData["name"].append(parser.get_named_attribute_value("name"))
				AtlasData["x"].append(int(parser.get_named_attribute_value("x")))
				AtlasData["y"].append(int(parser.get_named_attribute_value("y")))
				AtlasData["width"].append(int(parser.get_named_attribute_value("width")))
				AtlasData["height"].append(int(parser.get_named_attribute_value("height")))
				AtlasData["frameX"].append(int(parser.get_named_attribute_value("frameX")))
				AtlasData["frameY"].append(int(parser.get_named_attribute_value("frameY")))
		$sprite.texture = AtlasTexture.new()
		$sprite.texture.atlas =  preload("res://assets/images/stages/battlefield/darnell.png")
		setAtlas = true
	if frame > AtlasData["name"].size() - 1:
		frame = 1
		timeFrame = 0
	$sprite.texture.region = Rect2i(AtlasData["x"][frame],AtlasData["y"][frame],AtlasData["width"][frame],AtlasData["height"][frame])
	timeFrame += delta
	if timeFrame > ((1.0 / animFPS) * frame):
		frame += 1
	pass
