extends Node2D
var PLAYER
func _ready():
	PLAYER = get_node("/root/Game/player")

func _process(delta: float) -> void:
	position = PLAYER.position + Vector2(50,0)
