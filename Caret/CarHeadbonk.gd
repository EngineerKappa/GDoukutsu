extends Caret
@onready var lifetime = $Lifetime

func create():
	velocity.x=randf_range(-150.0,150)
	velocity.y=randf_range(-50.0,50)

func _process(delta):
	position+=velocity * delta;
	velocity.x=(velocity.x * 4) / 5
	velocity.y=(velocity.y * 4) / 5
	
