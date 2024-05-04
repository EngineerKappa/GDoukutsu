class_name Stage extends Node2D
@export var map_name:String = "Room"
@export_file("*.ogg") var bgm
const UI = preload("res://UI/UI.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = UI.instantiate();
	instance.stage=self;
	add_child(instance);
	pass # Replace with function body.

