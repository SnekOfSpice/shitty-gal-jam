extends Control

const LINES := [
	"- written - programmed - illustrated -\n[font_size=16]by[/font_size]\n",
	"- written - programmed - illustrated -\n[font_size=16]by[/font_size]\nRemilia \"Snek\" Ketter",
]

func _ready() -> void:
	$White.modulate.a = 0.0
	$Black.modulate.a = 0.0
	$Black2.modulate.a = 0.0
	$Label.modulate.a = 0.0
	$TextureRect.modulate.a = 0.0
	$White.visible = true
	$Black.visible = true
	$Black2.visible = true
	$Label.visible = true
	$TextureRect.visible = true

func start():
	Options.just_finished_game = true
	$Black.modulate.a = 1
	$Black2.modulate.a = 0
	$TextureRect.modulate.a = 1
	Sound.play_sfx("credits_gunshot")
	Sound.play_bgm("silence")
	# body drop sfx
	# reverb sfx
	
	await get_tree().create_timer(4.0).timeout
	
	var i := 0
	for line : String in LINES:
		
		$Label.text = str("[center]",line,"[/center]")
		
		var fade = create_tween()
		fade.tween_property($Label, "modulate:a", 1.0, 0.0)
		await fade.finished
		
		await get_tree().create_timer(4 if i < LINES.size() - 1 else 8).timeout
		
		if i < LINES.size() - 1:
			fade = create_tween()
			fade.tween_property($Label, "modulate:a", 0.0, 0.0)
			await fade.finished
			
			#await get_tree().create_timer(1.0).timeout
		
		i += 1
	
	var black_tween = create_tween()
	black_tween.tween_property($Black2, "modulate:a", 1.0, 6.0)
	await black_tween.finished
	
	await get_tree().create_timer(2.0).timeout
	
	Parser.line_reader.instruction_handler.instruction_completed.emit()
