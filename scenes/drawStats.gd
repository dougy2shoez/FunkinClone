extends Node2D
var colorMod: Array = [Color(0.537, 0.788, 0.898), Color(0.902, 0.812, 0.541), Color(0.902, 0.549, 0.541),Color(0.776, 0.541, 0.902), Color(0.537, 0.898, 0.62)]
var ind = 0
var comboPos: Array = [171, 222]
var statSmooth = 0.0
var lastSmooth = 0
var shownStats = false
var hasLoadedNumTxtR = false
var NumTxtR: Array
var nextNumTimer = 0.0
var Rating = MasterVars.songStats["rating"]
var statsPos: Array = [Vector2i(226, 352), Vector2i(207, 404), Vector2i(237, 457), Vector2i(276, 514), Vector2i(247, 298)]
func _process(delta: float) -> void:
	
	if not hasLoadedNumTxtR: 
		NumTxtR = readyTextures()
		hasLoadedNumTxtR = true
	if not shownStats and get_parent().get_node("popInText").frame > 8:
		statSmooth += (Rating[Rating.keys()[ind]] - statSmooth) / (0.05 / delta)
		if lastSmooth != int(round(statSmooth)):
			lastSmooth = int(round(statSmooth))
			drawNum(int(round(lastSmooth)), ind, Rating[Rating.keys()[ind]])
		if int(round(statSmooth)) == Rating[Rating.keys()[ind]]: 
			nextNumTimer += delta
			if nextNumTimer > 0.15: 
				ind += 1
				nextNumTimer = 0.0
				statSmooth = 0.0
				if ind == 5: shownStats = true
		
func drawNum(num: int, rating: int, ratingNum: int):  # this took me 2 hours to figure out how to do fully..
	for i in get_children():
		if i.use_parent_material:
			i.queue_free()
	for i in str(num).length():
		var spriteNum: Sprite2D = Sprite2D.new()
		spriteNum.position = statsPos[rating - 1]
		spriteNum.texture = NumTxtR[int(str(num)[i])]
		spriteNum.position.x = statsPos[rating-1].x + (i * 44)
		spriteNum.modulate = colorMod[rating-1]
		spriteNum.use_parent_material = num != ratingNum
		print(num)
		print(ratingNum)
		
		add_child(spriteNum)
func readyTextures() -> Array:
	var txA: Array
	for i in 10:
		txA.append(load("res://assets/images/ResultsScreen/tallieNumber/" + str(i) + ".png"))
		print("res://assets/images/ResultsScreen/tallieNumber/" + str(i) + ".png")
	return txA
