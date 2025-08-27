extends AnimatableBody2D

var is_burning = false

func burn():
	if is_burning: return
	$GPUParticles2D.emitting = true
	var tw = create_tween()
	tw.tween_property(self,"modulate:a",0,.5).set_ease(Tween.EASE_IN).set_delay(2)
	tw.play()
	await tw.finished
	queue_free()
