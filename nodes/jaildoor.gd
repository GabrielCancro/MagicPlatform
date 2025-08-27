extends AnimatableBody2D
@export var interrupt = ""

func _ready() -> void:
	GameManager.connect("interruptor_signal",on_activate)

func on_activate(key,arg):
	if key!=interrupt: return
	var tw = create_tween()
	tw.tween_property(self,"position:y",position.y-32,2).set_ease(Tween.EASE_OUT).set_delay(1)
	tw.play()
