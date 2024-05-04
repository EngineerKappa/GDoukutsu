extends Node2D
class_name Caret
@export var velocity:Vector2 = Vector2(0,0)

func cs_velocity(value):
	return ((value * 50)/512)
func cs_acceleration(value):
	return ((value * 50)/512)*50
	
func _ready():
	set_as_top_level(true);
	create()
	
func create():
	pass

func _on_lifetime_timeout():
	queue_free()
	pass # Replace with function body.
