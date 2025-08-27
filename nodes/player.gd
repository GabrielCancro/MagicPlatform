extends CharacterBody2D

# Variables ajustables
var speed: float = 120.0
var jump_velocity: float = -250.0
var gravity: float = 780
var current_orb
var castTime = 0

func _ready() -> void:
	$AnimatedSprite2D/Fire.play("default")
	$AnimatedSprite2D/Fire/Area2D.connect("body_entered",on_fire_enter_body)
	$AnimatedSprite2D/Fire/Area2D.monitoring = false

func _physics_process(delta: float) -> void:
	if castTime>0: 
		castTime -= delta
		velocity.x *= 0.95

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = min(velocity.y, 0) # Resetea cuando toca el suelo
	
	if castTime<=0:
		# Movimiento horizontal
		var direction := Input.get_axis("left", "right")
		velocity.x = direction * speed

		# Saltar
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity
			
		if Input.is_action_just_pressed("magic"): 
			if current_orb and has_method("cast_spell_"+current_orb.type): 
				call("cast_spell_"+current_orb.type)
		
	# Aplicar el movimiento
	move_and_slide()
	animation()
	if current_orb: current_orb.destine = position + Vector2(0,-20)

func animation():
	if castTime>0:
		$AnimatedSprite2D.play("magic")
	elif is_on_floor() and velocity.x!=0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	if velocity.x>0: $AnimatedSprite2D.scale.x = 1
	if velocity.x<0: $AnimatedSprite2D.scale.x = -1

func cast_spell_fire():
	castTime = 1.5
	$AnimatedSprite2D/Fire.modulate.a = 1
	$AnimatedSprite2D/Fire.visible = true
	$AnimatedSprite2D/Fire/Area2D.monitoring = true
	var tw = create_tween()
	tw.tween_property($AnimatedSprite2D/Fire,"modulate:a",0,1).set_ease(Tween.EASE_IN).set_delay(.5)
	tw.play()
	await tw.finished
	$AnimatedSprite2D/Fire.visible = false
	$AnimatedSprite2D/Fire/Area2D.monitoring = false

func damage(type):
	$GPUParticles2D.emitting = true
	if is_orb("fire") and type == 1: return
	$AnimatedSprite2D.visible = false
	set_physics_process(false)
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()

func set_orb(orb):
	current_orb = orb

func is_orb(type):
	return (current_orb and current_orb.type==type)

func on_fire_enter_body(body):
	if body.has_method("burn"):
		body.call("burn")

func destroy_orb():
	current_orb.queue_free()
	current_orb = null
