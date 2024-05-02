extends Marker2D
@onready var body = $".."
@export var range = 48;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x=move_toward(position.x,range*body.facing_direction.x,30 * delta)
	pass
