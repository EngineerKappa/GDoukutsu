extends Caret
@onready var lifetime = $Lifetime

func _process(delta):
	if lifetime.wait_time-lifetime.time_left < 0.11:
		position+=velocity * delta;
	pass
