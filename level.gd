extends Node2D

# Para que se genere un enemigo cada vez que el timer acabe:
# 1. cargamos la escena
var enemy_scene: PackedScene = load("res://enemy.tscn")
var bullet_scene: PackedScene = load("res://bullet.tscn")

var health: int = 3

func _ready() -> void:
	# iniciamos la vida a 3
	get_tree().call_group('ui', 'set_health', health)

func _on_enemy_timer_timeout() -> void:
	# 2. Creamos una instancia
	var enemy = enemy_scene.instantiate()
	
	# 3. Conectamos el nodo al árbol de la escena
	$Enemies.add_child(enemy)
	
	# conectamos la señal 
	enemy.connect('collision', _on_enemy_collision)


func _on_enemy_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")
	

func _on_player_pum(pos) -> void:
	var bullet = bullet_scene.instantiate()
	$Bullets.add_child(bullet)
	bullet.position = pos
