extends Control
@onready var map_name = $CanvasLayer/MapName
var stage : Stage



# Called when the node enters the scene tree for the first time.
func _ready():
	if stage:
		map_name.text = stage.map_name
	else:
		print("UI: Stage not found")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug_reset"):
		get_tree().reload_current_scene()
	pass


func _on_map_name_timer_timeout():
	map_name.queue_free();
	pass # Replace with function body.
