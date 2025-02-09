extends Control

const LINES := [
	"written, programmed, and illustrated\nby Remilia \"Snek\" Ketter"
]

func _ready() -> void:
	$White.modulate.a = 0.0
	$Black.modulate.a = 0.0
	$Label.modulate.a = 0.0
	$TextureRect.modulate.a = 0.0
	$White.visible = true
	$Black.visible = true
	$Label.visible = true
	$TextureRect.visible = true
	start()

func start():
	$Black.modulate.a = 1
	$TextureRect.modulate.a = 1
	Sound.play_sfx("credits_gunshot")
	# body drop sfx
	# reverb sfx
	
	await get_tree().create_timer(4.0).timeout
	
	for line : String in LINES:
		
		$Label.text = str("[center]",line,"[/center]")
		
		var fade = create_tween()
		fade.tween_property($Label, "modulate:a", 1.0, 0.0)
		await fade.finished
		
		await get_tree().create_timer(8.0).timeout
		
		fade = create_tween()
		fade.tween_property($Label, "modulate:a", 0.0, 0.0)
		await fade.finished
		
		await get_tree().create_timer(1.0).timeout
	
	var black_tween = create_tween()
	black_tween.tween_property($TextureRect, "modulate:a", 0.0, 6.0)
	await black_tween.finished
	
	await get_tree().create_timer(2.0).timeout
	
	Parser.line_reader.instruction_handler.instruction_completed.emit()
