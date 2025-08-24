extends Node2D
var PLAYER
var time = 0
var velocity = Vector2()
func _ready():
	PLAYER = get_node("/root/Game/player")

func _process(delta: float) -> void:
	time += delta
	var distance = position.distance_to(PLAYER.position)
	velocity += position.direction_to(PLAYER.position + Vector2(0,-20))*delta*distance*0.05
	velocity *= 0.98
	position += velocity
	$Sprite2D.offset.y = sin(time*2)*2
