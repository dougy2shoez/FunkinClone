extends RichTextLabel



var Score
func _process(delta: float) -> void:
	Big.setDynamicDecimals(true) 
	Big.setThousandSeparator(",")
	Score = get_parent().get_node("NoteConductor").Score[0]
	text = ("Score: " + str(Big.new().formatExponent(int(Score))))
