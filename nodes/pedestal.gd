extends Node2D

@export var orb:Node2D
var PLAYER

func _ready() -> void:
	PLAYER = get_node("/root/Game/player")
	$Area2D.connect("body_entered",on_enter_body)
	if orb: 
		orb.destine = position + Vector2(0,-10)
		orb.position = orb.destine
	update_color()

func on_enter_body(body):
	if body==PLAYER:
		var aux = orb
		orb = PLAYER.current_orb
		PLAYER.set_orb(aux)
		if orb: orb.destine = position + Vector2(0,-10)
		update_color()

func update_color():
	if orb: modulate = Color(1,1,1,1)
	else: modulate = Color(.4,.4,.4,1)
