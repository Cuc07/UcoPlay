extends Area2D

var speed: int
var rotation_speed: int
var direction_x: float

signal collision

func _ready():
	
	var rng := RandomNumberGenerator.new()
	
	# hacemos textura random para variar un poco jajaja
	var path: String = "res://graphics/enemies/" + str(rng.randi_range(1,6)) + ".png"
	$Sprite2D.texture = load(path)
	
	# posición incial 
	var width = get_viewport().get_visible_rect().size[0] # size devuleve dos valores (largo, alto), nos quedamos con el primero 
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50) # se generan fuera de la pantalla para evitar que spawneen delante del jugador o algo así
	position = Vector2(random_x, random_y)

	# velocidad aleatoria
	speed = rng.randi_range(200, 500)
	direction_x = rng.randf_range(-1, 1)
	rotation_speed = rng.randi_range(40, 100)


func _process(delta):
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta

func _on_body_entered(_body) -> void:
	collision.emit()

func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
