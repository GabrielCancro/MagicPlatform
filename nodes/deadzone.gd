extends Area2D

enum DamageType { COMMON, FIRE }
@export var type: DamageType = DamageType.COMMON

func _ready() -> void:
	connect("body_entered",on_enter_body)

func on_enter_body(body):
	if body.has_method("damage"):
		body.call("damage",type)
