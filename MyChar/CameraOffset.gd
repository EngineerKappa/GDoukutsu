extends Marker2D
@export var camera_range = 48;
@export var camera_offset : Vector2 = Vector2(0,8)
@onready var camera : Camera2D = Camera2D.new();

func _ready():
	position.x=owner.facing_direction.x*camera_range
	add_child(camera)
	camera.set_as_top_level(true)
	camera.position=global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x=move_toward(position.x,camera_offset.x+camera_range*owner.facing_direction.x,50 * delta)
	position.y=move_toward(position.y,camera_offset.y+camera_range*owner.input_direction.y,50 * delta)
	
	camera.global_position.x=lerp(camera.global_position.x,global_position.x,5 * delta)
	camera.global_position.y=lerp(camera.global_position.y,global_position.y,3 * delta)
	pass
