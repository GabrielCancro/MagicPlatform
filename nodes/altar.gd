extends Node2D

@export var altar_type = ""
@export var interrupt = ""

func _ready() -> void:
	$Area2D.connect("body_entered",on_body_enter)

func on_body_enter(body):
	if body.name!="player": return
	if body.is_orb(altar_type):
		$Eyes.visible = true
		body.current_orb.destine = position + Vector2(0,-25)
		var tw = create_tween()
		tw.tween_property(body.current_orb,"modulate:a",0,1).set_ease(Tween.EASE_OUT).set_delay(1)
		tw.play()
		body.set_orb(null)
		GameManager.emit_signal("interruptor_signal",interrupt,altar_type)
		$Area2D.set_deferred("monitoring",false)
