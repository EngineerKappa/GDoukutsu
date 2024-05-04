extends Node2D
class_name Caret
@export var velocity:Vector2 = Vector2(0,0)

func _ready():
	set_as_top_level(true);

func _on_lifetime_timeout():
	queue_free()
	pass # Replace with function body.
