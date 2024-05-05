extends Control
@export var fade_out : bool = true;
const FADE_SPRITE = preload("res://UI/fade_sprite.tscn")
var sprite_list = []
var screen_size = Vector2(424.0,240.0) 
var sprite_amount = ceil( (screen_size.x/16) * (screen_size.y / 16) )


# Called when the node enters the scene tree for the first time.
func _ready():
	var _pos =  Vector2(-8,8)
	while _pos.y < screen_size.y:
		var instance = FADE_SPRITE.instantiate()
		instance.position = _pos;
		instance.fade_out = fade_out;
		
		instance.delay=(_pos.distance_to(screen_size/2))/screen_size.x
		sprite_list.append(instance)
		add_child(instance)
		_pos.x+=16
		if _pos.x>screen_size.x:
			_pos.x=0;
			_pos.y+=16;
	pass # Replace with function body.
