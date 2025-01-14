extends RichTextLabel



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if name.contains("glowEffect"):
		text = get_parent().text
