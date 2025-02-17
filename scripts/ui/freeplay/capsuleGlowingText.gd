extends RichTextLabel



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if name.contains("glowEffect"):
		#material.set_shader_parameter('glow_color',get_parent().get_parent().get_parent().get_parent().capsuleColor[0])
		text = get_parent().text
	else:
		$notSelected.text = text
		$songName.text = text
		$songName2.text = text
