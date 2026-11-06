extends CharacterBody2D

@export var speed := 500
var can_shoot: bool = true

# creamos una señal para disparar
signal pum(pos)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(500, 500)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# asignamos la señal del disparo al input del espacio
	if Input.is_action_pressed("shoot") and can_shoot:
		pum.emit($BulletStartPos.global_position)
		can_shoot = false
		$CooldownTimer.start()
	
	


func _on_cooldown_timer_timeout() -> void:
	can_shoot = true
