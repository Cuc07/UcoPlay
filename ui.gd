extends CanvasLayer

static var image = load("res://graphics/player/corazon.png")
var time_elapsed := 0

# reescalamos la imagen
const image_size = Vector2(32, 32) 

func set_health(amount):
	# Desvincula y encola el borrado de inmediato
	for child in $MarginContainer2/HBoxContainer.get_children():
		$MarginContainer2/HBoxContainer.remove_child(child)
		child.queue_free()
	
	# Creamos los nuevos corazones
	for i in amount: 
		var text_rect = TextureRect.new()
		text_rect.texture = image
		text_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		text_rect.custom_minimum_size = image_size
		$MarginContainer2/HBoxContainer.add_child(text_rect)


func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed
