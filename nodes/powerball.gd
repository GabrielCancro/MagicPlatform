extends Node2D

class_name Orb

var PLAYER

@export_enum("fire", "wind", "ice") var type: String
const ORB_COLOR = {"fire":"#ffcf00","wind":"#f0f0f0"}
var time = 0
var velocity = Vector2()
var destine = Vector2()

func _ready():
	PLAYER = get_node("/root/Game/player")
	modulate = ORB_COLOR[type]
	#$Area2D.connect("body_entered",on_enter_body)

#func on_enter_body(body):
	#if body.name=="player":
		#PLAYER.set_orb(self)

func _process(delta: float) -> void:
	var distance = position.distance_to(destine)
	velocity += position.direction_to(destine)*delta*distance*0.05
	velocity *= 0.98
	time += delta
	$Sprite2D.offset.y = sin(time*2)*2
	position += velocity
