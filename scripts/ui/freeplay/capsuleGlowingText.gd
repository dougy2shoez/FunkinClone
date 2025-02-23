extends RichTextLabel



func _ready() -> void:
	TextServerManager.get_primary_interface().TextOverrunFlag.OVERRUN_NO_TRIM
	TextServerManager.get_primary_interface().OVERRUN_NO_TRIMMING
	pass

func _process(delta: float) -> void:
	if name.contains("glowEffect"):
		#material.set_shader_parameter('glow_color',get_parent().get_parent().get_parent().get_parent().capsuleColor[0])
		text = get_parent().text
	else:
		$glow.text = text
		$songName.text = text
		$extra/glow.text = text
		$extra/glow2.text = text
