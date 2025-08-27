extends Node2D

func _ready() -> void:
	var level = load("res://levels/Level"+str(GameManager.current_level)+".tscn").instantiate()
	add_child(level)
	get_node("/root/Game/player").global_position = level.get_node("StartPlayer").global_position
	level.get_node("StartPlayer").queue_free()
