extends CharacterBody2D

# Variables ajustables
var speed: float = 160.0
var jump_velocity: float = -250.0
var gravity: float = 780

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = min(velocity.y, 0) # Resetea cuando toca el suelo

	# Movimiento horizontal
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * speed

	# Saltar
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Aplicar el movimiento
	move_and_slide()
	animation()

func animation():
	if is_on_floor() and velocity.x!=0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	if velocity.x>0: $AnimatedSprite2D.flip_h = false
	elif velocity.x<0: $AnimatedSprite2D.flip_h = true
