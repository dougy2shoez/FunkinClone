extends Node2D
var numSprite: Sprite2D
func createClearNum(num: int):
	for x in get_children().size():
		if get_child(x).name != "ClearPercentText":
			get_child(x).queue_free()
	for x in str(num).length():
		numSprite = Sprite2D.new()
		numSprite.texture = load("res://assets/images/ResultsScreen/numberClear/" + rs(str(num))[x] + ".png")
		print("res://assets/images/ResultsScreen/numberClear/" + rs(str(num))[x] + ".png")
		numSprite.position = Vector2(73 + (x*-72), 64)
		add_child(numSprite)
func rs(s:String) -> String:
	var r := "" 
	for i in range(s.length()-1, -1, -1):
		r += s[i]
	return r
